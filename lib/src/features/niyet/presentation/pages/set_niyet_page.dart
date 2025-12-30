import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/niyet_category.dart';
import '../bloc/niyet_bloc.dart';
import '../widgets/category_selector.dart';

class SetNiyetPage extends StatefulWidget {
  const SetNiyetPage({super.key});

  @override
  State<SetNiyetPage> createState() => _SetNiyetPageState();
}

class _SetNiyetPageState extends State<SetNiyetPage> {
  final _textController = TextEditingController();
  NiyetCategory _selectedCategory = NiyetCategory.ibadah;
  bool _forAllah = true;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _save() {
    if (_textController.text.trim().isEmpty) return;

    context.read<NiyetBloc>().add(
          NiyetCreated(
            text: _textController.text.trim(),
            category: _selectedCategory,
            forAllah: _forAllah,
          ),
        );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                  color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.format_quote,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Actions are judged by intentions',
                        style: textTheme.bodyMedium?.copyWith(
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
                style: textTheme.titleMedium,
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
                style: textTheme.titleMedium,
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
      ),
    );
  }
}
