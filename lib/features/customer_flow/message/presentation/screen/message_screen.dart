import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';


import '../../../../../core/utils/app_color.dart';
import '../../model/message_data_model.dart';
import '../widget/message_item.dart';

// -------------------- Providers --------------------

final messagesProvider = StateProvider<List<Message>>((ref) {
  return [
    Message(
      name: "Esther Howard",
      message: "It is a long established fact that...",
      time: "10:30 PM",
      avatar: ImagePath.user,
    ),
    Message(
      name: "Floyd Miles",
      message: "It is a long established fact that...",
      time: "4:30 PM",
      avatar: ImagePath.user,
    ),
    Message(
      name: "Annette Black",
      message: "It is a long established fact that...",
      time: "8:00 AM",
      avatar: ImagePath.user,
      unreadCount: 3,
    ),
    Message(
      name: "David Smith",
      message: "It is a long established fact that...",
      time: "10:30 PM",
      avatar: ImagePath.user,
    ),
    Message(
      name: "Annette Black",
      message: "It is a long established fact that...",
      time: "8:00 AM",
      avatar: ImagePath.user,
      unreadCount: 3,
    ),
  ];
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredMessagesProvider = Provider<List<Message>>((ref) {
  final messages = ref.watch(messagesProvider);
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) return messages;

  return messages
      .where((m) => m.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

// -------------------- Message Screen --------------------

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredMessages = ref.watch(filteredMessagesProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false, // Prevents keyboard from squishing the curve
      body: Stack(
        children: [
          // ── Background image ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground, // Using consistent background
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // ── Header ───────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Center(
                  child: CustomText(
                    text: 'Message',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              // ── Curved Content Area ──────────────────────────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.containerBackground,
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.7, 0.8, 1.0],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60.h), // Offset for the curve peak

                        // ── Search bar ────────────────────────────────
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomTextFormField(
                            controller: TextEditingController(),
                            hintText: "Search here...",
                            borderRadius: 30.r,
                            containerColor: Colors.white,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.08),
                            blurRadius: 10,
                            prefixIcon: const Icon(Icons.search, color: Color(0xFF9098A1)),
                            onChanged: (value) {
                              ref.read(searchQueryProvider.notifier).state = value;
                            },
                          ),
                        ),

                        SizedBox(height: 20.h),

                        // ── Messages list ─────────────────────────────
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                            itemCount: filteredMessages.length,
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final message = filteredMessages[index];
                              return MessageItem(message: message);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}