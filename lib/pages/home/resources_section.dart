import 'package:endurance_mobile_app/app/themes.dart';
import 'package:endurance_mobile_app/components/bordered_card.dart';
import 'package:endurance_mobile_app/components/section_header.dart';
import 'package:endurance_mobile_app/generated/l10n.dart';
import 'package:flutter/material.dart';

class ResourcesSection extends StatelessWidget {
  const ResourcesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);

    final resources = [
      _Resource(
        category: l10n.resourceCategoryMentalHealth,
        categoryColor: AppColors.mossGreen,
        title: l10n.resourceTitle1,
        readTime: l10n.resourceReadTime(3),
      ),
      _Resource(
        category: l10n.resourceCategoryCommunity,
        categoryColor: AppColors.dustyBlue,
        title: l10n.resourceTitle2,
        readTime: l10n.resourceReadTime(5),
      ),
      _Resource(
        category: l10n.resourceCategoryWellbeing,
        categoryColor: const Color(0xFF8F7B6B),
        title: l10n.resourceTitle3,
        readTime: l10n.resourceReadTime(4),
      ),
      _Resource(
        category: l10n.resourceCategoryPhysical,
        categoryColor: const Color(0xFF6B8F71),
        title: l10n.resourceTitle4,
        readTime: l10n.resourceReadTime(6),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(label: l10n.resourcesSectionTitle),
        const SizedBox(height: 12),
        SizedBox(
          height: 148,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: resources.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, i) => _ResourceCard(resource: resources[i]),
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
      child: BorderedCard(
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

  _Resource({
    required this.category,
    required this.categoryColor,
    required this.title,
    required this.readTime,
  });
}
