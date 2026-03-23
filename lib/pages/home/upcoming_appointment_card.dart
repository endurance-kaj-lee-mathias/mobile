import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/hero_icon.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/services/calendar/calendar_models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final CalendarEventModel? appointment;

  const UpcomingAppointmentCard({super.key, this.appointment});

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(label: l10n.upcomingSectionTitle),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => context.goNamed(AppRoutes.agenda),
          child: BorderedCard(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.dustyBlue.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const HeroIcon(
                      HeroIcons.calendarDays,
                      color: AppColors.dustyBlue,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: appointment == null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.agendaUpcomingNoAppointments,
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l10n.agendaNoAppointmentsBody,
                                style: textTheme.bodyMedium?.copyWith(
                                  color: colorScheme.onSurface
                                      .withValues(alpha: 0.55),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment!.title ?? '',
                                style: textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  HeroIcon(
                                    HeroIcons.clock,
                                    size: 13,
                                    color: colorScheme.onSurface
                                        .withValues(alpha: 0.45),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatTime(appointment!.startTime),
                                    style: textTheme.bodyMedium?.copyWith(
                                      fontSize: 12,
                                      color: colorScheme.onSurface
                                          .withValues(alpha: 0.45),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                  ),
                  HeroIcon(
                    HeroIcons.chevronRight,
                    color: colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
