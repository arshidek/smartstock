import 'package:flutter/material.dart';
import 'package:smartstock_inventory/app/app_navigation.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../constants/app_colors.dart';
import '../buttons/app_button.dart';
import '../buttons/app_outline_button.dart';
import 'date_picker_header.dart';
import 'date_picker_calendar.dart';

class AppDatePickerBottomSheet extends StatefulWidget {
  final DateTime? initialDate;
  final DateTime firstDate;
  final DateTime lastDate;

  const AppDatePickerBottomSheet({
    Key? key,
    this.initialDate,
    required this.firstDate,
    required this.lastDate,
  }) : super(key: key);

  @override
  State<AppDatePickerBottomSheet> createState() =>
      _AppDatePickerBottomSheetState();
}

class _AppDatePickerBottomSheetState extends State<AppDatePickerBottomSheet> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate =
        widget.initialDate ?? DateTime(now.year, now.month, now.day);
    _currentMonth = DateTime(_selectedDate.year, _selectedDate.month, 1);
  }

  void _changeMonth(int offset) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + offset,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSizes.borderRadius25),
        ),
      ),
      child: Column(
        children: [
          // Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppSizes.margin12, bottom: 8),
              width: AppSizes.size55,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.padding20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DatePickerHeader(selectedDate: _selectedDate),
                    const SizedBox(height: AppSizes.size24),
                    DatePickerCalendar(
                      currentMonth: _currentMonth,
                      selectedDate: _selectedDate,
                      onChangeMonth: _changeMonth,
                      onDateSelected: (date) {
                        setState(() {
                          _selectedDate = date;
                          if (date.month != _currentMonth.month) {
                            _currentMonth = DateTime(date.year, date.month, 1);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: AppSizes.size24),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Buttons
          Padding(
            padding: const EdgeInsets.all(AppSizes.padding20),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: AppOutlineButton(
                    onPressed: () => AppNavigation.goBack(context),
                    text: "Cancel",
                    expandText: false,
                  ),
                ),
                const SizedBox(width: AppSizes.size15),
                Expanded(
                  flex: 1,
                  child: AppButton(
                    onPressed: () =>
                        AppNavigation.goBackWithResult(context, _selectedDate),
                    text: "Apply Date →",
                    icon: null,
                    backgroundColor: AppColors.blue,
                    textColor: AppColors.white,
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

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  return showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => AppDatePickerBottomSheet(
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2100),
    ),
  );
}
