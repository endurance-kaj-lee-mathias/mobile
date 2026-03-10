import 'package:endurance_mobile_app/app/router.dart';
import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/daily_check_in_card.dart';
import 'package:endurance_mobile_app/pages/home/mood_trend_card.dart';
import 'package:endurance_mobile_app/pages/home/quick_actions_section.dart';
import 'package:endurance_mobile_app/pages/home/quote_banner.dart';
import 'package:endurance_mobile_app/pages/home/resources_section.dart';
import 'package:endurance_mobile_app/pages/home/support_network_section.dart';
import 'package:endurance_mobile_app/pages/home/upcoming_appointment_card.dart';
import 'package:endurance_mobile_app/services/mood/daily_checkin_controller.dart';
import 'package:endurance_mobile_app/services/user/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Get.find<DailyCheckInController>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final userController = Get.find<UserController>();
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
        children: [
          Obx(() {
            final user = userController.user.value;
            final name = (user?.firstName.isNotEmpty ?? false)
                ? user!.firstName
                : user?.username ?? '';

            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeWelcomePrefix,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.55),
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        name.isEmpty ? '—' : name,
                        style: textTheme.headlineSmall?.copyWith(
                          color: AppColors.mossGreen,
                          fontWeight: FontWeight.w800,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => context.goNamed(AppRoutes.profile),
                  child: UserAvatar.fromUser(user, radius: 28),
                ),
              ],
            );
          }),
          const SizedBox(height: 20),

          const QuoteBanner(),
          const SizedBox(height: 24),

          const DailyCheckInCard(),
          const SizedBox(height: 24),

          const QuickActionsSection(),
          const SizedBox(height: 24),

          const UpcomingAppointmentCard(),
          const SizedBox(height: 24),

          const SupportNetworkSection(),
          const SizedBox(height: 24),

          const MoodTrendCard(),
          const SizedBox(height: 24),

          const ResourcesSection(),
        ],
      ),
    );
  }
}
