import 'package:flutter/material.dart';
import '../checkbox/blue_checkbox.dart';

class MainAppbar extends StatelessWidget {
  const MainAppbar({super.key});

  static const String _title = 'Todoz';
  static const double _iconSpacing = 8.0;
  static const double _titleFontSize = 25.0;
  static const FontWeight _titleFontWeight = FontWeight.bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Hero(
              tag: 'blue_checkbox',
              createRectTween: (begin, end) {
                return RectTween(begin: begin, end: end);
              },
              child: const BlueCheckbox(
                width: 25.0,
                height: 25.0,
                iconSize: 20.0,
              ),
            ),
            const SizedBox(width: _iconSpacing),
            const Text(
              _title,
              style: TextStyle(
                fontSize: _titleFontSize,
                fontWeight: _titleFontWeight,
              ),
            ),
          ],
        ),
        Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: PopupMenuButton<String>(
            icon: Image.asset(
              'assets/align.png',
              width: 25.0,
              height: 25.0,
            ),
            onSelected: (String result) {
              if (result == 'App Info') {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('App Info'),
                      content: const Text('This is the app information.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'App Info',
                child: Text('App Info'),
              ),
            ],
            color: Colors.white, // 드롭다운 메뉴의 배경색을 흰색으로 설정
          ),
        ),
      ],
    );
  }
}
