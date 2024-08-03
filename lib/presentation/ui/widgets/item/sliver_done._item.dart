import 'package:flutter/material.dart';
import '../checkbox/grey_checkbox.dart';

class SliverDoneItem extends StatefulWidget {
  final int index;
  final String title;
  final VoidCallback onCheckboxTap;
  final VoidCallback onDeleteTap;

  const SliverDoneItem({
    super.key,
    required this.index,
    required this.title,
    required this.onCheckboxTap,
    required this.onDeleteTap,
  });

  @override
  _SliverDoneItemState createState() => _SliverDoneItemState();
}

class _SliverDoneItemState extends State<SliverDoneItem> {
  bool isRotated = false;

  void _onTapDown(TapDownDetails details) {
    setState(() {
      isRotated = true;
    });
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      isRotated = false;
    });
    widget.onCheckboxTap();
  }

  static const double _titleFontSize = 14;
  static const double _horizontalPadding = 15.0;
  static const double _verticalPadding = 15.0;
  static const double _checkboxSpacing = 12.0;
  static const double _borderRadius = 10.0;
  static const double _checkboxSize = 30.0; // 체크박스 사이즈를 28로 변경
  static const double _deleteIconSize = 24.0; // 휴지통 아이콘 사이즈를 24로 설정
  static const Color _doneBackgroundColor = Color(0xFFF5F5F5);
  static const Color _textColor = Color.fromARGB(255, 123, 122, 122);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        child: Container(
          decoration: BoxDecoration(
            color: _doneBackgroundColor,
            borderRadius: BorderRadius.circular(_borderRadius),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: _verticalPadding,
            horizontal: _horizontalPadding,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GreyCheckbox(
                width: _checkboxSize,
                height: _checkboxSize,
                iconSize: _checkboxSize * 0.5,
                child: AnimatedRotation(
                  turns: isRotated ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Icon(
                    Icons.refresh, // 되돌리기 아이콘
                    color: Colors.white,
                    size: _checkboxSize * 0.5,
                  ),
                ),
              ),
              const SizedBox(width: _checkboxSpacing),
              Expanded(
                child: Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: _titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: _textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
