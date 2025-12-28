import 'package:flutter/material.dart';
import 'create_invoice_screen.dart';

void main() {
  runApp(const AMSInvoiceApp());
}

class AMSInvoiceApp extends StatelessWidget {
  const AMSInvoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateInvoiceScreen(),
    );
  }
}
