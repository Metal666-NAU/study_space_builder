import 'package:flutter/material.dart';

import 'package:contextions/contextions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/root/home/home.dart' as home;
import '../../data/project_model.dart';
import '../context_extensions.dart';

class Block extends StatelessWidget {
  final DataItemBase _dataItem;
  final DataItemBase? Function(DataItemBase)? prefix;
  final List<DataItemBase> Function(DataItemBase)? children;
  final bool isEditable;
  final bool isDraggable;
  final DisplayStyle? displayStyle;
  final int depth;

  Block({
    super.key,
    required final DataItemBase dataItem,
    this.prefix,
    this.children,
    this.isEditable = false,
    this.isDraggable = true,
    final DisplayStyle? enforceDisplayStyle,
    this.depth = 0,
  })  : _dataItem = dataItem,
        displayStyle = enforceDisplayStyle ?? dataItem.displayStyle;

  factory Block.prefab({
    required final DataItemBase Function() createDataItem,
    required final bool isDraggable,
  }) =>
      Block(
        dataItem: createDataItem(),
        isDraggable: isDraggable,
        enforceDisplayStyle: DisplayStyle.titleOnly,
      );

  @override
  Widget build(final BuildContext context) {
    final prefixItem = prefix?.call(_dataItem);

    return MenuAnchor(
      consumeOutsideTap: true,
      menuChildren: [
        MenuItemButton(
          onPressed: () => context.read<home.Bloc>().add(
                home.DeleteDataItem(_dataItem),
              ),
          leadingIcon: Icon(Icons.delete_forever),
          child: Text('Delete ${_dataItem.name}'),
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
          data: _dataItem,
          feedback: Material(child: Text(_dataItem.name)),
          child: Card(
            elevation: (depth + 1).toDouble() * 1.5,
            surfaceTintColor: context.colorScheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (_dataItem.hasPrefixSlot)
                      if (prefixItem != null)
                        _buildNestedItems(
                          context: context,
                          items: [prefixItem],
                        )
                      else if (isEditable)
                        _buildSlot(
                          context: context,
                          onWillAcceptWithDetails: (final details) {
                            final canBePrefixedBy =
                                _dataItem.canBePrefixedBy(details.data);
                            return canBePrefixedBy;
                          },
                          icon: Icons.keyboard_double_arrow_down,
                          isPrefix: true,
                        ),
                    if (displayStyle != DisplayStyle.contentOnly)
                      isEditable
                          ? TextButton(
                              onPressed: () async => context.showRenameDialog(
                                hasName: _dataItem,
                              ),
                              child: Text(_dataItem.name),
                            )
                          : Text(_dataItem.name),
                    if (displayStyle != DisplayStyle.titleOnly) ...[
                      if (_dataItem is ModuleItem)
                        Card(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              final contentController = TextEditingController(
                                text: _dataItem.content,
                              );

                              await context.showCustomDialog(
                                builder: (final dialogContext) => Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        _dataItem.name,
                                        style: context.textTheme.headlineSmall,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: contentController,
                                        expands: true,
                                        maxLines: null,
                                        textAlignVertical:
                                            TextAlignVertical.top,
                                        decoration: InputDecoration(
                                          icon: Column(
                                            children: [
                                              Icon(Icons.edit_document),
                                            ],
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: context
                                                  .colorScheme.primaryContainer,
                                            ),
                                          ),
                                          filled: true,
                                          fillColor:
                                              context.colorScheme.surface,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              if (!context.mounted) {
                                return;
                              }

                              context.read<home.Bloc>().add(
                                    home.UpdateModuleItemContent(
                                      _dataItem,
                                      contentController.text,
                                    ),
                                  );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                _dataItem.content,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      if (_dataItem is Timestamp)
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
                                    currentDate: _dataItem.valueDateTime,
                                  );

                                  if (timestamp == null) {
                                    return;
                                  }

                                  if (!context.mounted) {
                                    return;
                                  }

                                  context.read<home.Bloc>().add(
                                        home.UpdateTimestamp(
                                          _dataItem,
                                          timestamp.millisecondsSinceEpoch,
                                        ),
                                      );
                                },
                                child: _buildPrettyTimestamp(
                                  context: context,
                                  value: _dataItem.valueDateTime,
                                ),
                              )
                            : _buildPrettyTimestamp(
                                context: context,
                                value: _dataItem.valueDateTime,
                              ),
                      _buildNestedItems(
                        context: context,
                        items: children?.call(_dataItem) ?? [],
                      ),
                    ],
                    if (isEditable && _dataItem.hasChildrenSlots)
                      _buildSlot(
                        context: context,
                        onWillAcceptWithDetails: (final details) =>
                            _dataItem.canBeParentFor(details.data),
                        icon: Icons.keyboard_double_arrow_up,
                        isPrefix: false,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSlot({
    required final BuildContext context,
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
                _dataItem,
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

  Widget _buildNestedItems({
    required final BuildContext context,
    required final List<DataItemBase> items,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items
            .map(
              (final childDataItem) => Block(
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

  Widget _buildPrettyTimestamp({
    required final BuildContext context,
    required final DateTime value,
  }) =>
      Text(
        DateFormat('E, d yyyy - hh:mm:ss').format(value),
        style: context.textTheme.labelSmall,
      );
}
