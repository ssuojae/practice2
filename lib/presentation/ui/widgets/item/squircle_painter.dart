import 'package:flutter/material.dart';

class SquirclePainter extends CustomPainter {
  final Color color;
  final double borderRadius;

  SquirclePainter({
    required this.color,
    this.borderRadius = 10.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(borderRadius, 0)
      ..lineTo(size.width - borderRadius, 0)
      ..quadraticBezierTo(size.width, 0, size.width, borderRadius)
      ..lineTo(size.width, size.height - borderRadius)
      ..quadraticBezierTo(size.width, size.height, size.width - borderRadius, size.height)
      ..lineTo(borderRadius, size.height)
      ..quadraticBezierTo(0, size.height, 0, size.height - borderRadius)
      ..lineTo(0, borderRadius)
      ..quadraticBezierTo(0, 0, borderRadius, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GreyCheckbox extends StatelessWidget {
  const GreyCheckbox({
    super.key,
    this.width = 25.0,
    this.height = 25.0,
    this.iconSize = 20.0,
  });

  final double width;
  final double height;
  final double iconSize;

  static const double _borderRadiusValue = 7.0;
  static const double checkBarProgress = 1.0; 
  static const Color _containerColor = Color(0xFFD3D3D3);

  @override
  Widget build(BuildContext context) => _buildIconContainer();
  
  Widget _buildIconContainer() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: _containerColor,
        borderRadius: BorderRadius.circular(_borderRadiusValue),
      ),
      child: Center(
        child: CustomPaint(
          size: Size(iconSize, iconSize),
          painter: CheckPainter(progress: checkBarProgress),
        ),
      ),
    );
  }
}

class CheckPainter extends CustomPainter {
  final double progress;

  CheckPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CheckPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
