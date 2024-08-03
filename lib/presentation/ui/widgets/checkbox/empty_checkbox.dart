import 'package:flutter/material.dart';

final class EmptyCheckbox extends StatelessWidget {
  final double size;
  final double borderRadius;
  final double borderWidth;

  const EmptyCheckbox({
    super.key,
    this.size = 24.0,
    this.borderRadius = 7.0,
    this.borderWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: Colors.grey, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
