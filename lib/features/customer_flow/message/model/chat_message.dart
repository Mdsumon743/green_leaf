

class ChatMessage {
  final String text;
  final String time;
  final bool isSent;
  final bool isRead;
  final bool showDateDivider;

  const ChatMessage({
    required this.text,
    required this.time,
    required this.isSent,
    this.isRead = false,
    this.showDateDivider = false,
  });
}