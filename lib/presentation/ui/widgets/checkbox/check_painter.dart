import 'package:flutter/material.dart';

final class CheckPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;

  CheckPainter({
    this.progress = 0.0,
    this.strokeWidth = 2.5,
    this.color = Colors.white,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = _createPaint();
    final path = _createPath(size);
    final extractPath = _extractProgressPath(path);
    canvas.drawPath(extractPath, paint);
  }

  Paint _createPaint() {
    return Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  Path _createPath(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.4, size.height * 0.7);
    path.lineTo(size.width * 0.8, size.height * 0.3);
    return path;
  }

  Path _extractProgressPath(Path path) {
    final pathMetrics = path.computeMetrics().toList();
    return pathMetrics.first.extractPath(0, pathMetrics.first.length * progress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}