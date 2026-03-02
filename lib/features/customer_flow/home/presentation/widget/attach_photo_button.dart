import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_color.dart';


class AttachPhotosButton extends StatelessWidget {
  final int count;
  const AttachPhotosButton({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColor.attachBg,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.inputBorder, width: 1.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.camera_alt_outlined, color: AppColor.primary, size: 18.sp),
          SizedBox(width: 8.w),
          Text(
            count > 0
                ? 'Attach Photos ($count/5)'
                : 'Attach Photos (Optional)',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.primary,
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.arrow_forward_ios_rounded,
              color: AppColor.primary, size: 12.sp),
        ],
      ),
    );
  }
}