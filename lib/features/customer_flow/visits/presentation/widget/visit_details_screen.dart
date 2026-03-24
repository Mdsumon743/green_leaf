import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';

class VisitDetailsScreen extends StatelessWidget {
  const VisitDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 1. TOP BACKGROUND IMAGE
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImagePath.roleBackground, // Standardized
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 2. BOTTOM BACKGROUND IMAGE (Garden)
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.myQuotesDetailsBottumBG,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          /// 3. MAIN UI
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              /// AppBar (Centered Title)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 34.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                      ),
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Visit Details',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 34.w), // Balance for centering
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              /// 4. Curved Content Area
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
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
                        stops: const [0.0, 0.65, 0.8, 1.0],
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// ── Icon & Title ──
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(12.r),
                                          decoration: BoxDecoration(
                                              color: const Color(0xFF36B840).withValues(alpha: 0.1),
                                              shape: BoxShape.circle, // Circular for detail screens
                                              border: Border.all(
                                                  color: const Color(0xFF36B840).withValues(alpha: 0.2),
                                                  width: 1.w)),
                                          child: Image.asset(IconPath.appointment02, height: 24.h, width: 24.w)),
                                      SizedBox(height: 16.h),
                                      CustomText(
                                        text: "Quote: #1024",
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.textBody,
                                      ),
                                      CustomText(
                                        text: "Garden Maintenance",
                                        fontSize: 14.sp,
                                        color: AppColor.textBody.withValues(alpha: 0.6),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 40.h),

                                /// ── Details Rows ──
                                _SectionTitle(text: "Job Description"),
                                SizedBox(height: 8.h),
                                CustomText(
                                  text: "Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.",
                                  fontSize: 14.sp,
                                  color: AppColor.textBody,
                                  height: 1.5,
                                ),

                                SizedBox(height: 24.h),

                                _SectionTitle(text: "Address"),
                                SizedBox(height: 8.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                                        fontSize: 14.sp,
                                        color: AppColor.textBody,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () => context.push('/mapView'),
                                      child: Icon(Icons.map_outlined, color: AppColor.primary, size: 24.sp),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 24.h),

                                _SectionTitle(text: "Assigned Staff"),
                                SizedBox(height: 8.h),
                                CustomText(
                                  text: "Shamim Islam",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primary,
                                ),

                                SizedBox(height: 24.h),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _SectionTitle(text: "Status Tracker"),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                      decoration: BoxDecoration(
                                        color: AppColor.primary.withValues(alpha: 0.15),
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                      child: CustomText(
                                        text: "Pending",
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// ── Job Complete Button ──
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
                          child: GestureDetector(
                            onTap: () {
                              showCustomDialog(
                                context,
                                imagePath: IconPath.success2,
                                title: "Job Successfully Completed",
                                buttonText: "Done",
                                buttonGradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xFF8CC40F), Color(0xFF126A19)]),
                                message: "The service is complete. Thank you for choosing us!",
                                onPressed: () => context.pop(),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              height: 54.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0xFF8CC40F), Color(0xFF126A19)]),
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF126A19).withValues(alpha: 0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: "Job Complete",
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  SizedBox(width: 10.w),
                                  Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14.sp),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
}

/// Helper for Section Headers
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      color: AppColor.textBody.withValues(alpha: 0.6),
    );
  }
}