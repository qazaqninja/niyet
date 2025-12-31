import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/animations.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/theme_cubit.dart';
import '../../domain/entities/niyet.dart';
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_outcome.dart';

class NiyetCard extends StatelessWidget {
  const NiyetCard({required this.niyet, this.onTap, super.key});

  final Niyet niyet;
  final VoidCallback? onTap;

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        // Show Ramadan glow on today's cards during Ramadan
        final showRamadanGlow = themeState.isRamadan && _isToday(niyet.date);

        return AnimatedContainer(
          duration: AppAnimations.standard,
          curve: AppAnimations.curve,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: showRamadanGlow
                ? const [BoxShadow(color: AppColors.ramadanGlow, blurRadius: 12, spreadRadius: 2)]
                : null,
          ),
          child: Hero(
            transitionOnUserGestures: true,
            tag: 'niyet-${niyet.id}',
            child: Card(
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
                          _CategoryChip(category: niyet.category),
                          const Spacer(),
                          if (niyet.forAllah)
                            Icon(
                              Icons.favorite,
                              size: 16,
                              color: AppColors.accent.withValues(alpha: 0.7),
                            ),
                          if (niyet.outcome != null) ...[
                            const SizedBox(width: 8),
                            _OutcomeIndicator(outcome: niyet.outcome!),
                          ],
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(niyet.text, style: Theme.of(context).textTheme.bodyLarge),
                      if (niyet.reflection != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          niyet.reflection!,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({required this.category});

  final NiyetCategory category;

  Color get _color {
    switch (category) {
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        category.label,
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(color: _color, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _OutcomeIndicator extends StatelessWidget {
  const _OutcomeIndicator({required this.outcome});

  final NiyetOutcome outcome;

  Color get _color {
    switch (outcome) {
      case NiyetOutcome.fulfilled:
        return AppColors.fulfilled;
      case NiyetOutcome.tried:
        return AppColors.tried;
      case NiyetOutcome.missed:
        return AppColors.missed;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(color: _color.withValues(alpha: 0.2), shape: BoxShape.circle),
      child: Center(
        child: Text(
          outcome.emoji,
          style: TextStyle(fontSize: 12, color: _color, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
