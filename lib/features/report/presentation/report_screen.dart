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

            // Date Filter
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.padding20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                          // In a real scenario, we would filter ReportFunctions data here
                        });
                      }
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blue.withValues(alpha: 0.08),
                        border: Border.all(
                          color: AppColors.blue.withValues(alpha: 0.3),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: AppColors.blue,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "${(_selectedDate ?? DateTime.now()).day}/${(_selectedDate ?? DateTime.now()).month}/${(_selectedDate ?? DateTime.now()).year}",
                            style: const TextStyle(
                              color: AppColors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSizes.padding10),

            Expanded(
              child: IndexedStack(
                index: _selectedTabIndex,
                children: [
                  InventoryReportView(functions: _reportFunctions),
                  RevenueReportView(functions: _reportFunctions),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 2),
    );
  }
}
