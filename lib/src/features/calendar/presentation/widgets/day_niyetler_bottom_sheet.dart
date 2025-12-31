import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/router/router.dart';
import '../../../../core/utils/dialogs.dart';
import '../../../niyet/domain/entities/niyet.dart';
import '../../../niyet/presentation/pages/niyet_detail_page.dart';
import '../../../niyet/presentation/widgets/niyet_card.dart';

/// Shows the day niyetler dialog with scale/fade animation.
void showDayNiyetlerSheet({
  required BuildContext context,
  required DateTime date,
  required List<Niyet> niyetler,
  void Function(String id)? onDelete,
}) {
  showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black54,
    transitionDuration: const Duration(milliseconds: 250),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curve = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );
      return ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1.0).animate(curve),
        child: FadeTransition(opacity: curve, child: child),
      );
    },
    pageBuilder: (context, animation, secondaryAnimation) {
      return _DayNiyetlerDialog(
        date: date,
        niyetler: niyetler,
        onDelete: onDelete,
      );
    },
  );
}

class _DayNiyetlerDialog extends StatelessWidget {
  const _DayNiyetlerDialog({
    required this.date,
    required this.niyetler,
    this.onDelete,
  });

  final DateTime date;
  final List<Niyet> niyetler;
  final void Function(String id)? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final dateText = DateFormat.MMMMEEEEd(locale).format(date);
    final screenSize = MediaQuery.of(context).size;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenSize.width * 0.9,
          maxHeight: screenSize.height * 0.7,
        ),
        child: Material(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dateText,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            context.loc.niyetCount(niyetler.length),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      style: IconButton.styleFrom(
                        foregroundColor: theme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // Content
              Flexible(
                child: niyetler.isEmpty
                    ? const _EmptyState()
                    : _NiyetlerList(
                        niyetler: niyetler,
                        onDelete: onDelete,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NiyetlerList extends StatefulWidget {
  const _NiyetlerList({
    required this.niyetler,
    this.onDelete,
  });

  final List<Niyet> niyetler;
  final void Function(String id)? onDelete;

  @override
  State<_NiyetlerList> createState() => _NiyetlerListState();
}

class _NiyetlerListState extends State<_NiyetlerList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // Delay content animation until modal is open
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNiyetTap(Niyet niyet) {
    // Use root navigator for proper Hero animation
    rootNavigatorKey.currentState?.push(
      MaterialPageRoute<void>(
        builder: (_) => NiyetDetailPage(niyet: niyet),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < widget.niyetler.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                if (widget.onDelete != null)
                  Dismissible(
                    key: Key(widget.niyetler[i].id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.error,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.delete_outline,
                        color: Colors.white,
                      ),
                    ),
                    confirmDismiss: (_) => showDeleteNiyetDialog(context),
                    onDismissed: (_) => widget.onDelete!(widget.niyetler[i].id),
                    child: NiyetCard(
                      niyet: widget.niyetler[i],
                      onTap: () => _onNiyetTap(widget.niyetler[i]),
                    ),
                  )
                else
                  NiyetCard(
                    niyet: widget.niyetler[i],
                    onTap: () => _onNiyetTap(widget.niyetler[i]),
                  ),
              ],
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_note_outlined,
            size: 48,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Text(
            context.loc.noIntentionsForDay,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
