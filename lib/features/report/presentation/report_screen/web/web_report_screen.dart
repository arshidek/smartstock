import 'package:flutter/material.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/services/pdf_report_service.dart';
import '../../../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../../../function/inventory_report_functions.dart';
import '../../../function/revenue_report_functions.dart';
import '../../../function/top_selling_report_functions.dart';
import '../../../widgets/report_app_bar.dart';
import '../../../widgets/report_tabs.dart';
import '../../inventory_report/inventory_report_view.dart';
import '../../revenue_report/revenue_report_view.dart';

class WebReportScreen extends StatelessWidget {
  final int selectedTabIndex;
  final ValueChanged<int> onTabChanged;
  final DateTime? selectedDate;
  final VoidCallback onSelectDate;
  final InventoryReportFunctions inventoryLogic;
  final RevenueReportFunctions revenueLogic;
  final TopSellingReportFunctions topSellingLogic;
  final PdfReportService pdfService;
  final VoidCallback onRefresh;
  final Future<void> Function() onExport;
  final Future<void> Function() onShare;

  const WebReportScreen({
    super.key,
    required this.selectedTabIndex,
    required this.onTabChanged,
    required this.selectedDate,
    required this.onSelectDate,
    required this.inventoryLogic,
    required this.revenueLogic,
    required this.topSellingLogic,
    required this.pdfService,
    required this.onRefresh,
    required this.onExport,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.appBarColor,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
      appBar: ReportAppBar(
        onRefresh: onRefresh,
        onExport: onExport,
        onShare: onShare,
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: Column(
          children: [
            ReportTabs(
              selectedIndex: selectedTabIndex,
              onTabChanged: onTabChanged,
            ),
            Expanded(
              child: IndexedStack(
                index: selectedTabIndex,
                children: [
                  InventoryReportView(
                    functions: inventoryLogic,
                    selectedDate: selectedDate,
                    onDateTap: onSelectDate,
                  ),
                  RevenueReportView(
                    functions: revenueLogic,
                    topSellingFunctions: topSellingLogic,
                    selectedDate: selectedDate,
                    onDateTap: onSelectDate,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
