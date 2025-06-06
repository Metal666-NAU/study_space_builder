import 'package:flutter/material.dart';

import 'package:contextions/contextions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import '../bloc/root/home/home.dart' as home;
import '../data/project_model.dart';

import 'context_extensions.dart';
import 'home/block.dart';

const double courseElementWidth = 400;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(final BuildContext context) => _pageRoot(
        () => _menuBar(context),
        () => _pageContent(),
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
  Widget _pageContent() => BlocBuilder<home.Bloc, home.State>(
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
                      onPressed: () async => await context.showRenameDialog(
                        hasName: state.projectModel,
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
                      (final course) => SingleChildScrollView(
                        child: SizedBox(
                          width: courseElementWidth,
                          child: Block(
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
                                  null,
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
                              candidateData.isEmpty
                                  ? 'Drag a Course here...'
                                  : '> Add course! <',
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
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
                        Course.new,
                        Module.new,
                        StudyMaterial.new,
                        Assignment.new,
                        Timestamp.new,
                      ]
                          .map(
                            (final constructor) => Block.prefab(
                              createDataItem: constructor,
                              isDraggable: !state.projectLocked,
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
