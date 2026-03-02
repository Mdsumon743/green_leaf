

import 'package:flutter_riverpod/legacy.dart';

import '../model/service_model.dart';

class ServicesFilterState {
  final String searchQuery;
  final ServiceCategory selectedTab;
  final double maxDistanceKm;
  final ServiceCategory? filterCategory;

  const ServicesFilterState({
    this.searchQuery = '',
    this.selectedTab = ServiceCategory.popular,
    this.maxDistanceKm = 50,
    this.filterCategory,
  });

  ServicesFilterState copyWith({
    String? searchQuery,
    ServiceCategory? selectedTab,
    double? maxDistanceKm,
    ServiceCategory? filterCategory,
    bool clearFilterCategory = false,
  }) {
    return ServicesFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      selectedTab: selectedTab ?? this.selectedTab,
      maxDistanceKm: maxDistanceKm ?? this.maxDistanceKm,
      filterCategory:
      clearFilterCategory ? null : (filterCategory ?? this.filterCategory),
    );
  }
}

class ServicesNotifier extends StateNotifier<ServicesFilterState> {
  ServicesNotifier() : super(const ServicesFilterState());

  void setSearch(String q) => state = state.copyWith(searchQuery: q);
  void setTab(ServiceCategory tab) => state = state.copyWith(selectedTab: tab);

  void applyFilter({
    required double maxDistanceKm,
    ServiceCategory? category,
  }) {
    state = state.copyWith(
      maxDistanceKm: maxDistanceKm,
      filterCategory: category,
      clearFilterCategory: category == null,
    );
  }

  void resetFilters() {
    state = state.copyWith(maxDistanceKm: 50, clearFilterCategory: true);
  }
}

// ── Providers ─────────────────────────────────────────────────────────────────

final servicesFilterProvider =
StateNotifierProvider<ServicesNotifier, ServicesFilterState>(
        (ref) => ServicesNotifier());