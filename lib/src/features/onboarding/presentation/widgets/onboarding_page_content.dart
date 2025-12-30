import 'package:flutter/material.dart';

import '../../../../core/localization/generated/app_localizations.dart';

class OnboardingPageContent extends StatelessWidget {
  const OnboardingPageContent({
    required this.pageIndex,
    super.key,
  });

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final loc = AppLocalizations.of(context)!;

    final pageData = _getPageData(pageIndex, loc);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              pageData.icon,
              size: 56,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 48),
          Text(
            pageData.title,
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            pageData.body,
            style: textTheme.bodyLarge?.copyWith(
              color: textTheme.bodySmall?.color,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  _PageData _getPageData(int index, AppLocalizations loc) {
    switch (index) {
      case 0:
        return _PageData(
          icon: Icons.wb_sunny_outlined,
          title: loc.onboardingWelcomeTitle,
          body: loc.onboardingWelcomeSubtitle,
        );
      case 1:
        return _PageData(
          icon: Icons.favorite_border,
          title: loc.onboardingConceptTitle,
          body: loc.onboardingConceptBody,
        );
      case 2:
        return _PageData(
          icon: Icons.wb_twilight_outlined,
          title: loc.onboardingMorningTitle,
          body: loc.onboardingMorningBody,
        );
      case 3:
        return _PageData(
          icon: Icons.nightlight_outlined,
          title: loc.onboardingEveningTitle,
          body: loc.onboardingEveningBody,
        );
      case 4:
        return _PageData(
          icon: Icons.spa_outlined,
          title: loc.onboardingGetStartedTitle,
          body: loc.onboardingGetStartedBody,
        );
      default:
        return const _PageData(
          icon: Icons.help_outline,
          title: '',
          body: '',
        );
    }
  }
}

class _PageData {
  const _PageData({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;
}
