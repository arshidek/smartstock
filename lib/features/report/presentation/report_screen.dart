import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../widgets/report_app_bar.dart';
import '../widgets/report_tabs.dart';
import '../../drawer/presentation/app_drawer.dart';
import '../function/report_functions.dart';
import 'inventory_report_view.dart';
import 'revenue_report_view.dart';
import '../../../core/widgets/bottom_nav/app_bottom_navigation_bar.dart';
import '../../../app/app_navigation.dart';
import '../../../core/services/pdf_report_service.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  int _selectedTabIndex = 0;
  DateTime? _selectedDate;
  final ReportFunctions _reportFunctions = ReportFunctions();
  final PdfReportService _pdfService = PdfReportService();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:  ColorScheme.light(
              primary: AppColors.blue, 
              onPrimary: AppColors.white, 
              onSurface: AppColors.black, 
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.blue, 
              ),
            ),
          ),
          child: child!,
        );
      },
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
      appBar: ReportAppBar(
        onRefresh: () {
          AppNavigation.goToReplacementScreen(context, const ReportScreen());
        },
        onExport: () async {
          try {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Generating PDF...')));
            final pdfBytes = await _pdfService.generateReportPdf(
              _reportFunctions,
            );
            await _pdfService.downloadPdf(pdfBytes, 'smartstock_report.pdf');
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $e')));
          }
        },
        onShare: () async {
          try {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Generating PDF...')));
            final pdfBytes = await _pdfService.generateReportPdf(
              _reportFunctions,
            );
            await _pdfService.sharePdf(pdfBytes, 'smartstock_report.pdf');
          } catch (e) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error: $e')));
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
                    functions: _reportFunctions,
                    selectedDate: _selectedDate,
                    onDateTap: _selectDate,
                  ),
                  RevenueReportView(
                    functions: _reportFunctions,
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
