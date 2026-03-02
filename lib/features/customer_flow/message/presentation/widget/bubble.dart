import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/image_path.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/chat_message.dart';


class Bubble extends StatelessWidget {
  final ChatMessage message;
  const Bubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isSent = message.isSent;

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
        isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar for received messages
          if (!isSent) ...[
            CircleAvatar(
              radius: 16.r,
              backgroundImage: AssetImage(ImagePath.user),
              backgroundColor: const Color(0xFFCFE3C9),
            ),
            SizedBox(width: 8.w),
          ],

          // Bubble
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.68,
            ),
            padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 10.h),
            decoration: BoxDecoration(
              color: isSent ? AppColor.sentBubble : AppColor.receivedBubble,
              borderRadius: BorderRadius.only(
                topLeft:     Radius.circular(18.r),
                topRight:    Radius.circular(18.r),
                bottomLeft:  Radius.circular(isSent ? 18.r : 4.r),
                bottomRight: Radius.circular(isSent ? 4.r  : 18.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    fontSize: 13.5.sp,
                    height: 1.45,
                    color: isSent ? Colors.white : AppColor.textDark,
                  ),
                ),
                SizedBox(height: 5.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message.time,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: isSent
                            ? Colors.white.withValues(alpha: 0.65)
                            : AppColor.textLight,
                      ),
                    ),
                    if (message.isRead) ...[
                      SizedBox(width: 4.w),
                      Text(
                        '· Read',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: isSent
                              ? Colors.white.withValues(alpha: 0.65)
                              : AppColor.textLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          if (isSent) SizedBox(width: 2.w),
        ],
      ),
    );
  }
}