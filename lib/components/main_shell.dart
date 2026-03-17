import 'dart:io';

import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/chat/chat_controller.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({
    required this.child,
    super.key,
  });

  static const _tabs = [
    AppRoutes.home,
    AppRoutes.chats,
    AppRoutes.network,
    AppRoutes.agenda,
    AppRoutes.profile,
  ];

  int _selectedIndex(BuildContext context) {
    final name = GoRouterState
        .of(context)
        .topRoute
        ?.name ?? '';
    final index = _tabs.indexOf(name);
    return index < 0 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: Obx(() {
        final selectedIndex = _selectedIndex(context);
        final user = Get.find<UserController>().user.value;
        final incomingCount =
            Get.find<NetworkController>().incoming.length;
        final unreadChats = Get.find<ChatController>().totalUnreadCount;

        void onTab(int index) => context.goNamed(_tabs[index]);

        if (Platform.isIOS) {
          return CupertinoTabBar(
            currentIndex: selectedIndex,
            onTap: onTab,
            activeColor: Theme.of(context).colorScheme.primary,
            items: [
              BottomNavigationBarItem(
                icon: const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: HeroIcon(HeroIcons.homeOutline),
                ),
                activeIcon: const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: HeroIcon(HeroIcons.homeSolid),
                ),
                label: s.navHome,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _BadgedIcon(
                    icon: HeroIcons.chatOutline,
                    count: unreadChats,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _BadgedIcon(
                    icon: HeroIcons.chatSolid,
                    count: unreadChats,
                  ),
                ),
                label: s.navChats,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _BadgedIcon(
                    icon: HeroIcons.userGroupOutline,
                    count: incomingCount,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _BadgedIcon(
                    icon: HeroIcons.userGroupSolid,
                    count: incomingCount,
                  ),
                ),
                label: s.navNetwork,
              ),
              BottomNavigationBarItem(
                icon: const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: HeroIcon(HeroIcons.calendarOutline),
                ),
                activeIcon: const Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: HeroIcon(HeroIcons.calendarSolid),
                ),
                label: s.navAgenda,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _ProfileNavIcon(
                    pictureUrl: user?.image,
                    name: user?.firstName,
                    isActive: false,
                  ),
                ),
                activeIcon: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: _ProfileNavIcon(
                    pictureUrl: user?.image,
                    name: user?.firstName,
                    isActive: true,
                  ),
                ),
                label: user?.firstName ?? s.navProfile,
              ),
            ],
          );
        }

        return NavigationBar(
          selectedIndex: selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: onTab,
          destinations: [
            NavigationDestination(
              icon: const HeroIcon(HeroIcons.homeOutline),
              selectedIcon: const HeroIcon(HeroIcons.homeSolid),
              label: s.navHome,
            ),
            NavigationDestination(
              icon: _BadgedIcon(
                icon: HeroIcons.chatOutline,
                count: unreadChats,
              ),
              selectedIcon: _BadgedIcon(
                icon: HeroIcons.chatSolid,
                count: unreadChats,
              ),
              label: s.navChats,
            ),
            NavigationDestination(
              icon: _BadgedIcon(
                icon: HeroIcons.userGroupOutline,
                count: incomingCount,
              ),
              selectedIcon: _BadgedIcon(
                icon: HeroIcons.userGroupSolid,
                count: incomingCount,
              ),
              label: s.navNetwork,
            ),
            NavigationDestination(
              icon: const HeroIcon(HeroIcons.calendarOutline),
              selectedIcon: const HeroIcon(HeroIcons.calendarSolid),
              label: s.navAgenda,
            ),
            NavigationDestination(
              icon: _ProfileNavIcon(
                pictureUrl: user?.image,
                name: user?.firstName,
                isActive: false,
              ),
              selectedIcon: _ProfileNavIcon(
                pictureUrl: user?.image,
                name: user?.firstName,
                isActive: true,
              ),
              label: user?.firstName ?? s.navProfile,
            ),
          ],
        );
      }),
    );
  }
}

class _BadgedIcon extends StatelessWidget {
  final String icon;
  final int count;

  const _BadgedIcon({required this.icon, required this.count});

  @override
  Widget build(BuildContext context) {
    return Badge(
      isLabelVisible: count > 0,
      label: Text('$count'),
      child: HeroIcon(icon),
    );
  }
}

class _ProfileNavIcon extends StatelessWidget {
  final String? pictureUrl;
  final String? name;
  final bool isActive;

  const _ProfileNavIcon({this.pictureUrl, this.name, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurfaceVariant;

    final initial = Text(
      name != null && name!.isNotEmpty ? name![0].toUpperCase() : '?',
      style: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );

    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withValues(alpha: 0.15),
      child: pictureUrl != null
          ? ClipOval(
        child: Image.network(
          pictureUrl!,
          width: 24,
          height: 24,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => initial,
              ),
            )
          : initial,
    );
  }
}
