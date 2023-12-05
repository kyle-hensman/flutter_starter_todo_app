import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_bloc.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_event.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_state.dart';

class MockHomePageBloc extends MockBloc<HomePageEvent, HomePageState>
    implements HomePageBloc {}
