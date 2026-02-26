import 'package:flutter/material.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle), centerTitle: true),
      body: Center(child: Text(l10n.homeWelcome)),
    );
  }
}
