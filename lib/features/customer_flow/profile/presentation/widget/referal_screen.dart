import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart'; // Ensure this is imported
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
          // ── Background image ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground, // Consistent background
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // ── Header (Centered Title) ──────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Refer a friend',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w), // Balance for back icon
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // ── Curved Content Area ──────────────────────────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(), // Using your custom clipper
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.containerBackground,
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 0.8, 1.0],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(height: 60.h), // Offset for the curve peak

                          // Referral Icon
                          Center(
                            child: Image.asset(
                              IconPath.refer,
                              fit: BoxFit.contain,
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
                            color: const Color(0xFF6B7280),
                            maxLines: 2,
                          ),

                          SizedBox(height: 28.h),

                          // Referral Link Container
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: const Color(0xFFE8F5E9),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min, // Wrap content
                              children: [
                                CustomText(
                                  text: "https://referlink.com",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2D5F3C),
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () {
                                    Clipboard.setData(const ClipboardData(text: "https://referlink.com"));
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Link copied to clipboard")),
                                    );
                                  },
                                  child: Icon(Icons.copy, size: 20.sp, color: const Color(0xFF2D5F3C)),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),

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
                              _buildShareOption(
                                image: IconPath.whatsApp,
                                label: "WhatsApp",
                                color: const Color(0xFF25D366),
                                onTap: () {},
                              ),
                              SizedBox(width: 25.w),
                              _buildShareOption(
                                image: IconPath.email,
                                label: "Email",
                                color: const Color(0xFF2D5F3C),
                                onTap: () {},
                              ),
                              SizedBox(width: 25.w),
                              _buildShareOption(
                                image: IconPath.link,
                                label: "Copy link",
                                color: const Color(0xFF2D5F3C),
                                onTap: () {
                                  Clipboard.setData(const ClipboardData(text: "https://referlink.com"));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Link copied to clipboard")),
                                  );
                                },
                              ),
                            ],
                          ),

                          SizedBox(height: 50.h),

                          // Referral History Button
                          CustomButton(
                            backgroundGradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF8CC40F),
                                Color(0xFF126A19),
                              ]
                            ),
                            borderWidth: 2,
                            borderRadius: 8.r,
                            text: "Referral History",
                            onPressed: () => context.push("/referHistory"),
                          ),

                          SizedBox(height: 35.h),
                        ],
                      ),
                    ),
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
    required String image,
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
            width: 80.w, // Adjusted width for better spacing
            decoration: BoxDecoration(
              border: Border.all(width: 1.w, color: const Color(0xFFD8DBDF)),
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(image, fit: BoxFit.contain),
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF6B7280),
            ),
          ),
        ],
      ),
    );
  }
}