import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final userCtrl = Get.find<UserController>();
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const HeroIcon(HeroIcons.logoutOutline),
            onPressed: auth.logout,
          ),
        ],
      ),
      body: Obx(() {
        final user = userCtrl.user.value;

        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserAvatar(user: user, radius: 48),
              const SizedBox(height: 16),
              if (user != null) ...[
                Text(
                  "${user.firstName}${user.lastName != null && user.lastName!.isNotEmpty ? ' ${user.lastName}' : ''}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  '@${user.username}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}
