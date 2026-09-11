import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:smartstock_inventory/core/constants/app_sizes.dart';
import '../../features/report/function/revenue_report_logic.dart';
import '../../features/report/widgets/summary_card_grid.dart';
import '../services/sale_service.dart';

class PdfReportService {
  final SaleService _saleService = SaleService();

  // ─── PDF Generation ───────────────────────────────────────────────────────

  Future<Uint8List> generateReportPdf(RevenueReportLogic functions) async {
    final pdf = pw.Document();
    final summaryMetrics = functions.getRevenueSummaryMetrics();
    final topProducts = _getTopSellingProductsRawData();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) => [
          _buildHeader(),
          pw.SizedBox(height: AppSizes.size20),
          _buildSummaryMetrics(summaryMetrics),
          pw.SizedBox(height: AppSizes.size30),
          _buildTopProductsTable(topProducts),
        ],
      ),
    );

    return await pdf.save();
  }

  pw.Widget _buildHeader() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'SmartStock Inventory Report',
          style: pw.TextStyle(
            fontSize: AppSizes.font24,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue900,
          ),
        ),
        pw.SizedBox(height: AppSizes.size8),
        pw.Text(
          'Generated on: ${DateTime.now().toLocal().toString().split('.')[0]}',
          style: const pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
        ),
        pw.Divider(color: PdfColors.blueGrey300),
      ],
    );
  }

  pw.Widget _buildSummaryMetrics(List<SummaryMetric> metrics) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(AppSizes.padding10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: const pw.BorderRadius.all(
          pw.Radius.circular(AppSizes.borderRadius8),
        ),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Revenue Summary',
            style: pw.TextStyle(
              fontSize: AppSizes.font16,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: AppSizes.size10),
          pw.Wrap(
            spacing: AppSizes.size20,
            runSpacing: AppSizes.size10,
            children: metrics.map((m) {
              return pw.SizedBox(
                width: 150,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      m.title.replaceAll('₹', 'INR '),
                      style: const pw.TextStyle(
                        fontSize: AppSizes.font10,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      m.value.replaceAll('₹', 'INR '),
                      style: pw.TextStyle(
                        fontSize: AppSizes.font14,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.black,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildTopProductsTable(List<Map<String, dynamic>> topProducts) {
    if (topProducts.isEmpty) {
      return pw.Text(
        'No sales data available.',
        style: const pw.TextStyle(color: PdfColors.grey600),
      );
    }

    final tableHeaders = ['Product', 'Category', 'Orders', 'Revenue (INR)'];
    final tableData = topProducts
        .map(
          (p) => [
            p['name'],
            p['category'],
            p['quantity'].toString(),
            (p['revenue'] as double).toStringAsFixed(0),
          ],
        )
        .toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Top Selling Products',
          style: pw.TextStyle(
            fontSize: AppSizes.font16,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: AppSizes.size10),
        pw.TableHelper.fromTextArray(
          headers: tableHeaders,
          data: tableData,
          headerStyle: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.white,
          ),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.blue800),
          rowDecoration: const pw.BoxDecoration(
            border: pw.Border(
              bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.5),
            ),
          ),
          cellAlignment: pw.Alignment.centerLeft,
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getTopSellingProductsRawData() {
    final sales = _saleService.getAllSales();
    final Map<String, Map<String, dynamic>> productSales = {};

    for (var sale in sales) {
      for (var item in sale.items) {
        if (productSales.containsKey(item.productId)) {
          productSales[item.productId]!['quantity'] += item.quantity;
          productSales[item.productId]!['revenue'] += item.totalPrice;
        } else {
          productSales[item.productId] = {
            'name': item.productName,
            'category': item.categoryName,
            'quantity': item.quantity,
            'revenue': item.totalPrice,
          };
        }
      }
    }

    final sorted = productSales.values.toList()
      ..sort((a, b) =>
          (b['revenue'] as double).compareTo(a['revenue'] as double));
    return sorted.take(5).toList();
  }

  // ─── Export (Download) ────────────────────────────────────────────────────

  /// Saves PDF to the device Downloads folder and opens the system viewer.
  Future<String> downloadPdf(Uint8List bytes, String filename) async {
    if (kIsWeb) {
      await Printing.layoutPdf(onLayout: (_) async => bytes);
      return 'Opened print dialog';
    }

    // Resolve save directory
    Directory saveDir;
    if (Platform.isAndroid) {
      final downloads = Directory('/storage/emulated/0/Download');
      saveDir = await downloads.exists()
          ? downloads
          : (await getExternalStorageDirectory())!;
    } else {
      saveDir = await getApplicationDocumentsDirectory();
    }

    // Write file
    final filePath = '${saveDir.path}/$filename';
    await File(filePath).writeAsBytes(bytes);

    // Open via system print / viewer dialog
    await Printing.layoutPdf(onLayout: (_) async => bytes);

    return filePath;
  }

  // ─── Share ─────────────────────────────────────────────────────────────────

  /// Triggers the native share sheet with the PDF attached.
  Future<void> sharePdf(Uint8List bytes, String filename) async {
    await Printing.sharePdf(bytes: bytes, filename: filename);
  }
}
