import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../../constants/app_colors.dart';
import '../app_date_picker_bottom_sheet.dart';
import 'filter_base_components.dart';

class FilterDateSection extends StatelessWidget {
  final String selectedDateFilter;
  final DateTime? startDate;
  final DateTime? endDate;
  final ValueChanged<String> onDateFilterChanged;
  final void Function(DateTime? start, DateTime? end) onDateRangeChanged;
  final BuildContext parentContext;

  const FilterDateSection({
    Key? key,
    required this.selectedDateFilter,
    required this.startDate,
    required this.endDate,
    required this.onDateFilterChanged,
    required this.onDateRangeChanged,
    required this.parentContext,
  }) : super(key: key);

  String _formatDate(DateTime date) {
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
    return "${date.day} ${months[date.month - 1]} ${date.year}";
  }

  Widget _buildDateField(String label, bool isStartDate) {
    final hasDate = isStartDate ? startDate != null : endDate != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: AppSizes.font12,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: AppSizes.size8),
        InkWell(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
          onTap: () async {
            final picked = await showAppDatePicker(
              context: parentContext,
              initialDate: isStartDate
                  ? (startDate ?? DateTime.now())
                  : (endDate ?? DateTime.now()),
              firstDate: DateTime(2020),
              lastDate: DateTime(2100),
            );

            if (picked != null) {
              if (isStartDate) {
                onDateRangeChanged(picked, endDate);
              } else {
                onDateRangeChanged(startDate, picked);
              }
              onDateFilterChanged("");
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.padding12,
              vertical: AppSizes.padding12,
            ),
            decoration: BoxDecoration(
              color: hasDate
                  ? AppColors.blue.withOpacity(0.08)
                  : AppColors.blue.withOpacity(0.05),
              border: Border.all(
                color: hasDate
                    ? AppColors.blue.withOpacity(0.5)
                    : AppColors.blue.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: AppSizes.size18,
                  color: AppColors.blue,
                ),
                const SizedBox(width: AppSizes.size8),
                Expanded(
                  child: Text(
                    isStartDate
                        ? (startDate == null
                              ? "Select Date"
                              : _formatDate(startDate!))
                        : (endDate == null
                              ? "Select Date"
                              : _formatDate(endDate!)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: AppSizes.font13,
                      fontWeight: FontWeight.w500,
                      color: hasDate ? AppColors.blue : AppColors.grey,
                    ),
                  ),
                ),
                if (hasDate)
                  GestureDetector(
                    onTap: () {
                      if (isStartDate) {
                        onDateRangeChanged(null, endDate);
                      } else {
                        onDateRangeChanged(startDate, null);
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: AppSizes.size4),
                      child: Icon(
                        Icons.close_rounded,
                        size: AppSizes.size16,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FilterSectionCard(
      icon: Icons.calendar_month_outlined,
      title: "Date",
      subtitle: "Filter products by date range",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FilterCustomChip(
                      label: "Today",
                      icon: Icons.calendar_today_outlined,
                      iconColor: AppColors.blue,
                      iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                      isSelected: selectedDateFilter == "Today",
                      onTap: () => onDateFilterChanged(
                        selectedDateFilter == "Today" ? "" : "Today",
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.size10),
                  Expanded(
                    child: FilterCustomChip(
                      label: "Last 7 Days",
                      icon: Icons.calendar_today_outlined,
                      iconColor: AppColors.blue,
                      iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                      isSelected: selectedDateFilter == "Last 7 Days",
                      onTap: () => onDateFilterChanged(
                        selectedDateFilter == "Last 7 Days"
                            ? ""
                            : "Last 7 Days",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.size10),
              Row(
                children: [
                  Expanded(
                    child: FilterCustomChip(
                      label: "Last 30 Days",
                      icon: Icons.calendar_today_outlined,
                      iconColor: AppColors.blue,
                      iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                      isSelected: selectedDateFilter == "Last 30 Days",
                      onTap: () => onDateFilterChanged(
                        selectedDateFilter == "Last 30 Days"
                            ? ""
                            : "Last 30 Days",
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.size10),
                  Expanded(
                    child: FilterCustomChip(
                      label: "This Month",
                      icon: Icons.calendar_today_outlined,
                      iconColor: AppColors.blue,
                      iconBackgroundColor: AppColors.blue.withOpacity(0.1),
                      isSelected: selectedDateFilter == "This Month",
                      onTap: () => onDateFilterChanged(
                        selectedDateFilter == "This Month" ? "" : "This Month",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size20),
          Row(
            children: [
              Expanded(child: _buildDateField("Start Date", true)),
              const SizedBox(width: AppSizes.size15),
              Expanded(child: _buildDateField("End Date", false)),
            ],
          ),
        ],
      ),
    );
  }
}
