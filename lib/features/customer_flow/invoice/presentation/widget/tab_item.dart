import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

class TabItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;

  const TabItem({
    required this.title,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isActive ? AppColor.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: CustomText(
            text: title,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : AppColor.textBody,
          ),
        ),
      ),
    );
  }
}