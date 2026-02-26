

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../../../../core/global/custom_text.dart';

class DetailRowColumn extends StatelessWidget {
  final String label;
  final String value;

  const DetailRowColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            fontSize: 13.sp,
            color: AppColor.grey,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: value,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black,
          ),
        ],
      ),
    );
  }
}