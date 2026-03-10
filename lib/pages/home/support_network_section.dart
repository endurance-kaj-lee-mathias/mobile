import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class SupportNetworkSection extends StatelessWidget {
  const SupportNetworkSection({super.key});

  static const _contacts = [
    _Contact('James R.', 'JR', Color(0xFF6B8F71)),
    _Contact('Lisa K.', 'LK', AppColors.dustyBlue),
    _Contact('Tom H.', 'TH', Color(0xFF8F7B6B)),
    _Contact('Anna M.', 'AM', Color(0xFF7B6B8F)),
  ];

  static const _overflow = 3;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.supportNetworkSectionTitle,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.5),
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._contacts.map((c) => _ContactAvatar(contact: c)),
              _OverflowAvatar(count: _overflow),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactAvatar extends StatelessWidget {
  final _Contact contact;

  const _ContactAvatar({required this.contact});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: contact.color.withValues(alpha: 0.18),
            child: Text(
              contact.initials,
              style: TextStyle(
                color: contact.color,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            contact.name,
            style: textTheme.bodyMedium?.copyWith(fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _OverflowAvatar extends StatelessWidget {
  final int count;

  const _OverflowAvatar({required this.count});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: colorScheme.outlineVariant,
          child: Text(
            '+$count',
            style: TextStyle(
              color: colorScheme.onSurface.withValues(alpha: 0.6),
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          S.of(context).supportNetworkMore,
          style: textTheme.bodyMedium?.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}

class _Contact {
  final String name;
  final String initials;
  final Color color;

  const _Contact(this.name, this.initials, this.color);
}
