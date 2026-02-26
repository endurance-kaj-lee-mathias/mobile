import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class NetworkPage extends StatelessWidget {
  const NetworkPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.networkTitle), centerTitle: true),
      body: Center(child: Text(l10n.networkSoon)),
    );
  }
}
