import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class RequestInquiryState {
  final String? service;
  final DateTime? dateTime;
  final String message;

  RequestInquiryState({
    this.service,
    this.dateTime,
    this.message = '',
  });

  RequestInquiryState copyWith({
    String? service,
    DateTime? dateTime,
    String? message,
  }) {
    return RequestInquiryState(
      service: service ?? this.service,
      dateTime: dateTime ?? this.dateTime,
      message: message ?? this.message,
    );
  }
}

class RequestInquiryNotifier extends StateNotifier<RequestInquiryState> {
  RequestInquiryNotifier() : super(RequestInquiryState());

  /// ✅ Controller lives here
  final TextEditingController descriptionController =
  TextEditingController();

  void selectService(String value) {
    state = state.copyWith(service: value);
  }

  void selectDateTime(DateTime value) {
    state = state.copyWith(dateTime: value);
  }

  void updateMessage(String value) {
    state = state.copyWith(message: value);
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}

final requestInquiryProvider =
StateNotifierProvider<RequestInquiryNotifier, RequestInquiryState>(
      (ref) => RequestInquiryNotifier(),
);
