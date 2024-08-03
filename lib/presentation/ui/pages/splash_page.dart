import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/todo_item_model.dart';
import '../../../../../data/repositories/todo_repository.dart';
import '../widgets/checkbox/blue_checkbox.dart';
import 'homepage.dart';

final class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

final class _SplashScreenState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _textAnimation;
  late Future<List<TodoEntity>> _TodoEntitysFuture;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _positionAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _rotationAnimation = Tween<double>(begin: -0.7, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _textAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
    );

    _controller.forward();

    

    Timer(const Duration(milliseconds: 2500), () async {
      final todos = await TodoRepository().requestTodos(); // 데이터 가져올 때까지 스플래쉬 페이지 대기
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1500),
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(todos: todos),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = 0.0;
            const end = 1.0;
            const curve = Curves.easeInOut;

            final tween = Tween(begin: begin, end: end);
            final curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
            );

            return FadeTransition(
              opacity: tween.animate(curvedAnimation),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.translate(
                  offset: Offset(0, -350 * (1 - _positionAnimation.value)),
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: child,
                  ),
                ),
                FadeTransition(
                  opacity: _textAnimation,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Todoz',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          child: Hero(
            tag: 'blue_checkbox',
            createRectTween: (begin, end) {
              return RectTween(begin: begin, end: end);
            },
            child: const BlueCheckbox(
              width: 40.0,
              height: 40.0,
              iconSize: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}