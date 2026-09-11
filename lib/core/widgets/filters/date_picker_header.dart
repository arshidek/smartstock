import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../constants/app_colors.dart';

class DatePickerHeader extends StatelessWidget {
  final DateTime selectedDate;

  const DatePickerHeader({Key? key, required this.selectedDate})
    : super(key: key);

  static const _monthsShort = [
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
  static const _weekdaysShort = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];
  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String _formatDateTop(DateTime date) {
    return '${_weekdaysShort[date.weekday - 1]}, ${_monthsShort[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatDateBottom(DateTime date) {
    return '${_months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.padding8),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppSizes.borderRadius12,
                    ),
                  ),
                  child: const Icon(
                    Icons.calendar_today_rounded,
                    color: AppColors.blue,
                  ),
                ),
                const SizedBox(width: AppSizes.size12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select Date",
                      style: TextStyle(
                        fontSize: AppSizes.font18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "Choose a date for your filter",
                      style: TextStyle(
                        fontSize: AppSizes.font13,
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => AppNavigation.goBack(context),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSizes.padding20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.blue.withOpacity(0.1),
                AppColors.blue.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppSizes.borderRadius16),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SELECTED DATE",
                      style: TextStyle(
                        fontSize: AppSizes.font10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: AppSizes.size5),
                    Text(
                      _formatDateTop(selectedDate),
                      style: const TextStyle(
                        fontSize: AppSizes.font22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: AppSizes.size8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          size: AppSizes.size15,
                          color: AppColors.blue,
                        ),
                        const SizedBox(width: AppSizes.size5),
                        Text(
                          _formatDateBottom(selectedDate),
                          style: TextStyle(
                            fontSize: AppSizes.font12,
                            color: AppColors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.calendar_month_rounded,
                size: AppSizes.size60,
                color: AppColors.blue.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
