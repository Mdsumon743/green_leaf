import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_color.dart';


class InputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const InputBar({super.key, required this.controller, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        16.w, 10.h, 16.w,
        MediaQuery.of(context).padding.bottom + 10.h,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,//Color(0xFFEDFFE8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Text input
          Expanded(
            child: Container(
              height: 46.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23.r),
                border: Border.all(width: 1,color: Color(0xFF126A19))
              ),
              child: TextField(
                controller: controller,
                style: TextStyle(fontSize: 13.sp, color: AppColor.textDark),
                onSubmitted: (_) => onSend(),
                decoration: InputDecoration(
                  hintText: 'Type a message ...',
                  hintStyle:
                  TextStyle(fontSize: 13.sp, color: AppColor.textLight),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 18.w,
                    vertical: 13.h,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),

          // Send button
          GestureDetector(
            onTap: onSend,
            child: Container(
              width: 46.w,
              height: 46.h,
              decoration:  BoxDecoration(
                color: AppColor.sendBtn,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}