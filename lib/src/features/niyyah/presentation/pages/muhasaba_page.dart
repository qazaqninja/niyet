import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/niyyah.dart';
import '../../domain/entities/niyyah_category.dart';
import '../../domain/entities/niyyah_outcome.dart';
import '../bloc/niyyah_bloc.dart';
import '../widgets/outcome_selector.dart';

class MuhasabaPage extends StatelessWidget {
  const MuhasabaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evening Reflection'),
      ),
      body: BlocBuilder<NiyyahBloc, NiyyahState>(
        builder: (context, state) {
          final unreflected =
              state.niyyat.where((n) => !n.isReflected).toList();

          if (unreflected.isEmpty) {
            return _AllReflectedView(
              onDone: () => context.pop(),
            );
          }

          return _ReflectionFlow(
            niyyat: unreflected,
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'All intentions reflected',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'May Allah accept your efforts',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onDone,
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReflectionFlow extends StatefulWidget {
  const _ReflectionFlow({
    required this.niyyat,
    required this.onComplete,
  });

  final List<Niyyah> niyyat;
  final VoidCallback onComplete;

  @override
  State<_ReflectionFlow> createState() => _ReflectionFlowState();
}

class _ReflectionFlowState extends State<_ReflectionFlow> {
  late int _totalCount;
  int _completedCount = 0;
  NiyyahOutcome? _selectedOutcome;
  final _reflectionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _totalCount = widget.niyyat.length;
  }

  Niyyah? get _currentNiyyah =>
      widget.niyyat.isNotEmpty ? widget.niyyat.first : null;
  bool get _isLast => widget.niyyat.length <= 1;

  @override
  void dispose() {
    _reflectionController.dispose();
    super.dispose();
  }

  void _saveAndNext() {
    final current = _currentNiyyah;
    if (_selectedOutcome == null || current == null) return;

    final isLast = _isLast;

    context.read<NiyyahBloc>().add(
          NiyyahOutcomeUpdated(
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
    final current = _currentNiyyah;
    if (current == null) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress indicator
          LinearProgressIndicator(
            value: (_completedCount + 1) / _totalCount,
            backgroundColor:
                Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
          ),
          const SizedBox(height: 8),
          Text(
            '${_completedCount + 1} of $_totalCount',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 32),

          // Current niyyah
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    current.category.label,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    current.text,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Outcome question
          Text(
            'How did it go?',
            style: Theme.of(context).textTheme.titleMedium,
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
            'Reflection (optional)',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _reflectionController,
            maxLines: 3,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              hintText: 'What helped? What distracted?',
            ),
          ),
          const SizedBox(height: 32),

          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedOutcome != null ? _saveAndNext : null,
              child: Text(_isLast ? 'Complete' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}
