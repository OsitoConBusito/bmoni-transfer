import 'package:bmoni_transfer/shared/design_system/tokens/app_motion.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

CustomTransitionPage<void> slidePage({
  required LocalKey key,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: key,
    child: child,
    transitionDuration: AppMotion.pageTransition,
    reverseTransitionDuration: AppMotion.pageTransition,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final enter = CurvedAnimation(
        parent: animation,
        curve: AppMotion.pageEnterCurve,
        reverseCurve: AppMotion.pageExitCurve,
      );
      final exit = CurvedAnimation(
        parent: secondaryAnimation,
        curve: AppMotion.pageExitCurve,
        reverseCurve: AppMotion.pageEnterCurve,
      );
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(enter),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset.zero,
            end: const Offset(-AppMotion.pageExitParallax, 0),
          ).animate(exit),
          child: FadeTransition(opacity: enter, child: child),
        ),
      );
    },
  );
}
