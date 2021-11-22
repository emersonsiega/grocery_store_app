import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../domain/domain.dart';
import '../../utils/utils.dart';
import '../data.dart';

class LocalOrderReceiptPdfMaker implements OrderReceiptPdfMaker {
  static final green = PdfColor.fromHex('#72CD98');
  static final grey = PdfColor.fromHex('#c4c4c4');
  static final white = PdfColor.fromHex('#fff');
  static final darkGrey = PdfColor.fromHex('#3f3f3f');
  static final defaultStyle = pw.TextStyle(
    fontSize: 12,
    color: darkGrey,
    fontWeight: pw.FontWeight.normal,
  );

  pw.Widget _makeTitle(String title) {
    return pw.Text(
      title,
      textAlign: pw.TextAlign.left,
      style: pw.TextStyle(
        fontSize: 14,
        color: darkGrey,
        fontWeight: pw.FontWeight.bold,
      ),
    );
  }

  pw.Widget _makeText(String title) {
    return pw.Text(
      title,
      textAlign: pw.TextAlign.left,
      style: defaultStyle,
    );
  }

  pw.Widget _makeHeader(OrderEntity order) {
    return pw.Header(
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Text(
                  "Confirmação de pedido",
                  style: pw.TextStyle(
                    fontSize: 24,
                    color: darkGrey,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                DateFormat.yMMMMd('pt_BR').format(order.date),
                style: pw.TextStyle(
                  fontSize: 14,
                  color: darkGrey,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ],
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5, bottom: 5),
            child: _makeText("#${order.id}"),
          ),
          pw.Divider(thickness: 0.5),
          _makeTitle("Cliente"),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 5, bottom: 5),
            child: pw.Row(
              children: [
                pw.Expanded(
                  child: _makeText(order.user.name),
                ),
                _makeText("CPF: ${order.user.cpf}"),
              ],
            ),
          ),
          pw.Divider(thickness: 0.5),
          _makeTitle("Entrega"),
          pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 10, top: 5),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                _makeText(
                  "${order.address.street}, ${order.address.number} - CEP: ${order.address.zipCode}",
                ),
                pw.SizedBox(height: 4),
                _makeText("${order.address.city} - ${order.address.state}"),
                pw.SizedBox(height: 4),
                _makeText("${order.address.additionalInfo}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _makeContent(OrderEntity order) {
    const tableHeaders = [
      '#',
      'Produto',
      'Preço',
      'Qtd.',
      'Total',
    ];

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      mainAxisSize: pw.MainAxisSize.max,
      children: [
        _makeTitle("Produtos"),
        pw.SizedBox(height: 8),
        pw.Expanded(
          child: pw.Table.fromTextArray(
            border: null,
            cellAlignment: pw.Alignment.centerLeft,
            headerDecoration: pw.BoxDecoration(
              borderRadius: const pw.BorderRadius.all(
                pw.Radius.circular(2),
              ),
              color: green,
            ),
            headerHeight: 25,
            cellHeight: 40,
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.center,
              4: pw.Alignment.centerRight,
            },
            headerStyle: pw.TextStyle(
              color: white,
              fontSize: 14,
              fontWeight: pw.FontWeight.bold,
            ),
            cellStyle: defaultStyle,
            rowDecoration: pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(
                  color: grey,
                  width: .5,
                ),
              ),
            ),
            headers: List<String>.generate(
              tableHeaders.length,
              (col) => tableHeaders[col],
            ),
            data: List<List<String>>.generate(
              order.items.length,
              (row) => List<String>.generate(
                tableHeaders.length,
                (col) {
                  final item = order.items[row];

                  switch (col) {
                    case 0:
                      return "${row + 1}";
                    case 1:
                      return item.product.name;
                    case 2:
                      return item.product.price.currency;
                    case 3:
                      return "${item.quantity}";
                    case 4:
                      return item.total.currency;
                    default:
                      return '';
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _makeFooter(OrderEntity order) {
    return pw.Container(
      height: 75,
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          _makeTitle("Total"),
          pw.SizedBox(height: 8),
          pw.Expanded(
            child: pw.Table.fromTextArray(
              border: null,
              cellAlignment: pw.Alignment.centerLeft,
              headerDecoration: pw.BoxDecoration(
                borderRadius: const pw.BorderRadius.all(
                  pw.Radius.circular(2),
                ),
                color: green,
              ),
              headerHeight: 25,
              cellHeight: 40,
              cellAlignments: {
                0: pw.Alignment.centerLeft,
                1: pw.Alignment.centerLeft,
                2: pw.Alignment.centerRight,
                3: pw.Alignment.centerRight,
                4: pw.Alignment.centerRight,
              },
              headerStyle: pw.TextStyle(
                color: white,
                fontSize: 14,
                fontWeight: pw.FontWeight.bold,
              ),
              data: [
                [
                  "${order.items.length} itens",
                  "",
                  "",
                  "Valor total: ${order.total.currency}",
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<String> makePdf(OrderEntity order) async {
    await initializeDateFormatting('pt_BR', null);
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            mainAxisSize: pw.MainAxisSize.max,
            children: [
              _makeHeader(order),
              pw.Expanded(
                child: _makeContent(order),
              ),
              _makeFooter(order),
            ],
          );
        },
      ),
    ); // Page

    final pdfData = await pdf.save();
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/order-receipt-${order.id}.pdf');
    await file.writeAsBytes(pdfData);
    return file.path;
  }

  @override
  Future<void> printPdf(String path) async {
    File file = File(path);
    final fileContent = await file.readAsBytes();
    await Printing.layoutPdf(
      onLayout: (_) => fileContent,
      name: path.split('/').last,
    );
  }
}
