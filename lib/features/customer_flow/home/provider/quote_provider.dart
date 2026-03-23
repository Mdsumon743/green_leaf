
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:saunders/core/constants/image_path.dart';

import '../model/quote_data_model.dart';


class QuotesNotifier extends StateNotifier<List<Quote>> {
  QuotesNotifier() : super(_initialQuotes);

  static final List<Quote> _initialQuotes = [
    Quote(
      image: ImagePath.gardening,
      id: '1',
      name: 'Garden Maintenance',
      quoteNumber: '1024',
      amount: 120.00,
      status: QuoteStatus.pending,
    ),
    Quote(
      image: ImagePath.gardening,
      id: '2',
      name: 'Garden Maintenance',
      quoteNumber: '1024',
      amount: 120.00,
      status: QuoteStatus.approved,
    ),
    Quote(
      image: ImagePath.gardening,
      id: '3',
      name: 'Pool Cleaning',
      quoteNumber: '1025',
      amount: 85.00,
      status: QuoteStatus.pending,
    ),
    Quote(
      image: ImagePath.gardening,
      id: '4',
      name: 'Lawn Mowing',
      quoteNumber: '1026',
      amount: 45.00,
      status: QuoteStatus.approved,
    ),
  ];

  void updateQuoteStatus(String id, QuoteStatus newStatus) {
    state = [
      for (final quote in state)
        if (quote.id == id)
          quote.copyWith(status: newStatus)
        else
          quote,
    ];
  }

  void addQuote(Quote quote) {
    state = [...state, quote];
  }

  void removeQuote(String id) {
    state = state.where((quote) => quote.id != id).toList();
  }
}

// Provider for the quotes list
final quotesProvider = StateNotifierProvider<QuotesNotifier, List<Quote>>((ref) {
  return QuotesNotifier();
});

// Provider for filtering quotes by status
final pendingQuotesProvider = Provider<List<Quote>>((ref) {
  final quotes = ref.watch(quotesProvider);
  return quotes.where((quote) => quote.status == QuoteStatus.pending).toList();
});

final approvedQuotesProvider = Provider<List<Quote>>((ref) {
  final quotes = ref.watch(quotesProvider);
  return quotes.where((quote) => quote.status == QuoteStatus.approved).toList();
});