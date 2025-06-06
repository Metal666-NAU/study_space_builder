import 'package:flutter/material.dart';

import 'package:contextions/contextions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/root/home/home.dart' as home;
import '../data/project_model.dart';

extension ContextExtensions on BuildContext {
  Future<void> showRenameDialog({
    required final IHasName hasName,
  }) =>
      showNameDialog(
        fieldName: switch (hasName) {
          ProjectModel _ => 'Project name:',
          Course _ => 'Course name:',
          _ => 'Item name:',
        },
        onSuccess: (final newName) {
          switch (hasName) {
            case ProjectModel _:
              {
                read<home.Bloc>().add(
                  home.RenameProject(newName),
                );

                break;
              }
            case DataItemBase _:
              {
                read<home.Bloc>().add(
                  home.RenameDataItem(newName, hasName),
                );

                break;
              }
          }
        },
        initialText: hasName.name,
      );

  Future<void> showNameDialog({
    required final String fieldName,
    required final void Function(String newName) onSuccess,
    final String initialText = '',
  }) =>
      showCustomDialog(
        builder: (final context) {
          final nameController = TextEditingController(text: initialText);

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(fieldName),
                  SizedBox(width: 5),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: nameController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: () => context.pop(),
                    icon: Icon(Icons.close),
                    label: Text('Cancel'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final newName = nameController.text;

                      if (newName.isEmpty) {
                        context.showSnackbar(
                          'Name can\'t be empty!',
                        );

                        return;
                      }

                      onSuccess(newName);

                      context.pop();
                    },
                    icon: Icon(Icons.check),
                    label: Text('Confirm'),
                  ),
                ],
              ),
            ],
          );
        },
      );

  Future<void> showCustomDialog({
    required final Widget Function(BuildContext dialogContext) builder,
  }) =>
      showDialog(
        context: this,
        builder: (final dialogContext) => Dialog(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: builder(dialogContext),
          ),
        ),
      );
}
