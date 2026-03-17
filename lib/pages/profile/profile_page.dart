import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/profile/profile_edit_page.dart';
import 'package:endurance_mobile_app/services/auth/auth_controller.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:endurance_mobile_app/services/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showDeleteConfirmation(BuildContext context, S l10n, AuthController auth, UserController userCtrl) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.profileDeleteTitle, style: const TextStyle(fontWeight: FontWeight.w700)),
        content: Text(l10n.profileDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await _deleteAccount(context, l10n, auth, userCtrl);
            },
            child: Text(
              l10n.profileDeleteAccountButton,
              style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteAccount(BuildContext context, S l10n, AuthController auth, UserController userCtrl) async {
    try {
      await userCtrl.deleteAccount();
      await auth.logout();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.profileDeleteError(e.toString())),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  void _copyUsername(BuildContext context, S l10n, String username) {
    Clipboard.setData(ClipboardData(text: '@$username'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.profileUsernameCopied),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthController>();
    final userCtrl = Get.find<UserController>();
    final l10n = S.of(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profileTitle),
        centerTitle: true,
      ),
      body: Obx(() {
        final user = userCtrl.user.value;

        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final displayPhone = (user.phoneNumber?.isNotEmpty == true)
            ? user.phoneNumber
            : auth.phoneNumber;

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    UserAvatar.fromUser(user, radius: 48),
                    const SizedBox(height: 16),
                    Text(
                      '${user.firstName}${user.lastName != null && user.lastName!.isNotEmpty ? ' ${user.lastName}' : ''}',
                      style: textTheme.headlineSmall?.copyWith(
                        color: AppColors.mossGreen,
                        fontWeight: FontWeight.w800,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    GestureDetector(
                      onTap: () => _copyUsername(context, l10n, user.username),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: colorScheme.onSurface.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '@${user.username}',
                              style: textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.5),
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(width: 4),
                            HeroIcon(
                              HeroIcons.clipboardDocument,
                              size: 13,
                              color: colorScheme.onSurface.withValues(alpha: 0.3),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              if ((user.introduction?.isNotEmpty == true) || (user.about?.isNotEmpty == true)) ...[
                BorderedCard(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (user.introduction?.isNotEmpty == true) ...[
                          SectionHeader(label: l10n.profileSectionIntroduction),
                          const SizedBox(height: 8),
                          Text(
                            user.introduction!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.8),
                              height: 1.5,
                            ),
                          ),
                          if (user.about?.isNotEmpty == true) const SizedBox(height: 20),
                        ],
                        if (user.about?.isNotEmpty == true) ...[
                          SectionHeader(label: l10n.profileSectionAbout),
                          const SizedBox(height: 8),
                          Text(
                            user.about!,
                            style: textTheme.bodyMedium?.copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.8),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],

              BorderedCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      if (auth.email?.isNotEmpty == true)
                        _InfoRow(
                          icon: const HeroIcon(HeroIcons.envelope, size: 20),
                          iconColor: AppColors.dustyBlue,
                          label: l10n.profileLabelEmail,
                          value: auth.email!,
                        ),
                      if (displayPhone?.isNotEmpty == true)
                        _InfoRow(
                          icon: const HeroIcon(HeroIcons.phone, size: 20),
                          iconColor: AppColors.dustyBlue,
                          label: l10n.profileLabelPhone,
                          value: displayPhone!,
                        ),
                      _InfoRow(
                        icon: const HeroIcon(HeroIcons.shieldOutline, size: 20),
                        iconColor: AppColors.mossGreen,
                        label: l10n.profileLabelPrivacy,
                        value: user.isPrivate ? l10n.profilePrivateAccount : l10n.profilePublicAccount,
                      ),
                    ],
                  ),
                ),
              ),

              if (user.address != null) ...[
                const SizedBox(height: 12),
                BorderedCard(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _InfoRow(
                      icon: const HeroIcon(HeroIcons.mapPin, size: 20),
                      iconColor: AppColors.warning,
                      label: l10n.profileLabelAddress,
                      value: _formatAddress(user.address!),
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ProfileEditPage()),
                  ),
                  icon: const HeroIcon(HeroIcons.pencil, size: 18, color: Colors.white),
                  label: Text(l10n.profileEditButton),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: auth.logout,
                  icon: const HeroIcon(HeroIcons.logoutOutline, size: 18),
                  label: Text(l10n.profileSignOut),
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showDeleteConfirmation(context, l10n, auth, userCtrl),
                  icon: const HeroIcon(HeroIcons.trash, size: 18, color: AppColors.error),
                  label: Text(l10n.profileDeleteAccountButton),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  String _formatAddress(AddressModel address) {
    final parts = <String>[];
    if (address.street?.isNotEmpty == true) parts.add(address.street!);
    final cityLine = [
      if (address.locality?.isNotEmpty == true) address.locality!,
      if (address.region?.isNotEmpty == true) address.region!,
      if (address.postalCode?.isNotEmpty == true) address.postalCode!,
    ].join(', ');
    if (cityLine.isNotEmpty) parts.add(cityLine);
    if (address.country?.isNotEmpty == true) parts.add(address.country!);
    return parts.join('\n');
  }
}

class _InfoRow extends StatelessWidget {
  final Widget icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: iconColor),
                child: icon,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
