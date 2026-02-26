import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({
    required this.child,
    super.key,
  });

  static const _tabs = [AppRoutes.home, AppRoutes.chats, AppRoutes.profile];

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
        final user = Get
            .find<UserController>()
            .user
            .value;

        return NavigationBar(
          selectedIndex: selectedIndex,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (index) => context.goNamed(_tabs[index]),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: s.navHome,
            ),
            NavigationDestination(
              icon: const Icon(Icons.chat_bubble_outline),
              selectedIcon: const Icon(Icons.chat_bubble),
              label: s.navChats,
            ),
            NavigationDestination(
              icon: _ProfileNavIcon(
                pictureUrl: user?.image,
                name: user?.name,
                isActive: false,
              ),
              selectedIcon: _ProfileNavIcon(
                pictureUrl: user?.image,
                name: user?.name,
                isActive: true,
              ),
              label: user?.name ?? s.navProfile,
            ),
          ],
        );
      }),
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

    return CircleAvatar(
      radius: 12,
      backgroundColor: color.withValues(alpha: 0.15),
      backgroundImage: pictureUrl != null ? NetworkImage(pictureUrl!) : null,
      child: pictureUrl == null
          ? Text(
              name != null && name!.isNotEmpty ? name![0].toUpperCase() : '?',
              style: TextStyle(
                fontSize: 12,
                color: color,
                fontWeight: FontWeight.w600,
              ),
            )
          : null,
    );
  }
}
