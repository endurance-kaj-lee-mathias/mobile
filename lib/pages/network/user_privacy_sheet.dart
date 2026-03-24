import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:endurance_mobile_app/services/network/privacy_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPrivacySheet extends StatefulWidget {
  final MemberModel member;
  final NetworkController controller;

  const UserPrivacySheet({
    super.key,
    required this.member,
    required this.controller,
  });

  @override
  State<UserPrivacySheet> createState() => _UserPrivacySheetState();
}

class _UserPrivacySheetState extends State<UserPrivacySheet> {
  late Map<SharingResource, bool> _resourceAllowance;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAllowance();
  }

  void _initializeAllowance() {
    final rules = widget.controller.getRulesForViewer(widget.member.id);
    _resourceAllowance = {
      for (final resource in SharingResource.values)
        resource: _isResourceAllowed(resource, rules),
    };
  }

  bool _isResourceAllowed(
    SharingResource resource,
    List<SharingRuleModel> rules,
  ) {
    final rule = rules.firstWhereOrNull((r) => r.resource == resource);
    return rule == null || rule.effect == SharingEffect.allow;
  }

  String _resourceLabel(BuildContext context, SharingResource resource) {
    final l10n = S.of(context);
    return switch (resource) {
      SharingResource.userProfile => l10n.sharingResourceProfile,
      SharingResource.stressScores => l10n.sharingResourceStressScores,
      SharingResource.moodEntries => l10n.sharingResourceMoodEntries,
      SharingResource.calendar => l10n.sharingResourceCalendar,
    };
  }

  Future<void> _savePrivacySetting(
    SharingResource resource,
    bool allowed,
  ) async {
    setState(() => _isLoading = true);
    try {
      final effect = allowed ? SharingEffect.allow : SharingEffect.deny;
      await widget.controller.updateSharingRule(
        widget.member.id,
        resource,
        effect,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                UserAvatar(
                  imageUrl: widget.member.image,
                  firstName: widget.member.firstName,
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.member.displayName,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        S.of(context).networkPrivacySettings,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.lightTextSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: SharingResource.values.map((resource) {
                final isAllowed = _resourceAllowance[resource] ?? true;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _resourceLabel(context, resource),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              isAllowed ? S.of(context).networkPrivacyCanAccess : S.of(context).networkPrivacyCannotAccess,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                  color: isAllowed
                                        ? AppColors.mossGreen
                                        : AppColors.error,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        value: isAllowed,
                        onChanged: _isLoading
                            ? null
                            : (value) {
                                setState(() => _resourceAllowance[resource] =
                                    value);
                                _savePrivacySetting(resource, value);
                              },
                        activeThumbColor: AppColors.mossGreen,
                        activeTrackColor: AppColors.paleSage,
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () {
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mossGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(S.of(context).networkPrivacyDone),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showUserPrivacySheet(
  BuildContext context, {
  required MemberModel member,
  required NetworkController controller,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => UserPrivacySheet(
      member: member,
      controller: controller,
    ),
  );
}
