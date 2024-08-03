import 'package:flutter/material.dart';

class GreyCheckbox extends StatelessWidget {
  const GreyCheckbox({
    super.key,
    this.width = 28.0, // 기본 너비를 28로 설정
    this.height = 28.0, // 기본 높이를 28로 설정
    this.iconSize = 14.0, // 기본 아이콘 크기를 14로 설정
    this.child,
  });

  final double width;
  final double height;
  final double iconSize;
  final Widget? child;

  static const double _borderRadiusValue = 7.0;
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
        child: child,
      ),
    );
  }
}
