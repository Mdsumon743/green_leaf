


import 'dart:io';

import 'package:flutter_riverpod/legacy.dart';
import 'package:image_picker/image_picker.dart';

import '../model/service_data_model.dart';

class EmployeeHomeState {
  final int selectedTab; // 0=Pending, 1=Completed, 2=Cancel
  final List<CustomerServiceModel> services;

  const EmployeeHomeState({
    this.selectedTab = 0,
    this.services = const [],
  });

  EmployeeHomeState copyWith({
    int? selectedTab,
    List<CustomerServiceModel>? services,
  }) {
    return EmployeeHomeState(
      selectedTab: selectedTab ?? this.selectedTab,
      services: services ?? this.services,
    );
  }

  List<CustomerServiceModel> get filteredServices {
    final map = [ServiceStatus.pending, ServiceStatus.completed, ServiceStatus.cancel];
    return services.where((s) => s.status == map[selectedTab]).toList();
  }
}

// ─── Notifier ─────────────────────────────────────────────────────────────────

class EmployeeHomeNotifier extends StateNotifier<EmployeeHomeState> {
  EmployeeHomeNotifier()
      : super(EmployeeHomeState(
    services: _mockServices(),
  ));

  static List<CustomerServiceModel> _mockServices() => [
    const CustomerServiceModel(
      id: '1',
      title: 'Garden Maintenance',
      quoteNumber: '#1024',
      price: 120.00,
      status: ServiceStatus.pending,
      preferDate: 'Friday, 16th July, 10:00AM',
      address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      jobDescription:
      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
    ),
    const CustomerServiceModel(
      id: '2',
      title: 'Garden Maintenance',
      quoteNumber: '#1024',
      price: 120.00,
      status: ServiceStatus.pending,
      preferDate: 'Friday, 16th July, 10:00AM',
      address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      jobDescription:
      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
    ),
    const CustomerServiceModel(
      id: '3',
      title: 'Garden Maintenance',
      quoteNumber: '#1024',
      price: 120.00,
      status: ServiceStatus.completed,
      preferDate: 'Friday, 16th July, 10:00AM',
      address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      jobDescription:
      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
    ),
    const CustomerServiceModel(
      id: '4',
      title: 'Garden Maintenance',
      quoteNumber: '#1024',
      price: 120.00,
      status: ServiceStatus.cancel,
      preferDate: 'Friday, 16th July, 10:00AM',
      address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      jobDescription:
      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
    ),
  ];

  void setTab(int index) => state = state.copyWith(selectedTab: index);

  Future<void> addBeforePhoto(String serviceId) async {
    final file = await _pick();
    if (file == null) return;
    _updatePhotos(serviceId, before: file);
  }

  Future<void> addAfterPhoto(String serviceId) async {
    final file = await _pick();
    if (file == null) return;
    _updatePhotos(serviceId, after: file);
  }

  Future<File?> _pick() async {
    final picked = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 85);
    return picked != null ? File(picked.path) : null;
  }

  void _updatePhotos(String serviceId, {File? before, File? after}) {
    state = state.copyWith(
      services: state.services.map((s) {
        if (s.id != serviceId) return s;
        return s.copyWith(
          beforePhotos:
          before != null ? [...s.beforePhotos, before] : s.beforePhotos,
          afterPhotos:
          after != null ? [...s.afterPhotos, after] : s.afterPhotos,
        );
      }).toList(),
    );
  }

  void markCompleted(String serviceId) {
    state = state.copyWith(
      services: state.services.map((s) {
        if (s.id != serviceId) return s;
        return s.copyWith(status: ServiceStatus.completed);
      }).toList(),
    );
  }
}

// ─── Providers ────────────────────────────────────────────────────────────────

final employeeHomeProvider =
StateNotifierProvider<EmployeeHomeNotifier, EmployeeHomeState>(
      (ref) => EmployeeHomeNotifier(),
);