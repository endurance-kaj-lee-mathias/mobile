import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/empty_state.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/agenda/slot_picker_sheet.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_controller.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_models.dart';
import 'package:endurance_mobile_app/services/network/network_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Exported helper so AgendaPage can reuse the same member picker.
void showMemberPickerSheet(BuildContext context) {
  final members = Get.find<NetworkController>().members;
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: members.length,
              itemBuilder: (_, i) {
                final m = members[i];
                return ListTile(
                  leading: UserAvatar(
                    imageUrl: m.image,
                    firstName: m.firstName,
                    radius: 20,
                  ),
                  title: Text(m.displayName),
                  subtitle: Text('@${m.username}'),
                  onTap: () {
                    Navigator.pop(ctx);
                    SlotPickerSheet.show(context, member: m);
                  },
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class AppointmentsTab extends StatelessWidget {
  const AppointmentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final controller = Get.find<CalendarController>();

    return RefreshIndicator(
      onRefresh: controller.loadAppointments,
      child: Obx(() {
        if (controller.isLoadingAppointments.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final now = DateTime.now();
        final upcoming = controller.appointments
            .where((a) => a.startTime.isAfter(now))
            .toList()
          ..sort((a, b) => a.startTime.compareTo(b.startTime));
        final past = controller.appointments
            .where((a) => !a.startTime.isAfter(now))
            .toList()
          ..sort((a, b) => b.startTime.compareTo(a.startTime));

        if (upcoming.isEmpty && past.isEmpty) {
          return EmptyState(
            heroIconPath: HeroIcons.calendarDays,
            title: l10n.agendaEmptyTitle,
            body: l10n.agendaEmptyBody,
            actionLabel: l10n.agendaBookButton,
            onAction: () => showMemberPickerSheet(context),
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            if (upcoming.isNotEmpty) ...[
              SectionHeader(
                label: l10n.agendaUpcoming,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              ),
              ...upcoming.map((a) => _AppointmentCard(
                    appointment: a,
                    isUpcoming: true,
                  )),
            ],
            if (past.isNotEmpty) ...[
              SectionHeader(
                label: l10n.agendaPast,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              ),
              ...past.map((a) => _AppointmentCard(
                    appointment: a,
                    isUpcoming: false,
                  )),
            ],
          ],
        );
      }),
    );
  }

}

class _AppointmentCard extends StatelessWidget {
  final CalendarEventModel appointment;
  final bool isUpcoming;

  const _AppointmentCard({required this.appointment, required this.isUpcoming});

  String _formatTime(DateTime dt) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final apptDay = DateTime(dt.year, dt.month, dt.day);
    final timeStr = DateFormat('HH:mm').format(dt.toLocal());

    if (apptDay == today) return 'Today · $timeStr';
    if (apptDay == tomorrow) return 'Tomorrow · $timeStr';
    return '${DateFormat('EEE d MMM').format(dt.toLocal())} · $timeStr';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: BorderedCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.dustyBlue.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const HeroIcon(
                  HeroIcons.calendarDays,
                  color: AppColors.dustyBlue,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment.title,
                      style: textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        HeroIcon(
                          HeroIcons.clock,
                          size: 13,
                          color: colorScheme.onSurface.withValues(alpha: 0.45),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatTime(appointment.startTime),
                          style: textTheme.bodyMedium?.copyWith(
                            fontSize: 12,
                            color: colorScheme.onSurface.withValues(alpha: 0.55),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isUpcoming)
                IconButton(
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: colorScheme.onSurface.withValues(alpha: 0.4),
                    size: 22,
                  ),
                  onPressed: () => _confirmCancel(context, l10n),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmCancel(BuildContext context, S l10n) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.agendaCancelTitle),
        content: Text(l10n.agendaCancelBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: Text(l10n.agendaCancelConfirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final messenger = ScaffoldMessenger.of(context);
    try {
      await Get.find<CalendarController>().cancelAppointment(appointment.id);
      if (context.mounted) {
        messenger.showSnackBar(SnackBar(
          content: Text(l10n.agendaCancelledSuccess),
          backgroundColor: AppColors.mossGreen,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      messenger.showSnackBar(SnackBar(
        content: Text(l10n.networkErrorGeneric),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
}
