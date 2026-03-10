import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/empty_state.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/network/person_header.dart';
import 'package:endurance_mobile_app/services/network/invite_model.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestsTab extends StatelessWidget {
  final NetworkController controller;

  const RequestsTab({super.key, required this.controller});

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
          return EmptyState(
            heroIconPath: HeroIcons.envelope,
            title: l10n.networkEmptyRequests,
            body: l10n.networkEmptyRequestsBody,
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            SectionHeader(
              label: l10n.networkIncoming,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            ),
            if (incoming.isEmpty)
              SectionEmptyText(l10n.networkEmptyIncoming)
            else
              ...incoming.map(
                (inv) => IncomingRequestCard(
                  invite: inv,
                  controller: controller,
                ),
              ),
            const SizedBox(height: 8),
            SectionHeader(
              label: l10n.networkSent,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            ),
            if (outgoing.isEmpty)
              SectionEmptyText(l10n.networkEmptySent)
            else
              ...outgoing.map((inv) => OutgoingRequestCard(invite: inv)),
          ],
        );
      }),
    );
  }
}

class IncomingRequestCard extends StatelessWidget {
  final InviteModel invite;
  final NetworkController controller;

  const IncomingRequestCard({
    super.key,
    required this.invite,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final sender = invite.sender;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: BorderedCard(
        radius: 12,
        borderColor: Theme.of(context).dividerColor,
        borderWidth: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: PersonHeader(
            imageUrl: sender.image,
            firstName: sender.firstName,
            displayName: sender.displayName,
            username: sender.username,
            role: sender.role,
            note: invite.note,
            actions: Row(
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

class OutgoingRequestCard extends StatelessWidget {
  final InviteModel invite;

  const OutgoingRequestCard({super.key, required this.invite});

  @override
  Widget build(BuildContext context) {
    final receiver = invite.receiver;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: BorderedCard(
        radius: 12,
        borderColor: Theme.of(context).dividerColor,
        borderWidth: 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: PersonHeader(
            imageUrl: receiver.image,
            firstName: receiver.firstName,
            displayName: receiver.displayName,
            username: receiver.username,
            role: receiver.role,
            note: invite.note,
            actions: Row(
              children: [
                HeroIcon(
                  HeroIcons.clock,
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
          ),
        ),
      ),
    );
  }
}
