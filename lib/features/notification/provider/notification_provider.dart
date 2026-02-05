

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../model/app_notification.dart';

final notificationProvider =
StateNotifierProvider<NotificationNotifier, List<AppNotification>>(
      (ref) => NotificationNotifier(),
);

class NotificationNotifier extends StateNotifier<List<AppNotification>> {
  NotificationNotifier()
      : super([
    AppNotification(
      title: "Garden Maintenance",
      dateTime: DateTime(2025, 12, 11, 21, 30),
      status: NotificationStatus.pending,
    ),
    AppNotification(
      title: "Hedge Trimming",
      dateTime: DateTime(2025, 12, 11, 21, 30),
      status: NotificationStatus.confirmed,
      isRead: true,
    ),
    AppNotification(
      title: "Hedge Trimming",
      dateTime: DateTime(2025, 12, 11, 21, 30),
      status: NotificationStatus.declined,
      isRead: true,
    ),
  ]);

  void markAsRead(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          AppNotification(
            title: state[i].title,
            dateTime: state[i].dateTime,
            status: state[i].status,
            isRead: true,
          )
        else
          state[i]
    ];
  }
}
