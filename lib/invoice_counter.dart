import 'package:shared_preferences/shared_preferences.dart';

Future<String> getNextInvoiceNumber() async {
  final prefs = await SharedPreferences.getInstance();
  int last = prefs.getInt('invoice_no') ?? 22;
  last++;
  await prefs.setInt('invoice_no', last);
  return "AMS${last.toString().padLeft(4, '0')}";
}
