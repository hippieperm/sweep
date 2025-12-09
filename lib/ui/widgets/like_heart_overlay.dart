import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// 더블탭 시 보여줄 하트 애니메이션 오버레이
class LikeHeartOverlay extends StatelessWidget {
  final bool isVisible;
  const LikeHeartOverlay({super.key, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isVisible ? 1.0 : 0.0,
        child: Center(
          child: Lottie.asset(
            'assets/lottie/like.json',
            width: 180,
            repeat: false,
          ),
        ),
      ),
    );
  }
}
