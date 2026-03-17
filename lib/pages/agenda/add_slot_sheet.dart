import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSlotSheet extends StatefulWidget {
  const AddSlotSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const AddSlotSheet(),
    );
  }

  @override
  State<AddSlotSheet> createState() => _AddSlotSheetState();
}

const _durations = [
  Duration(minutes: 30),
  Duration(hours: 1),
  Duration(hours: 1, minutes: 30),
  Duration(hours: 2),
];

String _durationLabel(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes % 60;
  if (h == 0) return '${m}min';
  if (m == 0) return '${h}h';
  return '${h}h$m';
}

class _AddSlotSheetState extends State<AddSlotSheet> {
  DateTime? _date;
  TimeOfDay? _startTime;
  Duration _duration = const Duration(hours: 1);
  bool _recurring = false;
  bool _isLoading = false;

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) setState(() => _startTime = picked);
  }

  DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  Future<void> _submit() async {
    final l10n = S.of(context);
    if (_date == null || _startTime == null) return;

    final start = _combine(_date!, _startTime!);
    final end = start.add(_duration);

    setState(() => _isLoading = true);
    final nav = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final controller = Get.find<CalendarController>();

    try {
      await controller.createSlot(
        start: start,
        end: end,
        isUrgent: false,
        isRecurring: _recurring,
      );

      nav.pop();
      messenger.showSnackBar(SnackBar(
        content: Text(l10n.agendaAddSlotSuccess),
        backgroundColor: AppColors.mossGreen,
        behavior: SnackBarBehavior.floating,
      ));
    } catch (e) {
      messenger.showSnackBar(SnackBar(
        content: Text(l10n.agendaAddSlotError),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
      ));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + bottomInset),
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
            l10n.agendaAddAvailability,
            style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today, size: 18),
            label: Text(
              _date == null
                  ? 'Select date'
                  : '${_date!.day}/${_date!.month}/${_date!.year}',
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: _pickStartTime,
            icon: const Icon(Icons.access_time, size: 18),
            label: Text(
              _startTime == null
                  ? l10n.agendaAddSlotStartTime
                  : _startTime!.format(context),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.agendaAddSlotDuration,
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _durations.map((d) {
              final selected = d == _duration;
              return ChoiceChip(
                label: Text(_durationLabel(d)),
                selected: selected,
                onSelected: (_) => setState(() => _duration = d),
                selectedColor: AppColors.dustyBlue.withValues(alpha: 0.2),
                labelStyle: TextStyle(
                  color: selected ? AppColors.dustyBlue : null,
                  fontWeight: selected ? FontWeight.w600 : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            value: _recurring,
            onChanged: (v) => setState(() => _recurring = v),
            title: Text(l10n.agendaAddSlotRecurring),
            subtitle: Text(l10n.agendaAddSlotRecurringHint,
                style: textTheme.bodySmall),
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: (_date == null || _startTime == null || _isLoading)
                ? null
                : _submit,
            child: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(l10n.agendaAddSlotButton),
          ),
        ],
      ),
    );
  }
}
