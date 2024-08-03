import 'package:flutter/material.dart';

final class OrangeCheckbox extends StatelessWidget {
  final double size;
  final double borderRadius;
  final double progressIndicatorSize;

  const OrangeCheckbox({
    super.key,
    required this.size,
    required this.borderRadius,
    required this.progressIndicatorSize,
  });

  static const double _indicatorWidth = 2.0;
  static const Color _backgroundColor = Colors.orange;
  static const Color _indicatorColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: SizedBox(
          width: progressIndicatorSize,
          height: progressIndicatorSize,
          child: const CircularProgressIndicator(
            strokeWidth: _indicatorWidth,
            valueColor: AlwaysStoppedAnimation<Color>(_indicatorColor),
          ),
        ),
      ),
    );
  }
}