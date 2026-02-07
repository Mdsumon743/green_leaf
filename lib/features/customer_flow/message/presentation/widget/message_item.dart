import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/message_data_model.dart';

class MessageItem extends StatelessWidget {
  final Message message;

  const MessageItem({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push("/chat");
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          children: [
            // Avatar
            CircleAvatar(
              radius: 24.r,
              backgroundImage: AssetImage(message.avatar),
            ),
            SizedBox(width: 12.w),

            // Name & Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: message.name,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: AppColor.textBody,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: message.message,
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),

            // Time & Unread count
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomText(
                  text: message.time,
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
                if (message.unreadCount != null) ...[
                  SizedBox(height: 4.h),
                  Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: CustomText(
                      text: message.unreadCount.toString(),
                      fontSize: 10.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}