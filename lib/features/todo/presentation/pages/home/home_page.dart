import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_todo_app/config/theme.dart';

import 'package:flutter_starter_todo_app/features/todo/domain/entities/todo_entity.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_bloc.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_event.dart';
import 'package:flutter_starter_todo_app/features/todo/presentation/pages/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _todoTitleInput = TextEditingController();

  @override
  void dispose() {
    _todoTitleInput.dispose();
    super.dispose();
  }

  toggleTodo(int id) async {
    context.read<HomePageBloc>().add(ToggleTodo(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo app'),
        actions: [
          Row(
            children: [
              ThemeSwitcher.withTheme(builder: (context, switcher, theme) {
                return IconButton(
                  onPressed: () => switcher.changeTheme(
                    theme: theme.brightness == Brightness.light
                        ? AppThemes().darkTheme()
                        : AppThemes().lightTheme(),
                  ),
                  icon: Icon(
                    theme.brightness == Brightness.light
                        ? Icons.dark_mode
                        : Icons.sunny,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(),
              Container(
                padding: const EdgeInsets.only(left: 18, right: 18),
                height: 170,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      key: const Key('HomePage_todoTitleInput'),
                      controller: _todoTitleInput,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      key: const Key('HomePage_addTodo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        if (_todoTitleInput.text.isNotEmpty) {
                          final todo =
                              TodoEntity(title: _todoTitleInput.text.trim());
                          context.read<HomePageBloc>().add(AddTodo(todo));
                          _todoTitleInput.text = '';
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Todo added!'),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text('Please enter a todo text!'),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {},
                            ),
                          ));
                        }
                      },
                      child: Text(
                        'Add Todo',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                width: double.infinity,
                child: BlocBuilder<HomePageBloc, HomePageState>(
                  builder: (context, state) {
                    if (state is HomePageLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is HomePageLoaded) {
                      if (state.todos.isNotEmpty) {
                        return Container(
                          // height: MediaQuery.of(context).size.height / 1.5,
                          width: double.infinity,
                          child: ListView.builder(
                            itemCount: state.todos.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  state.todos[index].title ?? 'title',
                                  style: TextStyle(
                                    fontWeight: state.todos[index].complete
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                    decoration: state.todos[index].complete
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                trailing: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          if (state.todos[index].id != null) {
                                            await toggleTodo(
                                                state.todos[index].id!);
                                          }
                                        },
                                        icon: Icon(
                                          state.todos[index].complete
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          if (state.todos[index].id != null) {
                                            context.read<HomePageBloc>().add(
                                                RemoveTodo(state.todos[index].id
                                                    as int));
                                            ScaffoldMessenger.of(context)
                                                .clearSnackBars();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  const Text('Todo removed!'),
                                              action: SnackBarAction(
                                                label: 'dismiss',
                                                onPressed: () {},
                                              ),
                                            ));
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          child: const Center(
                            child: Text(
                              'There are no todos yet, create one above.',
                            ),
                          ),
                        );
                      }
                    }

                    if (state is HomePageFailure) {
                      String errorMessage = state.error.toString();
                      if (state.error != null) {
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(errorMessage),
                            const SizedBox(height: 20),
                            OutlinedButton(
                              onPressed: () {
                                context
                                    .read<HomePageBloc>()
                                    .add(const GetTodos());
                              },
                              child: const Text('Try Again'),
                            ),
                          ],
                        );
                      }
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                            'There was an issue getting todos!, please try again.'),
                        const SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () {
                            context.read<HomePageBloc>().add(const GetTodos());
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
