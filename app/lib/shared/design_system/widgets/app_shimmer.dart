import 'package:bmoni_transfer/shared/design_system/tokens/app_radii.dart';
import 'package:bmoni_transfer/shared/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final base =
        theme.extension<AppColors>()?.surfaceRaised ??
        theme.colorScheme.surfaceContainerHighest;
    final highlight = Color.lerp(base, theme.colorScheme.onSurface, 0.12);
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight ?? base,
      child: child,
    );
  }
}

class AppShimmerBox extends StatelessWidget {
  const AppShimmerBox({required this.height, this.width, super.key});

  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    // An opaque placeholder just above the card tone — never stark white. The
    // Shimmer sweep animates over it; white would flash on the dark theme.
    final theme = Theme.of(context);
    final base =
        theme.extension<AppColors>()?.surfaceRaised ??
        theme.colorScheme.surfaceContainerHighest;
    final placeholder = Color.alphaBlend(
      theme.colorScheme.onSurface.withValues(alpha: 0.10),
      base,
    );
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: placeholder,
        borderRadius: BorderRadius.circular(AppRadii.sm),
      ),
    );
  }
}
