import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';

class PieChartDataPoint {
  final String label;
  final double value;
  final Color color;
  final String suffix; // e.g. " (32%)" or "₹3,06,250"

  PieChartDataPoint({
    required this.label,
    required this.value,
    required this.color,
    this.suffix = "",
  });
}

class CategoryPieChart extends StatelessWidget {
  final String title;
  final List<PieChartDataPoint> data;
  final String centerTitle;
  final String centerSubtitle;
  final Widget? trailing; // e.g. "VIEW DETAILS" button

  const CategoryPieChart({
    super.key,
    required this.title,
    required this.data,
    required this.centerTitle,
    this.centerSubtitle = "",
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final total = data.isEmpty
        ? 0.0
        : data.map((e) => e.value).reduce((a, b) => a + b);

    return AppCardWidget(
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: AppSizes.padding20),
          Row(
            children: [
              // Chart
              SizedBox(
                height: 120,
                width: 120,
                child: Stack(
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 2,
                        centerSpaceRadius: 45,
                        sections: data.isEmpty
                            ? [
                                PieChartSectionData(
                                  color: AppColors.grey.withValues(alpha: 0.2),
                                  value: 1,
                                  title: '',
                                  radius: 12,
                                ),
                              ]
                            : data.map((point) {
                                final percentage = total == 0
                                    ? 0
                                    : (point.value / total) * 100;
                                return PieChartSectionData(
                                  color: point.color,
                                  value: total == 0
                                      ? 1
                                      : (point.value == 0
                                            ? 0.0001
                                            : point.value),
                                  title: '', // Don't show text on the segments
                                  radius: 12,
                                );
                              }).toList(),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (centerSubtitle.isNotEmpty)
                            Text(
                              centerSubtitle,
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.grey,
                              ),
                            ),
                          Text(
                            centerTitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.padding20),
              // Legend
              Expanded(
                child: data.isEmpty
                    ? const Center(
                        child: Text(
                          "No categories found. Create a category to see it here.",
                          style: TextStyle(color: AppColors.grey, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: data.map((point) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: point.color,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    point.label,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.grey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (point.suffix.isNotEmpty)
                                  Text(
                                    point.suffix,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
