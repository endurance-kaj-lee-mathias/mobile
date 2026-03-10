import 'package:endurance_mobile_app/components/role_chip.dart';
import 'package:endurance_mobile_app/components/user_avatar.dart';
import 'package:endurance_mobile_app/services/network/member_model.dart';
import 'package:flutter/material.dart';

class PersonHeader extends StatelessWidget {
  final String? imageUrl;
  final String? firstName;
  final String displayName;
  final String username;
  final MemberRole role;
  final String? note;
  final Widget actions;

  const PersonHeader({
    super.key,
    required this.imageUrl,
    required this.firstName,
    required this.displayName,
    required this.username,
    required this.role,
    required this.actions,
    this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserAvatar(imageUrl: imageUrl, firstName: firstName ?? '', radius: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '@$username',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(width: 8),
                  RoleChip(role: role),
                ],
              ),
              if (note != null && note!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  '"$note"',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 8),
              actions,
            ],
          ),
        ),
      ],
    );
  }
}

class SectionEmptyText extends StatelessWidget {
  final String text;

  const SectionEmptyText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }
}
