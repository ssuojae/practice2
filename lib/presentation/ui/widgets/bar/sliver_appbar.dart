import 'package:flutter/material.dart';
import 'dart:ui';

class CustomSliverAppBar extends StatelessWidget {
  final String titleText;
  final String welcomeText;
  final String highlightText;
  final String endText;

  const CustomSliverAppBar({
    super.key,
    required this.titleText,
    required this.welcomeText,
    required this.highlightText,
    required this.endText,
  });

  static const double _expandedHeight = 80.0;
  static const double _leftPadding = 20.0;
  static const double _bottomPadding = 10.0;
  static const double _titleFontSize = 12.0;
  static const double _welcomeFontSize = 18.0;
  static const double _welcomeBottomPadding = 40.0;
  static const Color _highlightColor = Colors.blue;
  static const Color _backgroundColor = Colors.white;
  static const Color _titleColor = Colors.black;
  static const Color _welcomeColor = Colors.black;
  static const double _startOpacity = 0.5;
  static const double _endOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      scrolledUnderElevation: 0,
      expandedHeight: _expandedHeight,
      floating: false,
      pinned: true,
      snap: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  _backgroundColor.withOpacity(_startOpacity),
                  _backgroundColor.withOpacity(_endOpacity),
                ],
              ),
            ),
            child: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(
                left: _leftPadding,
                bottom: _bottomPadding,
              ),
              title: Align(
                alignment: Alignment.bottomLeft,
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
              background: Stack(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
