import 'package:flutter/material.dart';
import 'package:saunders/core/global/custom_text.dart';
class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(text: "Message Screen"),
    );
  }
}
