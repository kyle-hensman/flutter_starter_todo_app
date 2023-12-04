import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_page.dart';

final GoRouter appRouter = GoRouter(
  redirect: (context, state) {
    // All redirect logic based on auth status
    return null;
  },
  initialLocation: '/',
  routes: [
    // The initial route of the app
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
  ],
);
