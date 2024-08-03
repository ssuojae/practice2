import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/todo_item_model.dart';
import '../../cubit_viewmodel/todo_cubit.dart';
import '../widgets/bar/sliver_appbar.dart';
import '../widgets/item/sliver_todo_item.dart';
import 'empty_todolist.dart';

final class TodolistPage extends StatelessWidget {
  final ITodoCubit todoCubit;
  final PageController pageController;

  const TodolistPage({super.key, required this.todoCubit, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: todoCubit as TodoCubit,
        child: BlocBuilder<TodoCubit, List<TodoEntity>>(
          builder: (context, items) {
            final filteredItems = items.where((item) => !item.done).toList();

            if (filteredItems.isEmpty) {
              return EmptyTodolist(pageController: pageController);
            }

            return CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  titleText: "You've got ",
                  welcomeText: "Welcome",
                  highlightText: '${filteredItems.length} tasks',
                  endText: ' to do',
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(top: 20, left: 8, right: 8),
                  
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final todo = filteredItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Dismissible(
                            key: ValueKey(todo.id),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              context.read<TodoCubit>().markAsDonTrue(items.indexOf(todo));
                            },
                            background: Container(
                              color: Colors.lightBlue,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                            child: SliverTodoItem(
                              key: ValueKey(todo.id),
                              index: items.indexOf(todo),
                              todo: todo,
                              onCheckboxTap: () {
                                context.read<TodoCubit>().toggleCheckboxState(items.indexOf(todo));
                              },
                              onLongPress: () { print('onLongPress'); },
                            ),
                          ),
                        );
                      },
                      childCount: filteredItems.length,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
