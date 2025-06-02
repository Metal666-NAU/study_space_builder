import 'package:flutter/material.dart';

import 'package:contextions/contextions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:window_manager/window_manager.dart';

import '../bloc/root/home/home.dart' as home;
import '../data/project_model.dart';

const double courseElementWidth = 400;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => _pageRoot(
        () => _menuBar(context),
        () => _pageContent(_block),
      );

  Widget _pageRoot(
    final Widget Function() menuBar,
    final Widget Function() pageContent,
  ) =>
      BlocListener<home.Bloc, home.State>(
        listenWhen: (final previous, final current) =>
            previous.projectPath != current.projectPath,
        listener: (final context, final state) async {
          final projectPath = state.projectPath;

          await windowManager.setTitle(
            'study_space_builder${projectPath == null ? '' : ' - $projectPath'}',
          );
        },
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              menuBar(),
              Expanded(child: pageContent()),
            ],
          ),
        ),
      );

  Widget _menuBar(final BuildContext context) => Container(
        color: context.colorScheme.primaryContainer,
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Center(
              child: Text(
                'Study Space Builder',
                style: context.textTheme.bodyLarge
                    ?.copyWith(color: context.colorScheme.primary),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('File:'),
                  ),
                  MenuBar(
                    children: [
                      MenuItemButton(
                        onPressed: () =>
                            context.read<home.Bloc>().add(home.NewProject()),
                        child: Text('New'),
                      ),
                      MenuItemButton(
                        onPressed: () =>
                            context.read<home.Bloc>().add(home.LoadProject()),
                        child: Text('Load'),
                      ),
                      MenuItemButton(
                        onPressed: () =>
                            context.read<home.Bloc>().add(home.SaveProject()),
                        child: Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  Widget _pageContent(
    final Widget Function({
      required BuildContext context,
      required DataItemBase dataItem,
      DataItemBase? Function(DataItemBase) prefix,
      List<DataItemBase> Function(DataItemBase) children,
      bool isEditable,
      bool isDraggable,
      DisplayStyle? enforceDisplayStyle,
      int depth,
    }) block,
  ) =>
      BlocBuilder<home.Bloc, home.State>(
        buildWhen: (final previous, final current) =>
            previous.projectModel != current.projectModel ||
            previous.projectLocked != current.projectLocked,
        builder: (final context, final state) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              margin: EdgeInsets.all(0),
              shape: Border.all(),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Current Project:'),
                    SizedBox(width: 5),
                    TextButton(
                      onPressed: () async => await _showRenameDialog(
                        parentContext: context,
                        dataItem: state.projectModel,
                      ),
                      child: Text(state.projectModel.name),
                    ),
                    BlocBuilder<home.Bloc, home.State>(
                      buildWhen: (final previous, final current) =>
                          previous.projectLocked != current.projectLocked,
                      builder: (final context, final state) => IconButton(
                        onPressed: () => context
                            .read<home.Bloc>()
                            .add(home.ToggleProjectLock()),
                        icon: Icon(
                          state.projectLocked ? Icons.lock : Icons.lock_open,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: state.projectModel.courses
                    .map(
                      (final course) => SizedBox(
                        width: courseElementWidth,
                        child: SingleChildScrollView(
                          child: block(
                            context: context,
                            dataItem: course,
                            prefix: (final parentDataItem) => state.projectModel
                                .findPrefixFor(parentDataItem),
                            children: (final parentDataItem) => state
                                .projectModel
                                .findChildrenFor(parentDataItem),
                            isEditable: !state.projectLocked,
                            isDraggable: !state.projectLocked,
                          ),
                        ),
                      ),
                    )
                    .cast<Widget>()
                    .toList()
                  ..add(
                    DragTarget<Course>(
                      onAcceptWithDetails: (final details) =>
                          context.read<home.Bloc>().add(
                                home.InsertDataItem(
                                  details.data,
                                  state.projectModel,
                                  false,
                                ),
                              ),
                      builder: (
                        final context,
                        final candidateData,
                        final rejectedData,
                      ) =>
                          Card(
                        color: candidateData.isEmpty
                            ? null
                            : context.colorScheme.primaryContainer,
                        child: SizedBox(
                          width: courseElementWidth,
                          child: Center(
                            child: Text(
                              candidateData.isEmpty ? '' : '> Add course <',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
            ),
            BlocBuilder<home.Bloc, home.State>(
              buildWhen: (final previous, final current) =>
                  previous.projectLocked != current.projectLocked,
              builder: (final context, final state) => Card(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Components:'),
                    ),
                    Row(
                      children: [
                        block(
                          context: context,
                          dataItem: Course(
                            name: 'Course',
                          ),
                          isDraggable: !state.projectLocked,
                          enforceDisplayStyle: DisplayStyle.titleOnly,
                        ),
                        block(
                          context: context,
                          dataItem: Module(
                            name: 'Module',
                          ),
                          isDraggable: !state.projectLocked,
                          enforceDisplayStyle: DisplayStyle.titleOnly,
                        ),
                        block(
                          context: context,
                          dataItem: StudyMaterial(
                            name: 'Material',
                          ),
                          isDraggable: !state.projectLocked,
                          enforceDisplayStyle: DisplayStyle.titleOnly,
                        ),
                        block(
                          context: context,
                          dataItem: Assignment(
                            name: 'Assignment',
                          ),
                          isDraggable: !state.projectLocked,
                          enforceDisplayStyle: DisplayStyle.titleOnly,
                        ),
                        block(
                          context: context,
                          dataItem: Timestamp(
                            value: DateTime.now().millisecondsSinceEpoch,
                          ),
                          isDraggable: !state.projectLocked,
                          enforceDisplayStyle: DisplayStyle.titleOnly,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _block({
    required final BuildContext context,
    required final DataItemBase dataItem,
    final DataItemBase? Function(DataItemBase)? prefix,
    final List<DataItemBase> Function(DataItemBase)? children,
    final bool isEditable = false,
    final bool isDraggable = true,
    final DisplayStyle? enforceDisplayStyle,
    final int depth = 0,
  }) {
    final displayStyle = enforceDisplayStyle ?? dataItem.displayStyle;
    final prefixItem = prefix?.call(dataItem);

    Widget buildSlot({
      required final bool Function(DragTargetDetails<DataItemBase>)
          onWillAcceptWithDetails,
      required final IconData icon,
      required final bool isPrefix,
    }) =>
        DragTarget<DataItemBase>(
          onWillAcceptWithDetails: onWillAcceptWithDetails,
          onAcceptWithDetails: (final details) => context.read<home.Bloc>().add(
                home.InsertDataItem(
                  details.data,
                  dataItem,
                  isPrefix,
                ),
              ),
          builder: (
            final context,
            final candidateData,
            final rejectedData,
          ) =>
              Container(
            height: 30,
            color: candidateData.isEmpty
                ? context.colorScheme.surfaceContainer
                    .withAlpha((depth * 4) + 112)
                : context.colorScheme.primary,
            child: Center(
              child: Icon(
                icon,
                color: candidateData.isEmpty
                    ? context.colorScheme.onSurfaceVariant.withAlpha(112)
                    : context.colorScheme.onPrimary,
              ),
            ),
          ),
        );

    Widget buildNestedItems({
      required final List<DataItemBase> items,
    }) =>
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items
              .map(
                (final childDataItem) => _block(
                  context: context,
                  dataItem: childDataItem,
                  prefix: prefix,
                  children: children,
                  isEditable: isEditable,
                  isDraggable: isDraggable,
                  depth: depth + 1,
                ),
              )
              .toList(),
        );

    Widget prettyTimestamp(final DateTime value) => Text(
          DateFormat('E, d yyyy - hh:mm:ss').format(value),
          style: context.textTheme.labelSmall,
        );

    return MenuAnchor(
      consumeOutsideTap: true,
      menuChildren: [
        MenuItemButton(
          onPressed: () => context.read<home.Bloc>().add(
                home.DeleteDataItem(dataItem),
              ),
          leadingIcon: Icon(Icons.delete_forever),
          child: Text('Delete ${dataItem.name}'),
        ),
      ],
      builder: (
        final context,
        final controller,
        final child,
      ) =>
          InkWell(
        excludeFromSemantics: true,
        onSecondaryTap: isEditable
            ? () {
                if (!controller.isOpen) {
                  controller.open();
                }
              }
            : null,
        child: child,
      ),
      child: AbsorbPointer(
        absorbing: !isDraggable,
        child: Draggable(
          data: dataItem,
          feedback: Material(child: Text(dataItem.name)),
          child: Card(
            elevation: (depth + 1).toDouble() * 1.5,
            surfaceTintColor: context.colorScheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  if (dataItem.hasPrefixSlot)
                    if (prefixItem != null)
                      buildNestedItems(items: [prefixItem])
                    else if (isEditable)
                      buildSlot(
                        onWillAcceptWithDetails: (final details) {
                          final canBePrefixedBy =
                              dataItem.canBePrefixedBy(details.data);
                          return canBePrefixedBy;
                        },
                        icon: Icons.keyboard_double_arrow_down,
                        isPrefix: true,
                      ),
                  if (displayStyle != DisplayStyle.contentOnly)
                    isEditable
                        ? TextButton(
                            onPressed: () async => _showRenameDialog(
                              parentContext: context,
                              dataItem: dataItem,
                            ),
                            child: Text(dataItem.name),
                          )
                        : Text(dataItem.name),
                  if (displayStyle != DisplayStyle.titleOnly) ...[
                    if (dataItem is Timestamp)
                      isEditable
                          ? TextButton(
                              onPressed: () async {
                                final timestamp = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime.utc(
                                    2000,
                                    1,
                                    1,
                                  ),
                                  lastDate: DateTime.utc(
                                    3000,
                                    1,
                                    1,
                                  ),
                                  currentDate: dataItem.valueDateTime,
                                );

                                if (timestamp == null) {
                                  return;
                                }

                                if (!context.mounted) {
                                  return;
                                }

                                context.read<home.Bloc>().add(
                                      home.UpdateTimestamp(
                                        dataItem,
                                        timestamp.millisecondsSinceEpoch,
                                      ),
                                    );
                              },
                              child: prettyTimestamp(dataItem.valueDateTime),
                            )
                          : prettyTimestamp(dataItem.valueDateTime),
                    buildNestedItems(items: children?.call(dataItem) ?? []),
                  ],
                  if (isEditable && dataItem.hasChildrenSlots)
                    buildSlot(
                      onWillAcceptWithDetails: (final details) =>
                          dataItem.canBeParentFor(details.data),
                      icon: Icons.keyboard_double_arrow_up,
                      isPrefix: false,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showRenameDialog({
    required final BuildContext parentContext,
    required final DataItemBase dataItem,
  }) =>
      _showNameDialog(
        parentContext: parentContext,
        fieldName: switch (dataItem) {
          ProjectModel _ => 'Project name:',
          Course _ => 'Course name:',
          _ => 'Item name:',
        },
        onSuccess: (final newName) => parentContext.read<home.Bloc>().add(
              home.RenameDataItem(newName, dataItem),
            ),
        initialText: dataItem.name,
      );

  Future<void> _showNameDialog({
    required final BuildContext parentContext,
    required final String fieldName,
    required final void Function(String newName) onSuccess,
    final String initialText = '',
  }) =>
      _showDialog(
        context: parentContext,
        builder: (final dialogContext) {
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
                    onPressed: () => dialogContext.pop(),
                    icon: Icon(Icons.close),
                    label: Text('Cancel'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      final newName = nameController.text;

                      if (newName.isEmpty) {
                        dialogContext.showSnackbar(
                          'Name can\'t be empty!',
                        );

                        return;
                      }

                      onSuccess(newName);

                      dialogContext.pop();
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

  Future<void> _showDialog({
    required final BuildContext context,
    required final Widget Function(BuildContext) builder,
  }) =>
      showDialog(
        context: context,
        builder: (final dialogContext) => Dialog(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: builder(dialogContext),
          ),
        ),
      );
}
