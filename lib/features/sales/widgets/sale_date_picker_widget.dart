import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/widgets/filters/app_date_picker_bottom_sheet.dart';

class SaleDatePickerWidget extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;

  const SaleDatePickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: () async {
              final pickedDate = await showAppDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2024),
                lastDate: DateTime.now(),
              );
              if (pickedDate != null) onDateChanged(pickedDate);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding10,
                vertical: AppSizes.padding8,
              ),
              decoration: BoxDecoration(
                color: AppColors.blue.withValues(alpha: .08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.blue.withValues(alpha: .25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: AppSizes.size15,
                            color: AppColors.blue,
                          ),
                          const SizedBox(width: AppSizes.size5),
                          Text(
                            "${selectedDate.day} ${["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"][selectedDate.month - 1]} ${selectedDate.year}",
                            style: const TextStyle(
                              color: AppColors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: AppSizes.font13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
