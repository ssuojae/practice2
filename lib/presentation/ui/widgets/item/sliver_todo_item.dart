import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/todo_item_model.dart';
import '../../../cubit_viewmodel/todo_cubit.dart';
import '../checkbox/empty_checkbox.dart';
import '../checkbox/orange_checkbox.dart';
import '../checkbox/green_checkbox.dart';
import 'squircle_painter.dart';

class SliverTodoItem extends StatelessWidget {
  final int index;
  final TodoEntity todo;
  final VoidCallback onCheckboxTap;
  final VoidCallback onLongPress;

  const SliverTodoItem({
    super.key,
    required this.index,
    required this.todo,
    required this.onCheckboxTap,
    required this.onLongPress,
  });

  static const double _titleFontSize = 17;
  static const double _descriptionFontSize = 13;
  static const double _horizontalPadding = 10.0;
  static const double _containerPadding = 15.0;
  static const double _checkboxSpacing = 8.0;
  static const double _descriptionSpacing = 5.0;
  static const double _borderRadius = 20.0;
  static const double _checkboxWidth = 28.0; 
  static const Color _emptyBackgroundColor = Color(0xFFEEEEEE);
  static const Color _inProgressBackgroundColor = Color(0xFFFFE0B2);
  static const Color _completeBackgroundColor = Color.fromARGB(255, 212, 237, 213);
  static const Color _emptyTextColor = Color.fromARGB(255, 98, 97, 97);
  static const Color _inProgressTextColor = Colors.orange;
  static const Color _completeTextColor = Colors.green;
  static const Color _defaultTextColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: GestureDetector(
        onTap: onCheckboxTap,
        onLongPress: onLongPress,
        child: CustomPaint(
          painter: SquirclePainter(
            color: _getBackgroundColor(todo.state),
            borderRadius: _borderRadius,
          ),
          child: Container(
            padding: const EdgeInsets.all(_containerPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _CustomCheckbox(state: todo.state),
                    const SizedBox(width: _checkboxSpacing),
                    Text(
                      todo.title,
                      style: TextStyle(
                        fontSize: _titleFontSize,
                        fontWeight: FontWeight.bold,
                        color: _getTextColor(todo.state),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: _descriptionSpacing),
                Row(
                  children: [
                    const SizedBox(width: _checkboxWidth),
                    Expanded(
                      child: Text(
                        todo.description,
                        style: const TextStyle(
                          fontSize: _descriptionFontSize,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor(TodoEntityState state) {
    switch (state) {
      case TodoEntityState.empty:
        return _emptyBackgroundColor;
      case TodoEntityState.inProgress:
        return _inProgressBackgroundColor;
      case TodoEntityState.complete:
        return _completeBackgroundColor;
      default:
        return Colors.transparent;
    }
  }

  Color _getTextColor(TodoEntityState state) {
    switch (state) {
      case TodoEntityState.empty:
        return _emptyTextColor;
      case TodoEntityState.inProgress:
        return _inProgressTextColor;
      case TodoEntityState.complete:
        return _completeTextColor;
      default:
        return _defaultTextColor;
    }
  }
}

class _CustomCheckbox extends StatelessWidget {
  final TodoEntityState state;

  const _CustomCheckbox({required this.state});

  static const double size = 20.0; 
  static const double _borderRadius = 7.0;
  static const double _borderWidth = 2.0;
  static const double _progressIndicatorSize = 10.0;
  static const double _checkStrokeWidth = 2.3;

  @override
  Widget build(BuildContext context) => _buildCheckbox(context);

  Widget _buildCheckbox(BuildContext context) {
    switch (state) {
      case TodoEntityState.empty:
        return const EmptyCheckbox(
          size: size,
          borderRadius: _borderRadius,
          borderWidth: _borderWidth,
        );
      case TodoEntityState.inProgress:
        return const OrangeCheckbox(
          size: size,
          borderRadius: _borderRadius,
          progressIndicatorSize: _progressIndicatorSize,
        );
      case TodoEntityState.complete:
        return const GeenCheckbox(
          size: size,
          borderRadius: _borderRadius,
          strokeWidth: _checkStrokeWidth,
        );
      default:
        return Container();
    }
  }
}
