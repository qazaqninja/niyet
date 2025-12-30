import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../domain/entities/niyyah.dart';
import '../../domain/entities/niyyah_outcome.dart';

class NiyyahCard extends StatelessWidget {
  const NiyyahCard({
    required this.niyyah,
    this.onTap,
    super.key,
  });

  final Niyyah niyyah;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _CategoryChip(category: niyyah.category),
                  const Spacer(),
                  if (niyyah.forAllah)
                    Icon(
                      Icons.favorite,
                      size: 16,
                      color: AppColors.accent.withValues(alpha: 0.7),
                    ),
                  if (niyyah.outcome != null) ...[
                    const SizedBox(width: 8),
                    _OutcomeIndicator(outcome: niyyah.outcome!),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Text(
                niyyah.text,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              if (niyyah.reflection != null) ...[
                const SizedBox(height: 8),
                Text(
                  niyyah.reflection!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final dynamic category;

  Color get _color {
    switch (category.index) {
      case 0:
        return AppColors.ibadah;
      case 1:
        return AppColors.akhlaq;
      case 2:
        return AppColors.family;
      case 3:
        return AppColors.charity;
      case 4:
        return AppColors.work;
      default:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: _color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _OutcomeIndicator extends StatelessWidget {
  const _OutcomeIndicator({required this.outcome});

  final NiyyahOutcome outcome;

  Color get _color {
    switch (outcome) {
      case NiyyahOutcome.fulfilled:
        return AppColors.fulfilled;
      case NiyyahOutcome.tried:
        return AppColors.tried;
      case NiyyahOutcome.missed:
        return AppColors.missed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          outcome.emoji,
          style: TextStyle(
            fontSize: 12,
            color: _color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
