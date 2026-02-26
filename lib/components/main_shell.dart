import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const MainShell({
    required this.child,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Obx(() {
        final userCtrl = Get.find<UserController>();
        final user = userCtrl.user.value;

        return NavigationBar(
          selectedIndex: selectedIndex,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.go('/home');
              case 1:
                context.go('/chats');
              case 2:
                context.go('/profile');
            }
          },
          destinations: [
            const NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: 'Chats',
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
              label: user?.name ?? 'Profile',
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
