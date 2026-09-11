import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../widgets/report_app_bar.dart';
import '../widgets/report_tabs.dart';
import '../function/inventory_report_logic.dart';
import '../function/revenue_report_logic.dart';
import '../function/top_selling_report_logic.dart';
import 'inventory_report_view.dart';
import 'revenue_report_view.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/pdf_report_service.dart';
import '../../../core/widgets/filters/app_date_picker_bottom_sheet.dart';
import '../../../core/utils/app_snack_bar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedTabIndex = 0;
  DateTime? _selectedDate;
  final InventoryReportLogic _inventoryLogic = InventoryReportLogic();
  final RevenueReportLogic _revenueLogic = RevenueReportLogic();
  final TopSellingReportLogic _topSellingLogic = TopSellingReportLogic();
  final PdfReportService _pdfService = PdfReportService();

  Future<void> _selectDate() async {
    final DateTime? picked = await showAppDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.appBarColor,
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
      appBar: ReportAppBar(
        onRefresh: () {
          AppNavigation.goToReplacementScreen(context, const ReportScreen());
        },
        onExport: () async {
          try {
            AppSnackBar.info(context, 'Generating PDF report...');
            final pdfBytes = await _pdfService.generateReportPdf(_revenueLogic);
            final savedPath = await _pdfService.downloadPdf(
              pdfBytes,
              'smartstock_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
            );
            if (context.mounted) {
              AppSnackBar.success(
                context,
                'PDF saved to Downloads! ($savedPath)',
              );
            }
          } catch (e) {
            if (context.mounted) {
              AppSnackBar.error(context, 'Export failed: $e');
            }
          }
        },
        onShare: () async {
          try {
            AppSnackBar.info(context, 'Preparing PDF to share...');
            final pdfBytes = await _pdfService.generateReportPdf(_revenueLogic);
            await _pdfService.sharePdf(
              pdfBytes,
              'smartstock_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
            );
            if (context.mounted) {
              AppSnackBar.success(context, 'PDF shared successfully!');
            }
          } catch (e) {
            if (context.mounted) {
              AppSnackBar.error(context, 'Share failed: $e');
            }
          }
        },
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.background),
        child: Column(
          children: [
            ReportTabs(
              selectedIndex: _selectedTabIndex,
              onTabChanged: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),

            Expanded(
              child: IndexedStack(
                index: _selectedTabIndex,
                children: [
                  InventoryReportView(
                    functions: _inventoryLogic,
                    selectedDate: _selectedDate,
                    onDateTap: _selectDate,
                  ),
                  RevenueReportView(
                    functions: _revenueLogic,
                    topSellingFunctions: _topSellingLogic,
                    selectedDate: _selectedDate,
                    onDateTap: _selectDate,
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
