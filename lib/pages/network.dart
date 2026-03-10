import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/network/invite_model.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  late final NetworkController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<NetworkController>();
    _controller.enterNetworkTab();
  }

  @override
  void dispose() {
    _controller.leaveNetworkTab();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.networkTitle),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.person_add_outlined),
              tooltip: l10n.networkAddToNetwork,
              onPressed: () => _showAddFriendSheet(context),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.networkConnections),
              Obx(() {
                final count = _controller.incoming.length;
                if (count > 0) {
                  return Tab(
                    child: Badge(
                      label: Text('$count'),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 14),
                        child: Text(l10n.networkRequests),
                      ),
                    ),
                  );
                }
                return Tab(text: l10n.networkRequests);
              }),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ConnectionsTab(
              controller: _controller,
              onAddPressed: () => _showAddFriendSheet(context),
            ),
            _RequestsTab(controller: _controller),
          ],
        ),
      ),
    );
  }

  void _showAddFriendSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _AddFriendSheet(controller: _controller),
    );
  }
}

// ─── Connections Tab ──────────────────────────────────────────────────────────

class _ConnectionsTab extends StatelessWidget {
  final NetworkController controller;
  final VoidCallback onAddPressed;

  const _ConnectionsTab({
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
          return _EmptyState(
            icon: Icons.group_outlined,
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
                _SectionHeader(label: group.label),
                ...group.items.map((m) => _MemberTile(
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

// ─── Requests Tab ─────────────────────────────────────────────────────────────

class _RequestsTab extends StatelessWidget {
  final NetworkController controller;

  const _RequestsTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return RefreshIndicator(
      onRefresh: controller.loadInvites,
      child: Obx(() {
        if (controller.isLoadingInvites.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final incoming = controller.incoming;
        final outgoing = controller.outgoing;

        if (incoming.isEmpty && outgoing.isEmpty) {
          return _EmptyState(
            icon: Icons.mail_outline_rounded,
            title: l10n.networkEmptyRequests,
            body: l10n.networkEmptyRequestsBody,
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            _SectionHeader(label: l10n.networkIncoming),
            if (incoming.isEmpty)
              _SectionEmptyText(l10n.networkEmptyIncoming)
            else
              ...incoming.map(
                (inv) =>
                    _IncomingRequestCard(invite: inv, controller: controller),
              ),
            const SizedBox(height: 8),
            _SectionHeader(label: l10n.networkSent),
            if (outgoing.isEmpty)
              _SectionEmptyText(l10n.networkEmptySent)
            else
              ...outgoing.map((inv) => _OutgoingRequestCard(invite: inv)),
          ],
        );
      }),
    );
  }
}

// ─── Member Tile ──────────────────────────────────────────────────────────────

class _MemberTile extends StatelessWidget {
  final MemberModel member;
  final NetworkController controller;

  const _MemberTile({required this.member, required this.controller});

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
      trailing: IconButton(
        icon: const Icon(Icons.person_remove_outlined),
        color: AppColors.error,
        tooltip: l10n.networkRemove,
        onPressed: () => _confirmRemove(context),
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

// ─── Incoming Request Card ────────────────────────────────────────────────────

class _IncomingRequestCard extends StatelessWidget {
  final InviteModel invite;
  final NetworkController controller;

  const _IncomingRequestCard({
    required this.invite,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final sender = invite.sender;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(
                imageUrl: sender.image,
                firstName: sender.firstName,
                radius: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sender.displayName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '@${sender.username}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 8),
                        _RoleChip(role: sender.role),
                      ],
                    ),
                    if (invite.note != null && invite.note!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '"${invite.note}"',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _onDeny(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.error,
                              side: const BorderSide(color: AppColors.error),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(l10n.networkDeny),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _onAccept(context),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(l10n.networkAccept),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAccept(BuildContext context) async {
    final l10n = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final success = await controller.acceptInvite(invite.id);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          success ? l10n.networkAcceptedSuccess : l10n.networkErrorGeneric,
        ),
        backgroundColor: success ? AppColors.mossGreen : AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _onDeny(BuildContext context) async {
    final l10n = S.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final success = await controller.declineInvite(invite.id);
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          success ? l10n.networkDeclinedSuccess : l10n.networkErrorGeneric,
        ),
        backgroundColor: success ? AppColors.mossGreen : AppColors.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// ─── Outgoing Request Card ────────────────────────────────────────────────────

class _OutgoingRequestCard extends StatelessWidget {
  final InviteModel invite;

  const _OutgoingRequestCard({required this.invite});

  @override
  Widget build(BuildContext context) {
    final receiver = invite.receiver;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Theme.of(context).dividerColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              UserAvatar(
                imageUrl: receiver.image,
                firstName: receiver.firstName,
                radius: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      receiver.displayName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          '@${receiver.username}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 8),
                        _RoleChip(role: receiver.role),
                      ],
                    ),
                    if (invite.note != null && invite.note!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        '"${invite.note}"',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 12,
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.4),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          S.of(context).networkPendingLabel,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Add Friend Bottom Sheet ──────────────────────────────────────────────────

class _AddFriendSheet extends StatefulWidget {
  final NetworkController controller;

  const _AddFriendSheet({required this.controller});

  @override
  State<_AddFriendSheet> createState() => _AddFriendSheetState();
}

class _AddFriendSheetState extends State<_AddFriendSheet> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.networkAddToNetwork,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: l10n.networkUsernameLabel,
                hintText: l10n.networkUsernameHint,
                prefixIcon: const Icon(Icons.alternate_email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              textInputAction: TextInputAction.next,
              autocorrect: false,
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return l10n.networkUsernameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _noteController,
              decoration: InputDecoration(
                labelText: l10n.networkNoteOptional,
                hintText: l10n.networkNoteHint,
                prefixIcon: const Icon(Icons.message_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLength: 300,
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
            Obx(() {
              final err = widget.controller.sendError.value;
              if (err == null) return const SizedBox.shrink();
              final msg = switch (err) {
                NetworkInviteError.userNotFound => l10n.networkErrorUserNotFound,
                NetworkInviteError.alreadyConnected =>
                  l10n.networkErrorAlreadyConnected,
                NetworkInviteError.cannotSend => l10n.networkErrorCannotSend,
                NetworkInviteError.generic => l10n.networkErrorGeneric,
              };
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  msg,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 13,
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            Obx(
              () => ElevatedButton(
                onPressed:
                    widget.controller.isSending.value
                        ? null
                        : () => _submit(context),
                child:
                    widget.controller.isSending.value
                        ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                        : Text(l10n.networkSendRequest),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = S.of(context);
    final username = _usernameController.text.trim();
    final note = _noteController.text.trim();
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final success = await widget.controller.sendInvite(
      username,
      note: note.isEmpty ? null : note,
    );

    if (success) {
      nav.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(l10n.networkRequestSentSuccess(username)),
          backgroundColor: AppColors.mossGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────

class _RoleChip extends StatelessWidget {
  final MemberRole role;

  const _RoleChip({required this.role});

  @override
  Widget build(BuildContext context) {
    if (role == MemberRole.unknown) return const SizedBox.shrink();

    final l10n = S.of(context);
    final label = switch (role) {
      MemberRole.support => l10n.networkRoleSupport,
      MemberRole.therapist => l10n.networkRoleTherapist,
      MemberRole.veteran => l10n.networkRoleVeteran,
      MemberRole.unknown => '',
    };
    final color = switch (role) {
      MemberRole.support => AppColors.mossGreen,
      MemberRole.therapist => AppColors.dustyBlue,
      MemberRole.veteran => AppColors.warning,
      MemberRole.unknown => AppColors.softCharcoal,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _SectionEmptyText extends StatelessWidget {
  final String text;

  const _SectionEmptyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.3),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
