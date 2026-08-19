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
    // If the screen is very small, switch to a vertical layout to prevent overflow
    final bool isSmallScreen = Responsive.isMobile(context);

    if (isSmallScreen) {
      final List<Widget> columnChildren = [];

      for (final child in children) {
        if (child is SizedBox && child.width != null) {
          // Convert horizontal spacing to vertical spacing
          columnChildren.add(const SizedBox(height: AppSizes.size15));
        } else if (child is Expanded) {
          // Unwrap Expanded widgets since they will throw errors inside unbounded Columns
          columnChildren.add(child.child);
        } else if (child is Flexible) {
          // Unwrap Flexible widgets as well
          columnChildren.add(child.child);
        } else {
          // Keep other widgets as they are
          columnChildren.add(child);
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      );
    }

    // Standard Row layout for larger screens
    return Row(crossAxisAlignment: crossAxisAlignment, children: children);
  }
}
