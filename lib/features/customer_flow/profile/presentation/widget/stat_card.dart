import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: const Color(0xFFD4E7D7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min, // Ensure column only takes needed space
        children: [
          Image.asset(
            icon,
            height: 32.h,
            width: 32.w, // Fixed typo: should be .w
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: value,
            fontWeight: FontWeight.bold, // Made bold to match "Value" feel
            textAlign: TextAlign.center,
            fontSize: 22.sp, // Reduced slightly to prevent text overflow
            color: const Color(0xFF126A19), // Darker green for better readability
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: title,
            fontSize: 13.sp,
            color: const Color(0xFF4A4E5A),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}