import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/mood_picker.dart';
import 'package:endurance_mobile_app/services/mood/daily_checkin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckInBottomSheet extends StatefulWidget {
  const CheckInBottomSheet({super.key, required this.parentMessenger});

  final ScaffoldMessengerState parentMessenger;

  @override
  State<CheckInBottomSheet> createState() => _CheckInBottomSheetState();
}

class _CheckInBottomSheetState extends State<CheckInBottomSheet> {
  double _moodScore = 5;
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _moodScore = 5;
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final controller = Get.find<DailyCheckInController>();

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 32,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.dailyCheckInTitle,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),

          MoodPicker(
            score: _moodScore,
            onChanged: (v) => setState(() => _moodScore = v),
          ),
          const SizedBox(height: 16),

          Text(
            l10n.notesLabel,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _notesController,
            maxLength: 500,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: l10n.notesHint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Health permission prompt / confirmation
          Obx(() {
            if (controller.hasHealthPermission.value) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Icon(
                      Icons.watch_rounded,
                      size: 16,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.healthDataIncluded,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            }
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.watch_rounded, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      l10n.healthPermissionBody,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () async => controller.requestHealthPermission(),
                    child: Text(l10n.healthPermissionGrant),
                  ),
                ],
              ),
            );
          }),

          // Submit / cancel row
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.cancelLabel),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Obx(() {
                  final submitting = controller.isSubmitting.value;
                  return ElevatedButton(
                    onPressed: submitting ? null : () => _submit(context),
                    child: submitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.submitLabel),
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final l10n = S.of(context);
    final controller = Get.find<DailyCheckInController>();
    final notes = _notesController.text.trim();

    final ok = await controller.submit(
      moodScore: _moodScore.round(),
      notes: notes.isEmpty ? null : notes,
    );

    if (!context.mounted) return;

    Navigator.of(context).pop();
    widget.parentMessenger.showSnackBar(
      SnackBar(
        content: Text(ok ? l10n.checkInSuccess : l10n.checkInError),
        backgroundColor: ok
            ? AppColors.success
            : Theme.of(context).colorScheme.error,
      ),
    );
  }
}
