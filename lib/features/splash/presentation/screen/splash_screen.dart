import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:saunders/core/constants/app_text.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../../../core/global/custom_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 🌿 Background Image
          Image.asset(
            ImagePath.splashBackground,
            fit: BoxFit.cover,
          ),

          /// 🌑 Dark overlay (for readability)
          Container(
            color: Colors.black.withOpacity(0.35),
          ),

          /// 🌱 Center Content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Logo
              Image.asset(
                IconPath.appLogo,
                width: 273.w,
                height: 160.w,
                fit: BoxFit.cover,
              ),

              SizedBox(height: 16.h),

              /// SAUNDERS
              CustomText(
                text: AppText.appName,
                font: AppFont.impact,
                fontSize: 56.sp,
                letterSpacing: 2,
                color: AppColor.white,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 6.h),

              /// GRADENING SERVICE
              CustomText(
                text: AppText.appCategory,
                font: AppFont.inter,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: AppColor.white,
                textAlign: TextAlign.center,
              ),
            ],
          ),

          /// ⏳ Loader at bottom
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: SpinKitCircle(
              size: 50.sp,
              color: AppColor.white,
            ),
          ),
        ],
      ),
    );
  }
}
