import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/todo_item_model.dart';
import '../../../data/repositories/todo_repository.dart';
import '../../cubit_viewmodel/todo_cubit.dart';
import 'add_page.dart';
import 'done_page.dart';
import 'empty_todolist.dart';
import 'todolist_page.dart';
import '../widgets/bar/main_navigationbar.dart';
import '../widgets/bar/main_appbar.dart';

final class HomePage extends StatefulWidget {
  final List<TodoEntity> todos;

  const HomePage({super.key, required this.todos});

  @override
  _HomePageState createState() => _HomePageState();
}

final class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late  final PageController _pageController;
  late final TodoCubit _todoCubit;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _todoCubit = TodoCubit(TodoRepository())..emit(widget.todos);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _todoCubit.close();
    super.dispose();
  }

  void navigateToPage(int pageIndex) {
    setState(() {
      _currentIndex = pageIndex;
    });

    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _getInitialPage() {
    final todos = _todoCubit.state;
    final filteredItems = todos.where((item) => !item.done).toList();
    if (filteredItems.isEmpty) {
      return EmptyTodolist(pageController: _pageController);
    } else {
      return TodolistPage(
          todoCubit: _todoCubit, pageController: _pageController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: const MainAppbar(),
      ),
      body: BlocProvider.value(
        value: _todoCubit,
        child: BlocListener<TodoCubit, List<TodoEntity>>(
          listener: (context, state) {
            setState(() {}); // 상태가 변경되면 페이지를 업데이트
          },
          child: PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _getInitialPage(),
              AddPage(
                pageController: _pageController,
                todoCubit: _todoCubit,
                onTaskAdded: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                  navigateToPage(0);
                },
              ),
              DonePage(
                todoCubit: _todoCubit,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MainNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          navigateToPage(index);
        },
      ),
    );
  }

}
