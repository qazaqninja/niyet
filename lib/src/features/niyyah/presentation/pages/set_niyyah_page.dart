import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/niyyah_category.dart';
import '../bloc/niyyah_bloc.dart';
import '../widgets/category_selector.dart';

class SetNiyyahPage extends StatefulWidget {
  const SetNiyyahPage({super.key});

  @override
  State<SetNiyyahPage> createState() => _SetNiyyahPageState();
}

class _SetNiyyahPageState extends State<SetNiyyahPage> {
  final _textController = TextEditingController();
  NiyyahCategory _selectedCategory = NiyyahCategory.ibadah;
  bool _forAllah = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _save() {
    if (_textController.text.trim().isEmpty) return;

    context.read<NiyyahBloc>().add(
          NiyyahCreated(
            text: _textController.text.trim(),
            category: _selectedCategory,
            forAllah: _forAllah,
          ),
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Intention'),
        actions: [
          TextButton(
            onPressed: _save,
            child: const Text('Save'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hadith reminder
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.format_quote,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Actions are judged by intentions',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Intention text field
            Text(
              'What is your intention today?',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _textController,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'e.g., Be patient with family',
              ),
            ),
            const SizedBox(height: 32),

            // Category selector
            Text(
              'Category',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            CategorySelector(
              selected: _selectedCategory,
              onSelected: (category) {
                setState(() => _selectedCategory = category);
              },
            ),
            const SizedBox(height: 32),

            // For Allah toggle
            SwitchListTile(
              title: const Text('For the sake of Allah'),
              subtitle: const Text('A reminder of your sincere intention'),
              value: _forAllah,
              onChanged: (value) {
                setState(() => _forAllah = value);
              },
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }
}
