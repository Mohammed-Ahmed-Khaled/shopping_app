import 'package:flutter/material.dart';

class AnimatedPageTransition extends PageRouteBuilder {
  final Widget page;

  AnimatedPageTransition({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(seconds: 1),
        );
}
