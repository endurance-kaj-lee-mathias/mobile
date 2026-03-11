import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/empty_state.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/chat/chat_controller.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final controller = Get.find<ChatController>();
    final myId = Get.find<UserController>().user.value?.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navChats),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final conversations = controller.conversations;
        if (conversations.isEmpty) {
          return EmptyState(
            heroIconPath: HeroIcons.chatOutline,
            title: l10n.chatsEmptyTitle,
            body: l10n.chatsEmptyBody,
            actionLabel: l10n.navNetwork,
            onAction: () => context.goNamed(AppRoutes.network),
          );
        }

        return RefreshIndicator(
          onRefresh: () async => controller.isLoading.value = false,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 24),
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conv = conversations[index];
              return _ConversationTile(
                conversation: conv,
                myId: myId,
                showDivider: index < conversations.length - 1,
              );
            },
          ),
        );
      }),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final ConversationModel conversation;
  final String myId;
  final bool showDivider;

  const _ConversationTile({
    required this.conversation,
    required this.myId,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final lastMsg = conversation.lastMessage;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => context.pushNamed(
            AppRoutes.chatDetail,
            pathParameters: {'conversationId': conversation.id},
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                UserAvatar(
                  imageUrl: conversation.otherUserImage,
                  firstName: conversation.otherUserFirstName ?? '',
                  radius: 26,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              conversation.displayName,
                              style: textTheme.bodyLarge?.copyWith(
                                fontWeight: conversation.unreadCount > 0
                                    ? FontWeight.w800
                                    : FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (lastMsg != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              _formatTime(lastMsg.createdAt, l10n),
                              style: textTheme.bodySmall?.copyWith(
                                color: conversation.unreadCount > 0
                                    ? colorScheme.primary
                                    : AppColors.mossGreen,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              _lastMessagePreview(lastMsg, l10n),
                              style: textTheme.bodyMedium?.copyWith(
                                color: conversation.unreadCount > 0
                                    ? colorScheme.onSurface
                                    : colorScheme.onSurface
                                        .withValues(alpha: 0.55),
                                fontWeight: conversation.unreadCount > 0
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (conversation.unreadCount > 0) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${conversation.unreadCount}',
                                style: textTheme.labelSmall?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  String _lastMessagePreview(MessageModel? msg, S l10n) {
    if (msg == null) return l10n.chatsNoMessages;
    final isMe = msg.senderId == myId;
    final prefix = isMe
        ? l10n.chatsYou
        : (conversation.otherUserFirstName ?? '');
    return prefix.isEmpty ? msg.content : '$prefix: ${msg.content}';
  }

  String _formatTime(DateTime dt, S l10n) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDay = DateTime(dt.year, dt.month, dt.day);

    if (msgDay == today) return DateFormat.jm().format(dt);
    if (msgDay == yesterday) return l10n.chatsYesterday;
    if (now.difference(dt).inDays < 7) return DateFormat.EEEE().format(dt);
    return DateFormat.yMd().format(dt);
  }
}
