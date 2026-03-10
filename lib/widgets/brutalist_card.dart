import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BrutalistCard extends StatelessWidget {
  const BrutalistCard({
    super.key,
    required this.child,
    this.backgroundColor = AppPalette.surface,
    this.padding = const EdgeInsets.all(18),
    this.borderRadius = 28,
  });

  final Widget child;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: AppPalette.ink, width: 2),
        boxShadow: const [
          BoxShadow(color: AppPalette.ink, offset: Offset(4, 4)),
        ],
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}
