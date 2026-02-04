
import 'package:flutter/foundation.dart';

enum QuoteStatus {
  pending,
  approved,
  completed,
  cancelled,
}

class Quote {
  final String id;
  final String name;
  final String quoteNumber;
  final double amount;
  final QuoteStatus status;

  Quote({
    required this.id,
    required this.name,
    required this.quoteNumber,
    required this.amount,
    required this.status,
  });

  String get formattedPrice => '€ ${amount.toStringAsFixed(2)}';

  String get category => 'Quote: #$quoteNumber';

  String get statusText {
    switch (status) {
      case QuoteStatus.pending:
        return 'Pending';
      case QuoteStatus.approved:
        return 'Approved';
      case QuoteStatus.completed:
        return 'Completed';
      case QuoteStatus.cancelled:
        return 'Cancelled';
    }
  }

  Quote copyWith({
    String? id,
    String? name,
    String? quoteNumber,
    double? amount,
    QuoteStatus? status,
  }) {
    return Quote(
      id: id ?? this.id,
      name: name ?? this.name,
      quoteNumber: quoteNumber ?? this.quoteNumber,
      amount: amount ?? this.amount,
      status: status ?? this.status,
    );
  }
}