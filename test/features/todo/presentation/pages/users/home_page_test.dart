import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:flutter_starter_todo_app/config/constants.dart';
import 'package:flutter_starter_todo_app/config/theme.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_page.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_event.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_state.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_bloc.dart';

import '../../../../../_helpers/containts.dart';
import '../../../../../_mocks/bloc/home_page_bloc.dart';

void main() {
  late HomePageBloc homePageBloc;

  setUpAll(() async {
    homePageBloc = MockHomePageBloc();
  });

  group('HomePage', () {
    testWidgets(
        'tapping the plus icon should trigger a state change from started to loading',
        (widgetTester) async {
      // arrange
      whenListen(
        homePageBloc,
        Stream.fromIterable([
          const HomePageStarted(),
          const HomePageLoading(),
          const HomePageLoaded(todos: [testTodoEntity]),
        ]),
        initialState: const HomePageStarted(),
      );

      // act
      // await widgetTester.pumpWidget(
      //   BlocProvider<HomePageBloc>(
      //     create: (context) => homePageBloc..add(const GetTodos()),
      //     child: const MaterialApp(
      //       home: HomePage(),
      //     ),
      //   ),
      // );

      await widgetTester.pumpWidget(
        BlocProvider(
          create: (context) => homePageBloc..add(const GetTodos()),
          child: MaterialApp(
            home: ThemeProvider(
              initTheme: AppThemes().lightTheme(),
              builder: (context, theme) {
                return MaterialApp(
                  title: appName,
                  theme: theme,
                  debugShowCheckedModeBanner: isDebug,
                  home: const HomePage(),
                );
              },
            ),
          ),
        ),
      );
      await widgetTester.pumpAndSettle();

      // assert
      final textField = find.byKey(const Key('HomePage_todoTitleInput'));
      final addButton = find.byKey(const Key('HomePage_addTodo'));
      expect(textField, findsOneWidget);
      expect(addButton, findsOneWidget);
      await widgetTester.enterText(textField, 'test');
      expect(find.text('test'), findsOneWidget);
      await widgetTester.tap(addButton);
      await widgetTester.pumpAndSettle();
      expect(find.text('test'), findsNothing);
    });
  });
}
