import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';
class RequestQuoteState {
  final String? service;
  final String description;
  final String fullName;
  final String email;
  final String phone;
  final DateTime? preferredDate;
  final List<String> attachedPhotos; // file paths

  const RequestQuoteState({
    this.service,
    this.description = '',
    this.fullName = '',
    this.email = '',
    this.phone = '',
    this.preferredDate,
    this.attachedPhotos = const [],
  });

  int get charCount => description.length;

  RequestQuoteState copyWith({
    String? service,
    String? description,
    String? fullName,
    String? email,
    String? phone,
    DateTime? preferredDate,
    List<String>? attachedPhotos,
    bool clearDate = false,
  }) {
    return RequestQuoteState(
      service: service ?? this.service,
      description: description ?? this.description,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      preferredDate: clearDate ? null : (preferredDate ?? this.preferredDate),
      attachedPhotos: attachedPhotos ?? this.attachedPhotos,
    );
  }
}

class RequestQuoteNotifier extends StateNotifier<RequestQuoteState> {
  RequestQuoteNotifier() : super(const RequestQuoteState());

  final descController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  void selectService(String s) => state = state.copyWith(service: s);
  void updateDescription(String v) => state = state.copyWith(description: v);
  void updateName(String v) => state = state.copyWith(fullName: v);
  void updateEmail(String v) => state = state.copyWith(email: v);
  void updatePhone(String v) => state = state.copyWith(phone: v);
  void selectDate(DateTime d) => state = state.copyWith(preferredDate: d);

  // ── New methods for photos ───────────────────────────────────────────────
  void addPhotos(List<String> newPaths) {
    final updated = [...state.attachedPhotos, ...newPaths];
    state = state.copyWith(attachedPhotos: updated);
  }

  void removePhotoAt(int index) {
    if (index < 0 || index >= state.attachedPhotos.length) return;
    final updated = List<String>.from(state.attachedPhotos)..removeAt(index);
    state = state.copyWith(attachedPhotos: updated);
  }

  @override
  void dispose() {
    descController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}

final requestQuoteProvider =
StateNotifierProvider.autoDispose<RequestQuoteNotifier, RequestQuoteState>(
      (ref) => RequestQuoteNotifier(),
);