import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'invoice_item_model.dart';

Future<pw.Document> generateInvoicePdf({
  required String invoiceNo,
  required String billTo,
  required String invoiceDate,
  required List<InvoiceItem> items,
}) async {
  final logo = pw.MemoryImage(
    (await rootBundle.load('assets/logo.png')).buffer.asUint8List(),
  );
  final stamp = pw.MemoryImage(
    (await rootBundle.load('assets/stamp.png')).buffer.asUint8List(),
  );
  final sign = pw.MemoryImage(
    (await rootBundle.load('assets/signature.png')).buffer.asUint8List(),
  );

  final subtotal = items.fold(0.0, (s, e) => s + e.amount);
  final vat = subtotal * 0.05;
  final total = subtotal + vat;

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (_) => pw.Column(children: [
        pw.Image(logo, width: 120),
        pw.Text("TAX INVOICE / فاتورة ضريبية"),
        pw.Text("Invoice No: $invoiceNo"),
        pw.Text("Date: $invoiceDate"),
        pw.Text("Bill To: $billTo"),

        pw.Table.fromTextArray(
          headers: ['Description', 'Qty', 'Unit Price', 'Amount'],
          data: items.map((e) => [
            e.description,
            e.qty.toString(),
            e.unitPrice.toStringAsFixed(2),
            e.amount.toStringAsFixed(2),
          ]).toList(),
        ),

        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Column(children: [
            pw.Text("Subtotal: AED ${subtotal.toStringAsFixed(2)}"),
            pw.Text("VAT (5%): AED ${vat.toStringAsFixed(2)}"),
            pw.Text("Total: AED ${total.toStringAsFixed(2)}"),
          ]),
        ),

        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Image(sign, width: 90),
            pw.Image(stamp, width: 90),
          ],
        ),
      ]),
    ),
  );

  return pdf;
}
