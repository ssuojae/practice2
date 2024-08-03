import 'package:flutter/material.dart';
import 'dart:ui';

 final class MainNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  static const double _iconSize = 25.0;
  static const double _labelFontSize = 13.0;

  const MainNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(1.0),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              currentIndex: currentIndex,
              onTap: (index) {
                onTap(index);
              },
              selectedItemColor: Colors.blue,
              unselectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(fontSize: _labelFontSize),
              unselectedLabelStyle: const TextStyle(fontSize: _labelFontSize),
              items: [
                _buildBottomNavigationBarItem(
                  'assets/todolist.png',
                  'Todo',
                  0,
                ),
                _buildBottomNavigationBarItem(
                  'assets/create.png',
                  'Create',
                  1,
                ),
                _buildBottomNavigationBarItem(
                  'assets/done.png',
                  'Done',
                  2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
    String assetName,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      icon: _IconBuilder(
        assetName: assetName,
        isSelected: currentIndex == index,
      ),
      label: label,
    );
  }
}

class _IconBuilder extends StatelessWidget {
  final String assetName;
  final bool isSelected;

  const _IconBuilder({
    required this.assetName,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.blue : Colors.grey,
        BlendMode.srcIn,
      ),
      child: Image.asset(
        assetName,
        width: MainNavigationBar._iconSize,
        height: MainNavigationBar._iconSize,
      ),
    );
  }
}
