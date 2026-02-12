import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: Color(0xFFD4E7D7),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32.sp,
            color: Color(0xFF2D5F3C),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: value,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            fontSize: 20.sp,
            color: Color(0xFF2D5F3C),
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: title,
            fontSize: 13.sp,
            color: Color(0xFF2D5F3C),
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w500,
          ),
        ],
      ),
    );
  }
}