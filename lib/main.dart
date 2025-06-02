import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';

import 'bloc/root/home/home.dart' as home;
import 'bloc/root/root.dart' as root;
import 'pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider(
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
                create: (final context) =>
                    home.Bloc()..add(const home.Startup()),
                child: HomePage(),
              ),
            );
          },
        ),
      );
}
