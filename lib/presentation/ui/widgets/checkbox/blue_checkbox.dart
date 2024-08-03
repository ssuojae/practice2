import 'package:flutter/material.dart';
import 'check_painter.dart';

final class BlueCheckbox extends StatelessWidget {
  const BlueCheckbox({
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
  static const Color _containerColor = Colors.blue;

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