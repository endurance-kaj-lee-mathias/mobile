import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/chat/chat_controller.dart';
import 'package:endurance_mobile_app/services/chat/chat_models.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatDetailPage extends StatefulWidget {
  final String conversationId;

  const ChatDetailPage({super.key, required this.conversationId});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _inputController = TextEditingController();
  final _scrollController = ScrollController();
  final _isSending = false.obs;
  bool _loadError = false;
  bool _loadingMessages = false;

  late final ChatController _chat;
  late final String _currentUserId;

  /// Snapshot of the first unread message timestamp captured before markAsRead.
  DateTime? _firstUnreadAt;

  @override
  void initState() {
    super.initState();
    _chat = Get.find<ChatController>();
    _currentUserId = Get.find<UserController>().user.value?.id ?? '';
    _chat.activeConversationId = widget.conversationId;
    final conv = _chat.conversations
        .firstWhereOrNull((c) => c.id == widget.conversationId);
    if (conv != null && conv.unreadCount > 0) {
      _firstUnreadAt = conv.firstUnreadAt;
    }
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    if (!mounted) return;
    setState(() {
      _loadingMessages = true;
      _loadError = false;
    });
    try {
      await _chat.loadMessages(widget.conversationId);
      if (!mounted) return;
      setState(() => _loadingMessages = false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _chat.markAsRead(widget.conversationId);
        _scrollAfterLoad();
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _loadingMessages = false;
          _loadError = true;
        });
      }
    }
  }

  void _scrollAfterLoad() {
    if (!_scrollController.hasClients) return;
    if (_firstUnreadAt != null) {
      _scrollToFirstUnread();
    } else {
      _scrollToBottom();
    }
  }

  void _scrollToFirstUnread() {
    if (!_scrollController.hasClients) return;
    final messages = _chat.messagesFor(widget.conversationId);
    final firstUnreadIdx =
        messages.indexWhere((m) => !m.createdAt.isBefore(_firstUnreadAt!));
    if (firstUnreadIdx <= 0) {
      _scrollToBottom();
      return;
    }
    // Approximate scroll: each message ~72px, date divider ~48px.
    // Show one message of context above the first unread message.
    final unreadCount = messages.length - firstUnreadIdx;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final target = (maxScroll - unreadCount * 72.0 - 48.0).clamp(0.0, maxScroll);
    _scrollController.jumpTo(target);
  }

  void _scrollToBottom({bool animate = false}) {
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position.maxScrollExtent;
    if (animate) {
      _scrollController.animateTo(
        pos,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.jumpTo(pos);
    }
  }

  Future<void> _sendMessage() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    _inputController.clear();
    _isSending.value = true;
    await _chat.sendMessage(widget.conversationId, text);
    _isSending.value = false;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollToBottom(animate: true),
    );
  }

  @override
  void dispose() {
    if (_chat.activeConversationId == widget.conversationId) {
      _chat.activeConversationId = null;
    }
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final conv = _chat.conversations
        .firstWhereOrNull((c) => c.id == widget.conversationId);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        titleSpacing: 0,
        title: Row(
          children: [
            UserAvatar(
              imageUrl: conv?.otherUserImage,
              firstName: conv?.otherUserFirstName ?? '',
              radius: 18,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                conv?.displayName ?? '',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList(l10n)),
          _buildInputBar(l10n),
        ],
      ),
    );
  }

  Widget _buildMessageList(S l10n) {
    if (_loadError) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.chatLoadingError),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _loadMessages,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_loadingMessages) {
      return const Center(child: CircularProgressIndicator());
    }

    return Obx(() {
      final messages = _chat.messagesFor(widget.conversationId);

      if (messages.isEmpty) {
        return Center(
          child: Text(
            l10n.chatsSayHi,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.4),
                ),
          ),
        );
      }

      // Scroll to bottom when new messages arrive.
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollToBottom(animate: true),
      );      return ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          final isOwn = msg.senderId == _currentUserId;
          final showDate = index == 0 ||
              !_isSameDay(messages[index - 1].createdAt, msg.createdAt);

          final showUnreadDivider = _firstUnreadAt != null &&
              !msg.createdAt.isBefore(_firstUnreadAt!) &&
              (index == 0 ||
                  messages[index - 1].createdAt.isBefore(_firstUnreadAt!));

          return Column(
            children: [
              if (showDate) _DateDivider(date: msg.createdAt, l10n: l10n),
              if (showUnreadDivider && !showDate)
                _UnreadDivider(since: _firstUnreadAt!, l10n: l10n),
              _MessageBubble(message: msg, isOwn: isOwn),
            ],
          );
        },
      );
    });
  }

  Widget _buildInputBar(S l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    // Use viewPadding (not viewInsets) so we always account for the home
    // indicator / nav bar, regardless of keyboard state.
    final bottomPad = MediaQuery.viewPaddingOf(context).bottom;
    return Container(
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8 + bottomPad),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outlineVariant,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _inputController,
              textCapitalization: TextCapitalization.sentences,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: l10n.chatInputHint,
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                filled: true,
                fillColor: colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
              onSubmitted: (_) => _sendMessage(),
            ),
          ),
          const SizedBox(width: 8),
          Obx(
            () => _isSending.value
                ? const SizedBox(
                    width: 40,
                    height: 40,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  )
                : IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(Icons.send_rounded),
                    color: AppColors.mossGreen,
                    style: IconButton.styleFrom(
                      backgroundColor:
                          AppColors.mossGreen.withValues(alpha: 0.12),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isOwn;

  const _MessageBubble({required this.message, required this.isOwn});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bgColor = isOwn
        ? AppColors.mossGreen
        : colorScheme.surfaceContainerHighest;
    final textColor = isOwn ? Colors.white : colorScheme.onSurface;

    return Align(
      alignment: isOwn ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.72,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isOwn ? 18 : 4),
            bottomRight: Radius.circular(isOwn ? 4 : 18),
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isOwn ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.content,
              style: textTheme.bodyMedium?.copyWith(color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat.jm().format(message.createdAt),
              style: textTheme.bodySmall?.copyWith(
                color: textColor.withValues(alpha: 0.6),
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  final DateTime date;
  final S l10n;

  const _DateDivider({required this.date, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final msgDay = DateTime(date.year, date.month, date.day);

    String label;
    if (msgDay == today) {
      label = l10n.chatsToday;
    } else if (msgDay == yesterday) {
      label = l10n.chatsYesterday;
    } else {
      label = DateFormat.yMMMd().format(date);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.45),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }
}

class _UnreadDivider extends StatelessWidget {
  final DateTime since;
  final S l10n;

  const _UnreadDivider({required this.since, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final time = DateFormat.Hm().format(since);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Divider(color: colorScheme.primary.withValues(alpha: 0.5)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              l10n.chatUnreadSince(time),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Expanded(
            child: Divider(color: colorScheme.primary.withValues(alpha: 0.5)),
          ),
        ],
      ),
    );
  }
}
