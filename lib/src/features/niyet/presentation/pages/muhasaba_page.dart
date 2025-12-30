import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../domain/entities/niyet.dart';
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_outcome.dart';
import '../bloc/niyet_bloc.dart';
import '../widgets/outcome_selector.dart';

class MuhasabaPage extends StatelessWidget {
  const MuhasabaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.eveningReflection),
      ),
      body: BlocBuilder<NiyetBloc, NiyetState>(
        builder: (context, state) {
          final unreflected =
              state.niyetler.where((n) => !n.isReflected).toList();

          if (unreflected.isEmpty) {
            return _AllReflectedView(
              onDone: () => context.pop(),
            );
          }

          return _ReflectionFlow(
            niyetler: unreflected,
            onComplete: () => context.pop(),
          );
        },
      ),
    );
  }
}

class _AllReflectedView extends StatelessWidget {
  const _AllReflectedView({required this.onDone});

  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              context.loc.allIntentionsReflected,
              style: textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              context.loc.mayAllahAccept,
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onDone,
              child: Text(context.loc.complete),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReflectionFlow extends StatefulWidget {
  const _ReflectionFlow({
    required this.niyetler,
    required this.onComplete,
  });

  final List<Niyet> niyetler;
  final VoidCallback onComplete;

  @override
  State<_ReflectionFlow> createState() => _ReflectionFlowState();
}

class _ReflectionFlowState extends State<_ReflectionFlow> {
  late int _totalCount;
  int _completedCount = 0;
  NiyetOutcome? _selectedOutcome;
  final _reflectionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _totalCount = widget.niyetler.length;
  }

  Niyet? get _currentNiyet =>
      widget.niyetler.isNotEmpty ? widget.niyetler.first : null;
  bool get _isLast => widget.niyetler.length <= 1;

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  void _saveAndNext() {
    final current = _currentNiyet;
    if (_selectedOutcome == null || current == null) return;

    final isLast = _isLast;

    context.read<NiyetBloc>().add(
          NiyetOutcomeUpdated(
            id: current.id,
            outcome: _selectedOutcome!,
            reflection: _reflectionController.text.trim().isEmpty
                ? null
                : _reflectionController.text.trim(),
          ),
        );

    if (isLast) {
      widget.onComplete();
    } else {
      // Don't increment index - the list will shrink when this item
      // becomes reflected, so the next item slides into current position
      setState(() {
        _completedCount++;
        _selectedOutcome = null;
        _reflectionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentNiyet;
    if (current == null) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (_completedCount + 1) / _totalCount,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.2),
            ),
            const SizedBox(height: 8),
            Text(
              '${_completedCount + 1} of $_totalCount',
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 32),

            // Current niyet
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      current.category.label,
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      current.text,
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Outcome question
            Text(
              context.loc.howDidItGo,
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            OutcomeSelector(
              selected: _selectedOutcome,
              onSelected: (outcome) {
                setState(() => _selectedOutcome = outcome);
              },
            ),
            const SizedBox(height: 32),

            // Reflection (optional)
            Text(
              '${context.loc.reflection} (optional)',
              style: textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reflectionController,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: context.loc.reflectionPlaceholder,
              ),
            ),
            const SizedBox(height: 32),

            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedOutcome != null ? _saveAndNext : null,
                child: Text(_isLast ? context.loc.complete : context.loc.next),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
