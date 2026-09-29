import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../app/app_navigation.dart';
import '../../../../core/services/pdf_report_service.dart';
import '../../../../core/utils/app_snack_bar.dart';
import '../../../../core/widgets/filters/app_date_picker_bottom_sheet.dart';
import '../../function/inventory_report_functions.dart';
import '../../function/revenue_report_functions.dart';
import '../../function/top_selling_report_functions.dart';
import 'mobile/mobile_report_screen.dart';
import 'web/web_report_screen.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedTabIndex = 0;
  DateTime? _selectedDate;
  final InventoryReportFunctions _inventoryLogic = InventoryReportFunctions();
  final RevenueReportFunctions _revenueLogic = RevenueReportFunctions();
  final TopSellingReportFunctions _topSellingLogic =
      TopSellingReportFunctions();
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
    return kIsWeb
        ? WebReportScreen(
            selectedTabIndex: _selectedTabIndex,
            onTabChanged: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            selectedDate: _selectedDate,
            onSelectDate: _selectDate,
            inventoryLogic: _inventoryLogic,
            revenueLogic: _revenueLogic,
            topSellingLogic: _topSellingLogic,
            pdfService: _pdfService,
            onRefresh: () {
              AppNavigation.goToReplacementScreen(
                context,
                const ReportScreen(),
              );
            },
            onExport: _handleExport,
            onShare: _handleShare,
          )
        : MobileReportScreen(
            selectedTabIndex: _selectedTabIndex,
            onTabChanged: (index) {
              setState(() {
                _selectedTabIndex = index;
              });
            },
            selectedDate: _selectedDate,
            onSelectDate: _selectDate,
            inventoryLogic: _inventoryLogic,
            revenueLogic: _revenueLogic,
            topSellingLogic: _topSellingLogic,
            pdfService: _pdfService,
            onRefresh: () {
              AppNavigation.goToReplacementScreen(
                context,
                const ReportScreen(),
              );
            },
            onExport: _handleExport,
            onShare: _handleShare,
          );
  }

  Future<void> _handleExport() async {
    try {
      AppSnackBar.info(context, 'Generating PDF report...');
      final pdfBytes = await _pdfService.generateReportPdf(_revenueLogic);
      final savedPath = await _pdfService.downloadPdf(
        pdfBytes,
        'smartstock_report_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      if (context.mounted) {
        AppSnackBar.success(context, 'PDF saved to Downloads! ($savedPath)');
      }
    } catch (e) {
      if (context.mounted) {
        AppSnackBar.error(context, 'Export failed: $e');
      }
    }
  }

  Future<void> _handleShare() async {
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
  }
}
