import 'package:flutter/material.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/widgets/cards/app_stats_card.dart';

class SummaryMetric {
  final IconData icon;
  final String title;
  final String value;
  final double percentage;
  final bool isPositive;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String? subtitle;

  SummaryMetric({
    required this.icon,
    required this.title,
    required this.value,
    required this.percentage,
    required this.isPositive,
    required this.iconColor,
    required this.iconBackgroundColor,
    this.subtitle,
  });
}

class SummaryCardGrid extends StatelessWidget {
  final List<SummaryMetric> metrics;

  const SummaryCardGrid({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: metrics.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: AppSizes.padding16,
        mainAxisSpacing: AppSizes.padding16,
        childAspectRatio: Responsive.isMobile(context)
            ? 0.9
            : Responsive.isTablet(context)
                ? 1.5
                : 1.6,
      ),
      itemBuilder: (context, index) {
        return _buildCard(metrics[index]);
      },
    );
  }

  Widget _buildCard(SummaryMetric metric) {
    // Format the subtitle for AppStatsCard
    final String subtitleText = metric.subtitle != null
        ? metric.subtitle!
        : metric.percentage == 0.0 
            ? "" 
            : metric.isPositive 
                ? "📈 increased by ${metric.percentage}%" 
                : "📉 decreased by ${metric.percentage}%";

    return AppStatsCard(
      title: metric.title,
      value: metric.value,
      subtitle: subtitleText,
      icon: metric.icon,
      iconBackgroundColor: metric.iconBackgroundColor,
      iconColor: metric.iconColor,
    );
  }
}
