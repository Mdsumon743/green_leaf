

class Message {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final int? unreadCount;

  Message({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unreadCount,
  });
}