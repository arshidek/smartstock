import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../function/inventory_report_functions.dart';
import 'mobile/mobile_inventory_report_view.dart';
import 'web/web_inventory_report_view.dart';

class InventoryReportView extends StatelessWidget {
  final InventoryReportFunctions functions;
  final DateTime? selectedDate;
  final VoidCallback? onDateTap;

  const InventoryReportView({
    super.key,
    required this.functions,
    this.selectedDate,
    this.onDateTap,
  });

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? WebInventoryReportView(
            functions: functions,
            selectedDate: selectedDate,
            onDateTap: onDateTap,
          )
        : MobileInventoryReportView(
            functions: functions,
            selectedDate: selectedDate,
            onDateTap: onDateTap,
          );
  }
}
