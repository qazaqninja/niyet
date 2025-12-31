import 'package:flutter/material.dart';

import '../localization/localization_extension.dart';

/// Shows a confirmation dialog for deleting a niyet.
/// Returns true if the user confirms, false otherwise.
Future<bool> showDeleteNiyetDialog(BuildContext context) async {
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
