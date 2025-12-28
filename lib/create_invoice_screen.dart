import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'invoice_item_model.dart';
import 'invoice_counter.dart';
import 'pdf_invoice.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});
  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final billTo = TextEditingController();
  final date = TextEditingController();
  final List<InvoiceItem> items = [];

  void addItem() {
    setState(() {
      items.add(InvoiceItem(description: '', qty: 1, unitPrice: 0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AMS Invoice")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          TextField(controller: billTo, decoration: const InputDecoration(labelText: "Bill To")),
          TextField(controller: date, decoration: const InputDecoration(labelText: "Invoice Date")),

          ElevatedButton(onPressed: addItem, child: const Text("Add Item")),

          ...items.map((i) => Card(
            child: Column(children: [
              TextField(onChanged: (v) => i.description = v, decoration: const InputDecoration(labelText: "Description")),
              TextField(onChanged: (v) => i.qty = double.tryParse(v) ?? 1, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Qty")),
              TextField(onChanged: (v) => i.unitPrice = double.tryParse(v) ?? 0, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Unit Price")),
            ]),
          )),

          ElevatedButton(
            child: const Text("Generate Invoice PDF"),
            onPressed: () async {
              final no = await getNextInvoiceNumber();
              final pdf = await generateInvoicePdf(
                invoiceNo: no,
                billTo: billTo.text,
                invoiceDate: date.text,
                items: items,
              );
              await Printing.sharePdf(bytes: await pdf.save(), filename: '$no.pdf');
            },
          )
        ],
      ),
    );
  }
}
