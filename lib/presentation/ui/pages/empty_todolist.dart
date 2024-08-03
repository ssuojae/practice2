import 'package:flutter/material.dart';
import '../widgets/bar/fixed_appbar.dart';
import '../widgets/button/add_button.dart';

class EmptyTodolist extends StatelessWidget {
  final PageController pageController;

  const EmptyTodolist({super.key, required this.pageController});

  static const String _noTaskImage = 'assets/notask.png';
  static const double _imageWidth = 150.0;
  static const double _imageHeight = 150.0;
  static const double _verticalPadding = 20.0;
  static const String _noTaskText = 'You have no task listed.';
  static const double _textFontSize = 16.0;
  static const Color _textColor = Colors.grey;

  void _navigateToTaskPage() {
    pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FixedAppBar(
        titleText: "Create",
        welcomeText: "Welcome",
        highlightText: ' tasks',
        endText: ' to achieve more',
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.1),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  _noTaskImage,
                  width: _imageWidth,
                  height: _imageHeight,
                ),
                const SizedBox(height: _verticalPadding),
                const Text(
                  _noTaskText,
                  style: TextStyle(
                    color: _textColor,
                    fontSize: _textFontSize,
                  ),
                ),
                const SizedBox(height: _verticalPadding),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 40.0,
        ),
        child: AddButton(
          onPressed: _navigateToTaskPage,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
