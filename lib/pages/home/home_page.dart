import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:endurance_mobile_app/pages/home/daily_check_in_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.homeWelcome, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 16),
          const DailyCheckInCard(),
        ],
      ),
    );
  }
}
