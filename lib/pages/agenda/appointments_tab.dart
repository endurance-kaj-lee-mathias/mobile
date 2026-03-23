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
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
    final userCtrl = Get.find<UserController>();

    return RefreshIndicator(
      onRefresh: controller.loadAppointments,
      child: Obx(() {
        final isHighRisk = userCtrl.user.value?.riskLevel == 'high';

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
          return Column(
            children: [
              if (isHighRisk) const _HighRiskBanner(),
              Expanded(
                child: EmptyState(
                  heroIconPath: HeroIcons.calendarDays,
                  title: l10n.agendaEmptyTitle,
                  body: l10n.agendaEmptyBody,
                  actionLabel: l10n.agendaBookButton,
                  onAction: () => showMemberPickerSheet(context),
                ),
              ),
            ],
          );
        }

        return ListView(
          padding: const EdgeInsets.only(bottom: 100),
          children: [
            if (isHighRisk) const _HighRiskBanner(),
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

class _HighRiskBanner extends StatefulWidget {
  const _HighRiskBanner();

  @override
  State<_HighRiskBanner> createState() => _HighRiskBannerState();
}

class _HighRiskBannerState extends State<_HighRiskBanner> {
  bool _isLoadingSlot = false;

  Future<void> _bookUrgentSlot() async {
    final l10n = S.of(context);
    setState(() => _isLoadingSlot = true);

    SlotModel? slot;
    try {
      slot = await Get.find<CalendarController>().getFirstAvailableUrgentSlot();
    } catch (_) {
      slot = null;
    } finally {
      if (mounted) setState(() => _isLoadingSlot = false);
    }

    if (!mounted) return;

    if (slot == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(l10n.agendaNoUrgentSlots),
        behavior: SnackBarBehavior.floating,
      ));
      return;
    }

    final dateStr = DateFormat('EEE d MMM · HH:mm').format(slot.startTime.toLocal());
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.agendaBookButton),
        content: Text(dateStr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancelLabel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.agendaBookButton),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    try {
      await Get.find<CalendarController>().bookSlot(slot.id, isUrgent: true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.agendaBookedSuccess),
          backgroundColor: AppColors.mossGreen,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l10n.agendaBookError),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: AppColors.warning, width: 4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: AppColors.warning, size: 20),
                const SizedBox(width: 8),
                Text(
                  l10n.agendaHighRiskTitle,
                  style: textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n.agendaHighRiskBody,
              style: textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.go('/chats'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.warning,
                      side: const BorderSide(color: AppColors.warning),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: Text(l10n.agendaTalkToTherapist,
                        style: const TextStyle(fontSize: 13)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isLoadingSlot ? null : _bookUrgentSlot,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.warning,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: _isLoadingSlot
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(l10n.agendaBookUrgentSlot,
                            style: const TextStyle(fontSize: 13)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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

    final iconColor =
        appointment.urgent ? AppColors.warning : AppColors.dustyBlue;
    final iconBg = appointment.urgent
        ? AppColors.warning.withValues(alpha: 0.12)
        : AppColors.dustyBlue.withValues(alpha: 0.12);

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
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: HeroIcon(
                  HeroIcons.calendarDays,
                  color: iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            appointment.title ?? '',
                            style: textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        if (appointment.urgent)
                          Chip(
                            label: Text(
                              l10n.agendaUrgentLabel,
                              style: const TextStyle(
                                  fontSize: 11, color: AppColors.warning),
                            ),
                            backgroundColor:
                                AppColors.warning.withValues(alpha: 0.12),
                            side: BorderSide.none,
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                          ),
                      ],
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
