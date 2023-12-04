import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:flutter_starter_todo_app/config/constants.dart';
import 'package:flutter_starter_todo_app/config/router.dart';
import 'package:flutter_starter_todo_app/config/theme.dart';
import 'package:flutter_starter_todo_app/core/utils/locator.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_bloc.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(preferredOrientations);

  await setupLocator();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomePageBloc()..add(const GetTodos()),
        ),
      ],
      child: MaterialApp(
        home: AnimatedSplashScreen(
          splash: 'assets/images/logo.jpg',
          duration: 600,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          nextScreen: ThemeProvider(
              initTheme: AppThemes().lightTheme(),
              builder: (context, theme) {
                return MaterialApp.router(
                  title: appName,
                  theme: theme,
                  debugShowCheckedModeBanner: isDebug,
                  routerConfig: appRouter,
                );
              }),
        ),
      ),
    ),
  );
}
