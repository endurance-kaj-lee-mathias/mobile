import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/empty_state.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/agenda/add_slot_sheet.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_controller.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AvailabilityTab extends StatelessWidget {
  const AvailabilityTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final controller = Get.find<CalendarController>();

    return RefreshIndicator(
      onRefresh: controller.loadMySlots,
      child: Obx(() {
        if (controller.isLoadingMySlots.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.mySlots.isEmpty) {
          return EmptyState(
            heroIconPath: HeroIcons.calendarDays,
            title: l10n.agendaEmptyAvailability,
            body: l10n.agendaEmptyAvailabilityBody,
            actionLabel: l10n.agendaAddAvailability,
            onAction: () => AddSlotSheet.show(context),
          );
        }

        // Group by day
        final Map<String, List<SlotModel>> grouped = {};
        for (final slot in controller.mySlots) {
          final key = DateFormat('EEEE, d MMMM').format(slot.startTime.toLocal());
          grouped.putIfAbsent(key, () => []).add(slot);
        }
        final days = grouped.keys.toList();

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 100),
          itemCount: days.length,
          itemBuilder: (_, i) {
            final day = days[i];
            final slots = grouped[day]!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(
                  label: day,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                ),
                ...slots.map((s) => _SlotItem(slot: s)),
              ],
            );
          },
        );
      }),
    );
  }
}

class _SlotItem extends StatelessWidget {
  final SlotModel slot;

  const _SlotItem({required this.slot});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final start = DateFormat('HH:mm').format(slot.startTime.toLocal());
    final end = DateFormat('HH:mm').format(slot.endTime.toLocal());
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: slot.isBooked
              ? colorScheme.onSurface.withValues(alpha: 0.08)
              : AppColors.dustyBlue.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.access_time,
          size: 20,
          color: slot.isBooked
              ? colorScheme.onSurface.withValues(alpha: 0.3)
              : AppColors.dustyBlue,
        ),
      ),
      title: Text(
        '$start – $end',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: slot.isBooked
                  ? colorScheme.onSurface.withValues(alpha: 0.4)
                  : null,
            ),
      ),
      subtitle: _StatusChip(
        label: slot.isBooked ? l10n.agendaSlotBooked : l10n.agendaSlotAvailable,
        isBooked: slot.isBooked,
      ),
      trailing: slot.isBooked
          ? null
          : IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              onPressed: () => _confirmDelete(context, l10n),
            ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, S l10n) async {
    final controller = Get.find<CalendarController>();
    final messenger = ScaffoldMessenger.of(context);

    if (slot.seriesId != null) {
      final choice = await showDialog<String>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.agendaSlotDeleteSeriesTitle),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'single'),
              child: Text(l10n.agendaSlotDeleteThisOnly),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, 'series'),
              child: Text(l10n.agendaSlotDeleteAllSeries),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.cancelLabel),
            ),
          ],
        ),
      );
      if (choice == null || !context.mounted) return;

      try {
        if (choice == 'series') {
          await controller.deleteSlotSeries(slot.seriesId!);
        } else {
          await controller.deleteSlot(slot.id);
        }
        if (context.mounted) {
          messenger.showSnackBar(SnackBar(
            content: Text(l10n.agendaSlotDeletedSuccess),
            backgroundColor: AppColors.mossGreen,
            behavior: SnackBarBehavior.floating,
          ));
        }
      } catch (e) {
        if (context.mounted) {
          messenger.showSnackBar(SnackBar(
            content: Text(l10n.networkErrorGeneric),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ));
        }
      }
    } else {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.agendaSlotDeleteTitle),
          content: Text(l10n.agendaSlotDeleteBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(l10n.cancelLabel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              style: TextButton.styleFrom(foregroundColor: AppColors.error),
              child: Text(l10n.agendaSlotDeleteConfirm),
            ),
          ],
        ),
      );
      if (confirmed != true || !context.mounted) return;

      try {
        await controller.deleteSlot(slot.id);
        if (context.mounted) {
          messenger.showSnackBar(SnackBar(
            content: Text(l10n.agendaSlotDeletedSuccess),
            backgroundColor: AppColors.mossGreen,
            behavior: SnackBarBehavior.floating,
          ));
        }
      } catch (e) {
        if (context.mounted) {
          messenger.showSnackBar(SnackBar(
            content: Text(l10n.networkErrorGeneric),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ));
        }
      }
    }
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final bool isBooked;

  const _StatusChip({required this.label, required this.isBooked});

  @override
  Widget build(BuildContext context) {
    final color = isBooked
        ? Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3)
        : AppColors.mossGreen;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
