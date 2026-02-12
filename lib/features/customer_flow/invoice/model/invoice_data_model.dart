

import 'package:flutter_riverpod/flutter_riverpod.dart';

class InvoiceModel {
  final String amount;
  final String status; // Paid | Overdue
  final String date;

  InvoiceModel({
    required this.amount,
    required this.status,
    required this.date,
  });
}

final invoiceListProvider = Provider<List<InvoiceModel>>((ref) {
  return [
    InvoiceModel(amount: "€120.00", status: "Overdue", date: "July 1, 2026"),
    InvoiceModel(amount: "€30.00", status: "Paid", date: "July 1, 2026"),
  ];
});

