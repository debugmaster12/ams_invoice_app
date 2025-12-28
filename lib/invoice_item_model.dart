class InvoiceItem {
  String description;
  double qty;
  double unitPrice;

  InvoiceItem({
    required this.description,
    required this.qty,
    required this.unitPrice,
  });

  double get amount => qty * unitPrice;
}
