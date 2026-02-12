import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';

class StatusChip extends StatelessWidget {
  final String status;
  final bool isPaid;

  const StatusChip({
    required this.status,
    required this.isPaid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isPaid
              ? const [Color(0xFF2ECC71), Color(0xFF27AE60)]
              : const [Color(0xFF7CB342), Color(0xFF558B2F)],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        text: status,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }
}