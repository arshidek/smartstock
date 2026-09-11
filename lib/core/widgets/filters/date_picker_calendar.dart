import 'package:flutter/material.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../constants/app_colors.dart';

class DatePickerCalendar extends StatelessWidget {
  final DateTime currentMonth;
  final DateTime selectedDate;
  final ValueChanged<int> onChangeMonth;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerCalendar({
    Key? key,
    required this.currentMonth,
    required this.selectedDate,
    required this.onChangeMonth,
    required this.onDateSelected,
  }) : super(key: key);

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

  String _formatMonthYear(DateTime date) {
    return '${_months[date.month - 1]} ${date.year}';
  }

  List<DateTime> _generateCalendarDays() {
    final days = <DateTime>[];
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(
      currentMonth.year,
      currentMonth.month + 1,
      0,
    );

    final firstWeekday = firstDayOfMonth.weekday;
    final offset = firstWeekday == 7 ? 0 : firstWeekday;

    for (int i = offset - 1; i >= 0; i--) {
      days.add(firstDayOfMonth.subtract(Duration(days: i + 1)));
    }

    for (int i = 0; i < lastDayOfMonth.day; i++) {
      days.add(firstDayOfMonth.add(Duration(days: i)));
    }

    int remaining = 42 - days.length;
    for (int i = 1; i <= remaining; i++) {
      days.add(lastDayOfMonth.add(Duration(days: i)));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final calendarDays = _generateCalendarDays();
    final weekdays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return Column(
      children: [
        // Controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => onChangeMonth(-1),
              icon: const Icon(Icons.chevron_left),
            ),
            Text(
              _formatMonthYear(currentMonth),
              style: const TextStyle(
                fontSize: AppSizes.font16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            IconButton(
              onPressed: () => onChangeMonth(1),
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size15),

        // Weekdays
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekdays
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: AppSizes.font12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: AppSizes.size8),

        // Calendar Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: calendarDays.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final date = calendarDays[index];
            final isCurrentMonth = date.month == currentMonth.month;
            final isSelected =
                date.year == selectedDate.year &&
                date.month == selectedDate.month &&
                date.day == selectedDate.day;

            return GestureDetector(
              onTap: () => onDateSelected(date),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.blue : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        fontSize: AppSizes.font14,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: isSelected
                            ? AppColors.white
                            : (isCurrentMonth
                                  ? AppColors.black
                                  : AppColors.lightGrey),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
