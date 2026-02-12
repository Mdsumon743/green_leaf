import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

class ReferralCard extends StatelessWidget {
  final String name;
  final String date;
  final String amount;
  final String status;

  const ReferralCard({
    super.key,
    required this.name,
    required this.date,
    required this.amount,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2D5F3C),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // Name and Date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: name,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textBody,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: date,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9CA3AF),
                ),
              ],
            ),
          ),

          // Amount and Status
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: amount,
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF10B981),
              ),
              SizedBox(height: 4.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Color(0xFFD1FAE5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: CustomText(
                  text: status,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}