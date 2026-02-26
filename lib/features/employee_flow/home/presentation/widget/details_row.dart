import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String? value;
  final Widget? widget;
  final Color? valueColor;
  final bool valueBold;

  const DetailRow({
    required this.label,
    this.value,
    this.widget,
    this.valueColor,
    this.valueBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: label,
            fontSize: 13.sp,
            color: Colors.grey,
          ),
          widget ??
              CustomText(
                text: value ?? '',
                fontSize: 13.sp,
                fontWeight:
                valueBold ? FontWeight.w700 : FontWeight.w500,
                color: valueColor ?? AppColor.black,
              ),
        ],
      ),
    );
  }
}