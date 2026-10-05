import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppRefreshIndicator extends StatelessWidget {
  final RefreshCallback onRefresh;
  final Widget child;
  final double displacement;
  final double edgeOffset;
  final bool enabled;

  const AppRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.displacement = 56,
    this.edgeOffset = 0,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      displacement: displacement,
      edgeOffset: edgeOffset,
      color: AppColors.orange,
      backgroundColor: AppColors.white,
      elevation: 2,
      strokeWidth: 2.5,
      child: child,
    );
  }
}
