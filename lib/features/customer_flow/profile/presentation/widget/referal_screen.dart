import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

class ReferalScreen extends StatelessWidget {
  const ReferalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 70.w),
                    Text(
                      'Refer a friend',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content area with gradient
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withValues(alpha: 0.95),
                        Colors.white.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 0.8, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Referral Icon
                       Center(
                          child: Image.asset(
                            IconPath.refer,
                            fit: BoxFit.cover,
                            height: 90.h,
                            width: 90.w,
                          ),
                        ),


                      SizedBox(height: 32.h),

                      // Title
                      CustomText(
                        text: "Refer a friend And Get £10",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textBody,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(height: 12.h),

                      // Subtitle
                      CustomText(
                        text: "Share Your Unique Code & Expand Your\nNetwork!",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        textAlign: TextAlign.center,
                        color: Color(0xFF6B7280),
                        maxLines: 2,
                      ),

                      SizedBox(height: 28.h),

                      // Referral Link Container
                      Container(
                        width: 208.w,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Color(0xFFE8F5E9),
                        ),
                        child: Row(

                          children: [
                            CustomText(
                              text: "https://referlink.com",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D5F3C),
                            ),
                            SizedBox(width: 16.w,),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                  ClipboardData(text: "https://referlink.com"),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Link copied to clipboard"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: Icon(
                                Icons.copy,
                                size: 20.sp,
                                color: Color(0xFF2D5F3C),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // Share Via Text
                      CustomText(
                        text: "Share Via",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.textBody,
                      ),

                      SizedBox(height: 20.h),

                      // Share Options
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // WhatsApp
                          _buildShareOption(
                            image: IconPath.whatsApp,
                            label: "WhatsApp",
                            color: Color(0xFF25D366),
                            onTap: () {
                              // Add WhatsApp share logic
                            },
                          ),

                          SizedBox(width: 32.w),

                          // Email
                          _buildShareOption(
                            image: IconPath.email,
                            label: "Email",
                            color: Color(0xFF2D5F3C),
                            onTap: () {
                              // Add Email share logic
                            },
                          ),

                          SizedBox(width: 32.w),

                          // Copy Link
                          _buildShareOption(
                            image: IconPath.link,
                            label: "Copy link",
                            color: Color(0xFF2D5F3C),
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: "https://referlink.com"),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Link copied to clipboard"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ],
                      ),

                      Spacer(),

                      // Referral History Button
                      CustomButton(
                        text: "Referral History",
                        onPressed: () {
                          context.push("/referHistory");
                        },
                      ),

                      SizedBox(height: 35.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShareOption({
    required String  image,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.sp),
            height: 56.h,
            width: 90.w,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.w,
                color: Color(0xFFD8DBDF),
              ),
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Image.asset(
                image,

              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}