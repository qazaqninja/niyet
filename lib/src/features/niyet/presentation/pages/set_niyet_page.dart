import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/localization_extension.dart';
import '../../domain/entities/niyet_category.dart';
import '../../domain/entities/niyet_template.dart';
import '../bloc/niyet_bloc.dart';
import '../bloc/template_bloc.dart';
import '../widgets/category_selector.dart';
import '../widgets/template_chips.dart';

class SetNiyetPage extends StatefulWidget {
  const SetNiyetPage({super.key});

  @override
  State<SetNiyetPage> createState() => _SetNiyetPageState();
}

class _SetNiyetPageState extends State<SetNiyetPage> {
  final _textController = TextEditingController();
  NiyetCategory _selectedCategory = NiyetCategory.ibadah;
  bool _forAllah = true;
  bool _showTemplates = true;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final isEmpty = _textController.text.isEmpty;
    if (_showTemplates != isEmpty) {
      setState(() => _showTemplates = isEmpty);
    }
  }

  void _onTemplateSelected(NiyetTemplate template) {
    _textController.text = template.text;
    _textController.selection = TextSelection(
      baseOffset: 0,
      extentOffset: template.text.length,
    );
    setState(() {
      _selectedCategory = template.category;
      _showTemplates = false;
    });
  }

  void _saveAsTemplate() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    context.read<TemplateBloc>().add(
          TemplateCreated(
            text: text,
            category: _selectedCategory,
          ),
        );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.loc.templateSaved),
        duration: const Duration(seconds: 2),
      ),
    );
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
          title: Text(context.loc.setNiyet),
          actions: [
            IconButton(
              onPressed: _saveAsTemplate,
              icon: const Icon(Icons.bookmark_add_outlined),
              tooltip: context.loc.saveAsTemplate,
            ),
            TextButton(
              onPressed: _save,
              child: Text(context.loc.save),
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
                        context.loc.hadithReminder,
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
                context.loc.whatIsYourIntention,
                style: textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _textController,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: context.loc.intentionPlaceholder,
                ),
              ),
              const SizedBox(height: 12),

              // Template chips
              BlocBuilder<TemplateBloc, TemplateState>(
                builder: (context, state) {
                  return TemplateChips(
                    userTemplates: state.userTemplates,
                    onTemplateSelected: _onTemplateSelected,
                    visible: _showTemplates,
                  );
                },
              ),
              const SizedBox(height: 20),

              // Category selector
              Text(
                context.loc.category,
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
                title: Text(context.loc.forTheSakeOfAllah),
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
