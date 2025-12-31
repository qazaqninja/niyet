import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../../../core/router/router_paths.dart';
import '../../../niyet/domain/entities/niyet.dart';
import '../../../niyet/presentation/widgets/niyet_card.dart';

class DayNiyetlerBottomSheet extends StatelessWidget {
  const DayNiyetlerBottomSheet({
    required this.date,
    required this.niyetler,
    this.onDelete,
    super.key,
  });

  final DateTime date;
  final List<Niyet> niyetler;
  final void Function(String id)? onDelete;

  void _onNiyetTap(BuildContext context, Niyet niyet) {
    // Close bottom sheet first, then navigate
    Navigator.of(context).pop();
    context.push(
      '${RoutePaths.niyetDetail}/${niyet.id}',
      extra: niyet,
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.loc.deleteNiyet),
        content: Text(context.loc.deleteNiyetConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(context.loc.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(context.loc.delete),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    // Format date: "Monday, December 31"
    final dateText = DateFormat.MMMMEEEEd(locale).format(date);

    return DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.25,
      maxChildSize: 0.8,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // Handle
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        dateText,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${niyetler.length} niyet${niyetler.length == 1 ? '' : 'ler'}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // List of niyetler
              Expanded(
                child: niyetler.isEmpty
                    ? _EmptyState()
                    : ListView.builder(
                        controller: scrollController,
                        padding: const EdgeInsets.all(16),
                        itemCount: niyetler.length,
                        itemBuilder: (context, index) {
                          final niyet = niyetler[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: onDelete != null
                                ? Dismissible(
                                    key: Key(niyet.id),
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
                                    confirmDismiss: (_) => _confirmDelete(context),
                                    onDismissed: (_) => onDelete!(niyet.id),
                                    child: NiyetCard(
                                      niyet: niyet,
                                      onTap: () => _onNiyetTap(context, niyet),
                                    ),
                                  )
                                : NiyetCard(
                                    niyet: niyet,
                                    onTap: () => _onNiyetTap(context, niyet),
                                  ),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
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
