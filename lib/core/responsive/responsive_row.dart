import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import 'responsive.dart';

class ResponsiveRow extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  const ResponsiveRow({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = Responsive.isMobile(context);

    if (isSmallScreen) {
      final List<Widget> columnChildren = [];

      for (final child in children) {
        if (child is SizedBox && child.width != null) {
          columnChildren.add(const SizedBox(height: AppSizes.size15));
        } else if (child is Expanded) {
          columnChildren.add(child.child);
        } else if (child is Flexible) {
          columnChildren.add(child.child);
        } else {
          columnChildren.add(child);
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      );
    }

    return Row(crossAxisAlignment: crossAxisAlignment, children: children);
  }
}
