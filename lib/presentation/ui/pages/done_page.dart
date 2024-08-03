import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/todo_item_model.dart';
import '../../cubit_viewmodel/todo_cubit.dart';
import '../widgets/bar/sliver_appbar.dart';
import '../widgets/button/delete_button.dart';
import '../widgets/item/sliver_done._item.dart';

class DonePage extends StatefulWidget {
  final ITodoCubit todoCubit;

  const DonePage({super.key, required this.todoCubit});

  @override
  _DonePageState createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  static const String _noTaskImage = 'assets/notask.png';
  static const double _imageWidth = 150.0;
  static const double _imageHeight = 150.0;
  static const double _verticalPadding = 20.0;
  static const String _noTaskText = 'You have no task listed.';
  static const double _textFontSize = 16.0;
  static const Color _textColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider.value(
        value: widget.todoCubit as TodoCubit,
        child: BlocBuilder<TodoCubit, List<TodoEntity>>(
          builder: (context, items) {
            final doneItems = items.where((item) => item.done).toList();
            return CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  titleText: "You've finished ",
                  welcomeText: "Well Done! ",
                  highlightText: "${doneItems.length} tasks",
                  endText: "",
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                ),
                doneItems.isEmpty
                    ? SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height * 0.1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  _noTaskImage,
                                  width: _imageWidth,
                                  height: _imageHeight,
                                ),
                                const SizedBox(height: _verticalPadding),
                                const Text(
                                  _noTaskText,
                                  style: TextStyle(
                                    color: _textColor,
                                    fontSize: _textFontSize,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return _buildItem(doneItems[index], index);
                          },
                          childCount: doneItems.length,
                        ),
                      ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: BlocBuilder<TodoCubit, List<TodoEntity>>(
        builder: (context, items) {
          final doneItems = items.where((item) => item.done).toList();
          return doneItems.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: DeleteButton(
                    onPressed: () {
                      for (var item in doneItems) {
                        (widget.todoCubit as TodoCubit).deleteTodoEntity(item);
                      }
                    },
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildItem(TodoEntity item, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Dismissible(
        key: ValueKey(item.id),
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          (widget.todoCubit as TodoCubit).deleteTodoEntity(item);
        },
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        child: SliverDoneItem(
          index: index,
          title: item.title,
          onCheckboxTap: () {},
          onDeleteTap: () {
            (widget.todoCubit as TodoCubit).deleteTodoEntity(item);
          },
        ),
      ),
    );
  }
}
