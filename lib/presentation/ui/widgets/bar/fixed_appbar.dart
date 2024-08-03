import 'package:flutter/material.dart';

class FixedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String welcomeText;
  final String highlightText;
  final String endText;

  const FixedAppBar({
    super.key,
    required this.titleText,
    required this.welcomeText,
    required this.highlightText,
    required this.endText,
  });

  static const double _appBarHeight = 80.0;
  static const double _leftPadding = 20.0;
  static const double _bottomPadding = 10.0;
  static const double _titleFontSize = 17.0;
  static const double _welcomeFontSize = 19.0;
  static const double _welcomeBottomPadding = 40.0;
  static const Color _highlightColor = Colors.blue;
  static const Color _backgroundColor = Colors.white;
  static const Color _titleColor = Colors.black;
  static const Color _welcomeColor = Colors.black;

  @override
  Size get preferredSize => const Size.fromHeight(_appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: _backgroundColor,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          color: _backgroundColor,
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: _leftPadding,
                bottom: _welcomeBottomPadding,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  welcomeText,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: _welcomeFontSize,
                    color: _welcomeColor,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: _leftPadding,
                  bottom: _bottomPadding,
                ),
                child: RichText(
                  text: TextSpan(
                    text: titleText,
                    style: const TextStyle(
                      fontSize: _titleFontSize,
                      color: _titleColor,
                    ),
                    children: [
                      TextSpan(
                        text: highlightText,
                        style: const TextStyle(
                          color: _highlightColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(text: endText),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
