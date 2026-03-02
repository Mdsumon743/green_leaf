
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';
import '../model/chat_message.dart';

/// ───────────────── CHAT STATE ─────────────────

class ChatNotifier extends StateNotifier<List<ChatMessage>> {
  ChatNotifier()
      : super([
    const ChatMessage(
      text:
      "Hi, your appointment is confirmed. Please share your address and health issue.",
      time: "16.50",
      isSent: true,
      isRead: true,
    ),
    const ChatMessage(
      text:
      "Address shared. I've had fever and body pain for 3 days.",
      time: "09.45",
      isSent: false,
      isRead: false,
    ),
    const ChatMessage(
      text:
      "Got it. I'll arrive on time. Keep any previous reports ready.",
      time: "09.13",
      isSent: true,
      isRead: true,
      showDateDivider: true,
    ),
  ]);

  void sendMessage(String text, BuildContext context) {
    if (text.trim().isEmpty) return;

    state = [
      ...state,
      ChatMessage(
        text: text.trim(),
        time: TimeOfDay.now().format(context),
        isSent: true,
        isRead: false,
      ),
    ];
  }
}

final chatProvider =
StateNotifierProvider<ChatNotifier, List<ChatMessage>>(
        (ref) => ChatNotifier());