import 'package:flutter/material.dart';
import 'check_painter.dart';

final class GeenCheckbox extends StatelessWidget {
  final double size;
  final double borderRadius;
  final double strokeWidth;

  const GeenCheckbox({
    super.key,
    required this.size,
    required this.borderRadius,
    required this.strokeWidth,
  });

  static const (double, double) _animateProgress = (0.0, 1.0);
  static const int _animateDuration = 200;
  static const Color _backgroundColor = Colors.green;

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
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: _animateProgress.$1, end: _animateProgress.$2),
          duration: const Duration(milliseconds: _animateDuration),
          builder: (context, progress, child) {
            return CustomPaint(
              size: Size(size, size),
              painter: CheckPainter(
                strokeWidth: strokeWidth,
                progress: progress,
              ),
            );
          },
        ),
      ),
    );
  }
}
