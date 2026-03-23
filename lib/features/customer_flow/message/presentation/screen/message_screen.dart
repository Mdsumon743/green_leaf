import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';


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
      body: Stack(
        children: [
          // ── Full-screen background image ─────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ── Main column ──────────────────────────────────────────────
          Column(
            children: [
              // ── Header ───────────────────────────────────────────────
              Container(
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ),
                child: Center(
                  child: CustomText(
                    text: 'Message',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              // ── White gradient sheet ──────────────────────────────────
              // ── Main White Sheet ──
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    // FIX: Use a solid color here so the "Sheet" is visible
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3FFF0), // Light mint/white background
                    ),
                    child: Column(
                      children: [
                        // ── Search bar ──
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 68.h, 20.w, 0),
                          child: CustomTextFormField(
                            controller: TextEditingController(),
                            hintText: "Search here...",
                            borderRadius: 99,
                            containerColor: const Color(0xFF126A19).withOpacity(0.1),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(99.r),
                              borderSide: const BorderSide(color: Color(0xFF126A19)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(99.r),
                              borderSide: const BorderSide(color: Color(0xFF126A19), width: 1.5),
                            ),
                            prefixIconPadding: EdgeInsets.only(left: 14.w, right: 0.w),
                            prefixIcon: const Icon(Icons.search, color: Colors.grey),
                            onChanged: (value) {
                              ref.read(searchQueryProvider.notifier).state = value;
                            },
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // ── Messages list with Fade Effect ──
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                  Colors.transparent // This fades the LIST, not the background
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.dstIn,
                            child: ListView.separated(
                              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
                              itemCount: filteredMessages.length,
                              separatorBuilder: (_, __) => SizedBox(height: 12.h),
                              itemBuilder: (context, index) {
                                final message = filteredMessages[index];
                                return MessageItem(message: message);
                              },
                            ),
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