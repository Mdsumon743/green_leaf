

enum NotificationStatus { pending, confirmed, declined }

class AppNotification {
  final String title;
  final DateTime dateTime;
  final NotificationStatus status;
  final bool isRead;

  AppNotification({
    required this.title,
    required this.dateTime,
    required this.status,
    this.isRead = false,
  });
}
