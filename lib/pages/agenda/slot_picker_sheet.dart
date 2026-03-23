import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_controller.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_models.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_service.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SlotPickerSheet extends StatefulWidget {
  final MemberModel member;

  const SlotPickerSheet({super.key, required this.member});

  static Future<void> show(BuildContext context, {required MemberModel member}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SlotPickerSheet(member: member),
    );
  }

  @override
  State<SlotPickerSheet> createState() => _SlotPickerSheetState();
}

class _SlotPickerSheetState extends State<SlotPickerSheet> {
  List<SlotModel>? _slots;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  Future<void> _loadSlots() async {
    try {
      final now = DateTime.now();
      final slots = await CalendarService().getSlots(
        from: now,
        to: now.add(const Duration(days: 30)),
        providerId: widget.member.id,
      );
      if (mounted) setState(() { _slots = slots; _isLoading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _isLoading = false; });
    }
  }

  Future<void> _confirmBook(BuildContext context, SlotModel slot) async {
    final l10n = S.of(context);
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
    if (confirmed != true || !context.mounted) return;

    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    try {
      await Get.find<CalendarController>().bookSlot(slot.id, isUrgent: slot.isUrgent);
      nav.pop();
      messenger.showSnackBar(SnackBar(
        content: Text(l10n.agendaBookedSuccess),
        backgroundColor: AppColors.mossGreen,
        behavior: SnackBarBehavior.floating,
      ));
    } catch (e) {
      messenger.showSnackBar(SnackBar(
        content: Text(l10n.agendaBookError),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) {
        return Column(
          children: [
            // Handle
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
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
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
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          '@${widget.member.username}',
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Body
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _error != null
                      ? Center(child: Text(_error!))
                      : _buildSlotList(context, l10n, colorScheme, scrollController),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSlotList(
    BuildContext context,
    S l10n,
    ColorScheme colorScheme,
    ScrollController scrollController,
  ) {
    final available = _slots?.where((s) => !s.isBooked).toList() ?? [];
    if (available.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            l10n.agendaNoSlots,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    // Group by day
    final Map<String, List<SlotModel>> grouped = {};
    for (final slot in available) {
      final key = DateFormat('EEEE, d MMMM').format(slot.startTime.toLocal());
      grouped.putIfAbsent(key, () => []).add(slot);
    }

    // Sort: urgent first, then by start time within each day
    for (final slots in grouped.values) {
      slots.sort((a, b) {
        if (a.isUrgent == b.isUrgent) return a.startTime.compareTo(b.startTime);
        return a.isUrgent ? -1 : 1;
      });
    }

    final days = grouped.keys.toList();
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.only(bottom: 24),
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
            ...slots.map((slot) => _SlotTile(
                  slot: slot,
                  onTap: () => _confirmBook(context, slot),
                )),
          ],
        );
      },
    );
  }
}

class _SlotTile extends StatelessWidget {
  final SlotModel slot;
  final VoidCallback onTap;

  const _SlotTile({required this.slot, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final start = DateFormat('HH:mm').format(slot.startTime.toLocal());
    final end = DateFormat('HH:mm').format(slot.endTime.toLocal());

    final iconColor = slot.isUrgent ? AppColors.warning : AppColors.dustyBlue;
    final iconBg = slot.isUrgent
        ? AppColors.warning.withValues(alpha: 0.15)
        : AppColors.dustyBlue.withValues(alpha: 0.12);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.access_time, size: 20, color: iconColor),
      ),
      title: Text('$start – $end',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              )),
      trailing: slot.isUrgent
          ? Chip(
              label: Text(
                l10n.agendaUrgentLabel,
                style: const TextStyle(fontSize: 11, color: AppColors.warning),
              ),
              backgroundColor: AppColors.warning.withValues(alpha: 0.12),
              side: BorderSide.none,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
            )
          : null,
      onTap: onTap,
    );
  }
}
