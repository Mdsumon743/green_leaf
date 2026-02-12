import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';


class Header extends StatelessWidget {
  final BuildContext context;

  const Header(this.context);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          CustomText(
            text: "Invoice & Payments",
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}