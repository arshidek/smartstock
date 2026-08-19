import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../features/report/function/report_functions.dart';
import '../../features/report/widgets/summary_card_grid.dart';
import '../services/sale_service.dart';

class PdfReportService {
  final SaleService _saleService = SaleService();

  Future<Uint8List> generateReportPdf(ReportFunctions functions) async {
    final pdf = pw.Document();

    final summaryMetrics = functions.getRevenueSummaryMetrics();
    final topProducts = _getTopSellingProductsRawData();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            _buildHeader(),
            pw.SizedBox(height: 20),
            _buildSummaryMetrics(summaryMetrics),
            pw.SizedBox(height: 30),
            _buildTopProductsTable(topProducts),
          ];
        },
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
            fontSize: 24,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue900,
          ),
        ),
        pw.SizedBox(height: 8),
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
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: PdfColors.grey100,
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
        border: pw.Border.all(color: PdfColors.grey300),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Revenue Summary',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Wrap(
            spacing: 20,
            runSpacing: 10,
            children: metrics.map((m) {
              return pw.Container(
                width: 150,
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      m.title.replaceAll('₹', 'INR '),
                      style: const pw.TextStyle(
                        fontSize: 10,
                        color: PdfColors.grey700,
                      ),
                    ),
                    pw.Text(
                      m.value.replaceAll('₹', 'INR '),
                      style: pw.TextStyle(
                        fontSize: 14,
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
    final tableData = topProducts.map((p) {
      return [
        p['name'],
        p['category'],
        p['quantity'].toString(),
        p['revenue'].toStringAsFixed(0),
      ];
    }).toList();

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Top Selling Products',
          style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 10),
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
    Map<String, Map<String, dynamic>> productSales = {};

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

    List<Map<String, dynamic>> sortedProducts = productSales.values.toList();
    sortedProducts.sort(
      (a, b) => (b['revenue'] as double).compareTo(a['revenue'] as double),
    );
    return sortedProducts.take(5).toList();
  }

  Future<void> sharePdf(Uint8List bytes, String filename) async {
    await Printing.sharePdf(bytes: bytes, filename: filename);
  }

  Future<void> downloadPdf(Uint8List bytes, String filename) async {
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => bytes);
  }
}
