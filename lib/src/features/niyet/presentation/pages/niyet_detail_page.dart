import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/generated/app_localizations.dart';
import '../../../../core/theme/colors.dart';
import '../../domain/entities/niyet.dart';
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_outcome.dart';
import '../widgets/steppe_landscape_widget.dart';
import '../widgets/sun_moon_widget.dart';

class NiyetDetailPage extends StatefulWidget {
  const NiyetDetailPage({required this.niyet, super.key});

  final Niyet niyet;

  @override
  State<NiyetDetailPage> createState() => _NiyetDetailPageState();
}

class _NiyetDetailPageState extends State<NiyetDetailPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _landscapeSlideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1, curve: Curves.easeOut),
      ),
    );

    // Landscape slides up from bottom
    _landscapeSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    // Start animation after Hero completes
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _isMorning {
    final hour = DateTime.now().hour;
    return hour >= 5 && hour < 17;
  }

  Color _getCategoryColor(NiyetCategory category) {
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

  Color _getOutcomeColor(NiyetOutcome outcome) {
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
    final theme = Theme.of(context);
    final niyet = widget.niyet;
    final categoryColor = _getCategoryColor(niyet.category);
    final locale = Localizations.localeOf(context).languageCode;

    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;

    return Scaffold(
      backgroundColor: _isMorning
          ? const Color(0xFFE8F4FC) // Light sky blue for day
          : const Color(0xFF121212), // Dark to match moon shadow
      extendBody: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          // Steppe landscape at bottom (slides up from bottom)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _landscapeSlideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SteppeLandscapeWidget(height: 200 + bottomPadding),
              ),
            ),
          ),

          // Sun/Moon above landscape
          Positioned(
            left: 0,
            right: 0,
            bottom: bottomPadding + 100,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: const Center(child: SunMoonWidget(size: 160)),
            ),
          ),

          // Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero card header - structure must match NiyetCard for bidirectional animation
                Hero(
                  transitionOnUserGestures: true,
                  tag: 'niyet-${niyet.id}',
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: categoryColor.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  niyet.category.label,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: categoryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              if (niyet.forAllah)
                                Icon(
                                  Icons.favorite,
                                  size: 16,
                                  color: AppColors.accent.withValues(alpha: 0.7),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(niyet.text, style: theme.textTheme.bodyLarge),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Animated content below
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Outcome section
                        if (niyet.outcome != null) ...[
                          _buildSection(
                            theme: theme,
                            child: Row(
                              children: [
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: _getOutcomeColor(niyet.outcome!).withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      niyet.outcome!.emoji,
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: _getOutcomeColor(niyet.outcome!),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.outcome,
                                        style: theme.textTheme.labelMedium?.copyWith(
                                          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        niyet.outcome!.label,
                                        style: theme.textTheme.titleMedium?.copyWith(
                                          color: _getOutcomeColor(niyet.outcome!),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Reflection section
                        if (niyet.reflection != null && niyet.reflection!.isNotEmpty) ...[
                          _buildSection(
                            theme: theme,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.auto_stories_outlined,
                                      size: 20,
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!.reflection,
                                      style: theme.textTheme.labelMedium?.copyWith(
                                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  niyet.reflection!,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    fontStyle: FontStyle.italic,
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        // Metadata section
                        _buildSection(
                          theme: theme,
                          child: Column(
                            children: [
                              _buildMetadataRow(
                                theme: theme,
                                icon: Icons.calendar_today_outlined,
                                label: AppLocalizations.of(context)!.date,
                                value: DateFormat.yMMMMd(locale).format(niyet.date),
                              ),
                              const SizedBox(height: 12),
                              _buildMetadataRow(
                                theme: theme,
                                icon: Icons.access_time_outlined,
                                label: AppLocalizations.of(context)!.created,
                                value: DateFormat.jm(locale).format(niyet.createdAt),
                              ),
                            ],
                          ),
                        ),

                        // Bottom padding for sun/moon visibility
                        const SizedBox(height: 260),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required ThemeData theme, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _buildMetadataRow({
    required ThemeData theme,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.onSurface.withValues(alpha: 0.5)),
        const SizedBox(width: 12),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        const Spacer(),
        Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
