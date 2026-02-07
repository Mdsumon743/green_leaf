
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../model/message_data_model.dart';
import '../widget/message_item.dart';

// -------------------- Providers --------------------

// Messages state
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

// Search query
final searchQueryProvider = StateProvider<String>((ref) => '');

// Filtered messages
final filteredMessagesProvider = Provider<List<Message>>((ref) {
  final messages = ref.watch(messagesProvider);
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) return messages;

  return messages
      .where((message) => message.name.toLowerCase().contains(query.toLowerCase()))
      .toList();
});

// -------------------- Message Screen --------------------

class MessageScreen extends ConsumerWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredMessages = ref.watch(filteredMessagesProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // ---------------- Top Background ----------------
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
              child: Opacity(
                opacity: 0.5,
                child: Image.asset(
                  ImagePath.visitBackground,
                  width: double.infinity,
                  height: 220.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Optional overlay image
          Positioned(
            top: 0,
            right: 0,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                ImagePath.quoteBackground,
                width: 140.w,
                height: 180.h,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ---------------- Bottom Background ----------------
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              ImagePath.homeBackground,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),

          // ---------------- Main Content ----------------
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: CustomText(
                    text: "Message",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                ),

                // Search bar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextFormField(
                    borderRadius: 16.r,
                    controller: TextEditingController(),
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    onChanged: (value) {
                      ref.read(searchQueryProvider.notifier).state = value;
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                // Messages list container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.background,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.r),
                        topRight: Radius.circular(24.r),
                      ),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
        ],
      ),
    );
  }
}




