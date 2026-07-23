import 'package:flutter/animation.dart';

/// Motion constants for page transitions. A single shared feel across the
/// wizard (amount → confirmation → result) keeps push/pop symmetric.
abstract final class AppMotion {
  static const Duration pageTransition = Duration(milliseconds: 320);
  static const Curve pageEnterCurve = Curves.easeOutCubic;
  static const Curve pageExitCurve = Curves.easeInCubic;

  /// How far the page being covered parallax-slides, as a fraction of width.
  static const double pageExitParallax = 0.24;

  /// The success badge's pop-in: a slight overshoot-then-settle, echoing the
  /// design's own bounce keyframe.
  static const Duration badgePop = Duration(milliseconds: 500);
  static const Curve badgePopCurve = Curves.easeOutBack;
}
