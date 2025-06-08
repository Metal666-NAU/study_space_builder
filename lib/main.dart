import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'bloc/root/home/home.dart' as home;
import 'bloc/root/root.dart' as root;
import 'data/api/local_filesystem_project_api.dart';
import 'data/api/project_api.dart';
import 'data/repositories/project_repository.dart';
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(const MainApp(projectApi: LocalFilesystemProjectApi()));
}

class MainApp extends StatelessWidget {
  final ProjectApi _projectApi;

  const MainApp({
    super.key,
    required final ProjectApi projectApi,
  }) : _projectApi = projectApi;

  @override
  Widget build(final BuildContext context) => RepositoryProvider(
        create: (final context) => ProjectRepository(projectApi: _projectApi),
        dispose: (final repository) async => repository.dispose(),
        child: BlocProvider(
          create: (final context) => root.Bloc()..add(const root.Startup()),
          child: BlocBuilder<root.Bloc, root.State>(
            builder: (final context, final state) {
              final theme = ThemeData.from(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple,
                  brightness: Brightness.dark,
                ),
              );

              return MaterialApp(
                theme: theme,
                home: BlocProvider(
                  create: (final context) => home.Bloc(
                    projectRepository: context.read<ProjectRepository>(),
                  )..add(const home.Startup()),
                  child: HomePage(),
                ),
              );
            },
          ),
        ),
      );
}
