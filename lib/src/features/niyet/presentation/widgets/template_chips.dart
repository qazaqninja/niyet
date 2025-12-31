import 'package:flutter/material.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/theme/colors.dart';
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_template.dart';

class TemplateChips extends StatelessWidget {
  const TemplateChips({
    required this.userTemplates,
    required this.onTemplateSelected,
    required this.visible,
    super.key,
  });

  final List<NiyetTemplate> userTemplates;
  final void Function(NiyetTemplate template) onTemplateSelected;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: visible ? null : 0,
        child: visible
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: _buildChips(context),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  List<Widget> _buildChips(BuildContext context) {
    final chips = <Widget>[];

    // Add default templates from localization
    final defaultTemplates = _getDefaultTemplates(context);
    for (final template in defaultTemplates) {
      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: _TemplateChip(
            template: template,
            onTap: () => onTemplateSelected(template),
          ),
        ),
      );
    }

    // Add user templates
    for (final template in userTemplates) {
      chips.add(
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: _TemplateChip(
            template: template,
            onTap: () => onTemplateSelected(template),
          ),
        ),
      );
    }

    return chips;
  }

  List<NiyetTemplate> _getDefaultTemplates(BuildContext context) {
    final loc = context.loc;
    return [
      // Ibadah templates
      NiyetTemplate(
        id: 'default_ibadah_1',
        text: loc.templateIbadah1,
        category: NiyetCategory.ibadah,
        isDefault: true,
      ),
      NiyetTemplate(
        id: 'default_ibadah_2',
        text: loc.templateIbadah2,
        category: NiyetCategory.ibadah,
        isDefault: true,
      ),
      // Akhlaq templates
      NiyetTemplate(
        id: 'default_akhlaq_1',
        text: loc.templateAkhlaq1,
        category: NiyetCategory.akhlaq,
        isDefault: true,
      ),
      NiyetTemplate(
        id: 'default_akhlaq_2',
        text: loc.templateAkhlaq2,
        category: NiyetCategory.akhlaq,
        isDefault: true,
      ),
      // Family templates
      NiyetTemplate(
        id: 'default_family_1',
        text: loc.templateFamily1,
        category: NiyetCategory.family,
        isDefault: true,
      ),
      NiyetTemplate(
        id: 'default_family_2',
        text: loc.templateFamily2,
        category: NiyetCategory.family,
        isDefault: true,
      ),
      // Charity templates
      NiyetTemplate(
        id: 'default_charity_1',
        text: loc.templateCharity1,
        category: NiyetCategory.charity,
        isDefault: true,
      ),
      NiyetTemplate(
        id: 'default_charity_2',
        text: loc.templateCharity2,
        category: NiyetCategory.charity,
        isDefault: true,
      ),
      // Work templates
      NiyetTemplate(
        id: 'default_work_1',
        text: loc.templateWork1,
        category: NiyetCategory.work,
        isDefault: true,
      ),
      NiyetTemplate(
        id: 'default_work_2',
        text: loc.templateWork2,
        category: NiyetCategory.work,
        isDefault: true,
      ),
    ];
  }
}

class _TemplateChip extends StatelessWidget {
  const _TemplateChip({
    required this.template,
    required this.onTap,
  });

  final NiyetTemplate template;
  final VoidCallback onTap;

  Color get _color {
    switch (template.category) {
      case NiyetCategory.ibadah:
        return AppColors.ibadah;
      case NiyetCategory.akhlaq:
        return AppColors.akhlaq;
      case NiyetCategory.family:
        return AppColors.family;
      case NiyetCategory.charity:
        return AppColors.charity;
      case NiyetCategory.work:
        return AppColors.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: _color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _color.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: _color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 180),
              child: Text(
                template.text,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: _color,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
