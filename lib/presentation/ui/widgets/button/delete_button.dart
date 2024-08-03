import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(100, 255, 192, 192), // 빨간색 배경색, 불투명도 낮춤
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // 둥근 모서리
        ),
        disabledForegroundColor: Colors.transparent.withOpacity(0.38), 
        disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        elevation: 0,
        splashFactory: NoSplash.splashFactory, // 비활성화 시 투명
        shadowColor: Colors.transparent, // 그림자 제거
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.delete, color: Colors.red), // 휴지통 아이콘
          SizedBox(width: 8),
          Text(
            'Delete All',
            style: TextStyle(
              color: Colors.red, // 빨간색 텍스트
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
