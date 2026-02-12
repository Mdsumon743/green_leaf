

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

class AddressCard extends StatelessWidget {
  final String title;
  final String address;
  final bool isDefault;

  const AddressCard({
    super.key,
    required this.title,
    required this.address,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.spMin),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Location Icon
          Container(
            height: 48.h,
            width: 48.w,
            decoration: BoxDecoration(
              color: Color(0xFF4CAF50).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Icon(
                Icons.location_on,
                color: Color(0xFF4CAF50),
                size: 28.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Address Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBody,
                    ),
                    SizedBox(width: 8.w),
                    if (isDefault)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          text: "Default",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                CustomText(
                  text: address,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textBody.withValues(alpha: 0.6),
                  maxLines: 2,
                ),
              ],
            ),
          ),

          // Edit and Delete Icons
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  // Edit action
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Color(0xFF4CAF50),
                  size: 20.sp,
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () {
                  // Delete action
                },
                child: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}