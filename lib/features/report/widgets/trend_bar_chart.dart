import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/cards/app_card_widget.dart';

class ChartDataPoint {
  final String label;
  final double value;

  ChartDataPoint({required this.label, required this.value});
}

class TrendBarChart extends StatelessWidget {
  final String title;
  final List<ChartDataPoint> data;
  final Color barColor;
  final Color highlightBarColor;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const TrendBarChart({
    super.key,
    required this.title,
    required this.data,
    required this.barColor,
    required this.highlightBarColor,
    this.selectedDate,
    this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox.shrink();
    }

    final double rawMaxValue = data
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b);
    final double maxValue = rawMaxValue == 0 ? 10.0 : rawMaxValue;

    final currentDate = selectedDate ?? DateTime.now();
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final dateString =
        "${currentDate.day} ${months[currentDate.month - 1]} ${currentDate.year}";

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
                  fontSize: AppSizes.font18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: onDateTap,
                borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.padding12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withValues(alpha: 0.1),
                    border: Border.all(
                      color: AppColors.blue.withValues(alpha: 0.3),
                    ),
                    borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: AppSizes.size16,
                        color: AppColors.blue,
                      ),
                      const SizedBox(width: AppSizes.padding8),
                      Text(
                        dateString,
                        style: const TextStyle(
                          fontSize: AppSizes.font14,
                          color: AppColors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.padding20),
          SizedBox(
            height: 280,
            child: Stack(
              children: [
                // Custom Background Grid Lanes
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.1),
                    border: Border(
                      left: BorderSide(
                        color: AppColors.grey.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      right: BorderSide(
                        color: AppColors.grey.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      top: BorderSide(
                        color: AppColors.grey.withValues(alpha: 0.2),
                        width: 1,
                      ),
                      bottom: BorderSide(
                        color: AppColors.grey.withValues(alpha: 0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: List.generate(
                      data.length,
                      (index) => Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: index < data.length - 1
                                ? Border(
                                    right: BorderSide(
                                      color: AppColors.grey.withValues(
                                        alpha: 0.2,
                                      ),
                                      width: 1,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // The Chart
                BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxValue * 1.2, // Add some headroom
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => AppColors.black,
                        tooltipPadding: const EdgeInsets.all(AppSizes.padding8),
                        tooltipMargin: AppSizes.padding8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '₹${rod.toY.toStringAsFixed(0)}',
                            TextStyle(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizes.font14,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index < 0 || index >= data.length)
                              return const SizedBox.shrink();

                            return Padding(
                              padding: const EdgeInsets.only(
                                top: AppSizes.padding8,
                              ),
                              child: Text(
                                data[index].label,
                                style: const TextStyle(
                                  color: AppColors.grey,
                                  fontSize: AppSizes.font12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          },
                          reservedSize: 28,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: const FlGridData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(
                          color: AppColors.grey.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                    ),
                    barGroups: data.asMap().entries.map((entry) {
                      final index = entry.key;
                      final point = entry.value;

                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(
                            toY: point.value,
                            width: 45,
                            color: highlightBarColor.withValues(
                              alpha:
                                  0.2 +
                                  (index /
                                          (data.length > 1
                                              ? data.length - 1
                                              : 1)) *
                                      0.8,
                            ),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
