

import 'package:flutter_riverpod/legacy.dart';

enum CalendarViewType { daily, weekly }

// ─── Calendar State ───────────────────────────────────────────────────────────

class CalendarState {
  final CalendarViewType viewType;
  final DateTime focusedDate;

  CalendarState({
    this.viewType = CalendarViewType.weekly,
    DateTime? focusedDate,
  }) : focusedDate = focusedDate ??  DateTime.now();

  CalendarState copyWith({
    CalendarViewType? viewType,
    DateTime? focusedDate,
  }) {
    return CalendarState(
      viewType: viewType ?? this.viewType,
      focusedDate: focusedDate ?? this.focusedDate,
    );
  }
}

// Helper workaround for const default
extension on CalendarState {
  static DateTime get _now => DateTime.now();
}

// ─── Calendar Notifier ────────────────────────────────────────────────────────

class CalendarNotifier extends StateNotifier<CalendarState> {
  CalendarNotifier()
      : super(CalendarState(focusedDate: DateTime.now()));

  void setViewType(CalendarViewType type) =>
      state = state.copyWith(viewType: type);

  void setFocusedDate(DateTime date) =>
      state = state.copyWith(focusedDate: date);

  void goToPrev() {
    if (state.viewType == CalendarViewType.daily) {
      state = state.copyWith(
          focusedDate: state.focusedDate.subtract(const Duration(days: 1)));
    } else {
      state = state.copyWith(
          focusedDate: state.focusedDate.subtract(const Duration(days: 7)));
    }
  }

  void goToNext() {
    if (state.viewType == CalendarViewType.daily) {
      state = state.copyWith(
          focusedDate: state.focusedDate.add(const Duration(days: 1)));
    } else {
      state = state.copyWith(
          focusedDate: state.focusedDate.add(const Duration(days: 7)));
    }
  }
}

// ─── Calendar Provider ────────────────────────────────────────────────────────

final calendarProvider =
StateNotifierProvider<CalendarNotifier, CalendarState>(
      (ref) => CalendarNotifier(),
);