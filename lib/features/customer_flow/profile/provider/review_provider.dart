

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/review_data_model.dart';

final reviewsListProvider = Provider<List<Review>>((ref) {
  return [
    Review(
      serviceName: 'Lawn Mowing',
      date: '20 Dec 2025',
      rating: 5,
      comment: 'Excellent service! James did a fantastic job on our lawn.',
    ),
    Review(
      serviceName: 'Lawn Mowing',
      date: '20 Dec 2025',
      rating: 5,
      comment: 'Excellent service! James did a fantastic job on our lawn.',
    ),
    Review(
      serviceName: 'Lawn Mowing',
      date: '20 Dec 2025',
      rating: 5,
      comment: 'Excellent service! James did a fantastic job on our lawn.',
    ),
  ];
});