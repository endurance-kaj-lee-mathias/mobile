import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/empty_state.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/chat/chat_controller.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class ConnectionsTab extends StatelessWidget {
  final NetworkController controller;
  final VoidCallback onAddPressed;

  const ConnectionsTab({
    super.key,
    required this.controller,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.loadMembers,
      child: Obx(() {
        if (controller.isLoadingMembers.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final members = controller.members;
        if (members.isEmpty) {
          return EmptyState(
            heroIconPath: HeroIcons.userGroupOutline,
            title: S.of(context).networkEmptyConnections,
            body: S.of(context).networkEmptyConnectionsBody,
            actionLabel: S.of(context).networkAddSomeone,
            onAction: onAddPressed,
          );
        }

        final l10n = S.of(context);
        final groups = [
          (label: l10n.networkGroupSupport, items: controller.supportMembers),
          (
            label: l10n.networkGroupTherapists,
            items: controller.therapistMembers,
          ),
          (label: l10n.networkGroupVeterans, items: controller.veteranMembers),
          (label: l10n.networkGroupOther, items: controller.unknownMembers),
        ].where((g) => g.items.isNotEmpty).toList();

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 24),
          itemCount: groups.length,
          itemBuilder: (_, gi) {
            final group = groups[gi];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  label: group.label,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                ),
                ...group.items.map((m) => MemberTile(
                      member: m,
                      controller: controller,
                    )),
                if (gi < groups.length - 1)
                  const Divider(height: 1, thickness: 1),
              ],
            );
          },
        );
      }),
    );
  }
}

class MemberTile extends StatelessWidget {
  final MemberModel member;
  final NetworkController controller;

  const MemberTile({super.key, required this.member, required this.controller});

  Future<void> _openChat(BuildContext context) async {
    final l10n = S.of(context);
    final chatController = Get.find<ChatController>();
    final conv = await chatController.startConversationWith(member);
    if (conv == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.chatOpenError),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      return;
    }
    if (context.mounted) {
      context.pushNamed(
        AppRoutes.chatDetail,
        pathParameters: {'conversationId': conv.id},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: UserAvatar(
        imageUrl: member.image,
        firstName: member.firstName,
      ),
      title: Text(
        member.displayName,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        '@${member.username}',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () => _openChat(context),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const HeroIcon(HeroIcons.chatOutline),
            color: AppColors.mossGreen,
            tooltip: l10n.navChats,
            onPressed: () => _openChat(context),
          ),
          IconButton(
            icon: const HeroIcon(HeroIcons.userMinus),
            color: AppColors.error,
            tooltip: l10n.networkRemove,
            onPressed: () => _confirmRemove(context),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmRemove(BuildContext context) async {
    final l10n = S.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(l10n.networkRemoveTitle),
            content: Text(l10n.networkRemoveBody(member.displayName)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.cancelLabel),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                style: TextButton.styleFrom(foregroundColor: AppColors.error),
                child: Text(l10n.networkRemoveConfirm),
              ),
            ],
          ),
    );

    if (confirm != true) return;

    try {
      await controller.removeMember(member.id);
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.networkRemovedSuccess),
          backgroundColor: AppColors.mossGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on NetworkRemoveNotAllowedError {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.networkErrorCannotRemove),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 6),
        ),
      );
    } catch (_) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.networkErrorGeneric),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
