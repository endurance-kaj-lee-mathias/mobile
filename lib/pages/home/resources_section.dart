import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ResourcesSection extends StatelessWidget {
  const ResourcesSection({super.key});

  static const _resources = [
    _Resource(
      category: 'Mental Health',
      categoryColor: AppColors.mossGreen,
      title: 'Managing Anxiety\nin Everyday Life',
      readTime: '3 min read',
    ),
    _Resource(
      category: 'Community',
      categoryColor: AppColors.dustyBlue,
      title: 'Finding Your\nVeterans Group',
      readTime: '5 min read',
    ),
    _Resource(
      category: 'Wellbeing',
      categoryColor: Color(0xFF8F7B6B),
      title: 'Sleep Techniques\nfor Veterans',
      readTime: '4 min read',
    ),
    _Resource(
      category: 'Physical',
      categoryColor: Color(0xFF6B8F71),
      title: 'Exercise as a\nHealing Tool',
      readTime: '6 min read',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.resourcesSectionTitle,
          style: textTheme.labelMedium?.copyWith(
            color: colorScheme.onSurface.withValues(alpha: 0.5),
            letterSpacing: 1.2,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 148,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _resources.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, i) => _ResourceCard(resource: _resources[i]),
          ),
        ),
      ],
    );
  }
}

class _ResourceCard extends StatelessWidget {
  final _Resource resource;

  const _ResourceCard({required this.resource});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 160,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: colorScheme.outlineVariant, width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: resource.categoryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    resource.category,
                    style: TextStyle(
                      color: resource.categoryColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    resource.title,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  resource.readTime,
                  style: textTheme.bodyMedium?.copyWith(
                    fontSize: 11,
                    color: colorScheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Resource {
  final String category;
  final Color categoryColor;
  final String title;
  final String readTime;

  const _Resource({
    required this.category,
    required this.categoryColor,
    required this.title,
    required this.readTime,
  });
}
