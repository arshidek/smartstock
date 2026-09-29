import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../function/revenue_report_functions.dart';
import '../../function/top_selling_report_functions.dart';
import 'mobile/mobile_revenue_report_view.dart';
import 'web/web_revenue_report_view.dart';

class RevenueReportView extends StatelessWidget {
  final RevenueReportFunctions functions;
  final TopSellingReportFunctions topSellingFunctions;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const RevenueReportView({
    super.key,
    required this.functions,
    required this.topSellingFunctions,
    this.selectedDate,
    this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? WebRevenueReportView(
            functions: functions,
            topSellingFunctions: topSellingFunctions,
            selectedDate: selectedDate,
            onDateTap: onDateTap,
          )
        : MobileRevenueReportView(
            functions: functions,
            topSellingFunctions: topSellingFunctions,
            selectedDate: selectedDate,
            onDateTap: onDateTap,
          );
  }
}
