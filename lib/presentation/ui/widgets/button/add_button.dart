import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(100, 197, 226, 255), 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), 
        ), disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 0,
        splashFactory: NoSplash.splashFactory, // 비활성화 시 투명
        shadowColor: Colors.transparent, // 그림자 제거
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.add, color: Colors.blue), 
          SizedBox(width: 8),
          Text(
            'Create task',
            style: TextStyle(
              color: Colors.blue, 
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}