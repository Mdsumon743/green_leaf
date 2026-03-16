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
        children: [
          // ── Full-screen background image ─────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ── Main column ──────────────────────────────────────────────
          Column(
            children: [
              // ── Header ───────────────────────────────────────────────
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
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 70.w),
                    Text(
                      'Visit Details',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // ── White gradient sheet ──────────────────────────────────
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
                          Color(0xFFEDFFE8),
                          Colors.white.withValues(alpha: 0.95),
                          Colors.white.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Quote Icon & Number ───────────────────────
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10.r),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF36B840)
                                        .withValues(alpha: 0.20),
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(color: Color(0xFF36B840).withValues(alpha: 0.30),width: 0.5.w)
                                  ),
                                  child: Image.asset(IconPath.appointment02,height: 20.h,width: 20.w,)
                                ),
                                SizedBox(height: 12.h),
                                CustomText(
                                  text: "Quote: #1024",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.textBody,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: "Garden Maintenance",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color:
                                  AppColor.textBody.withValues(alpha: 0.6),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // ── Job Description ───────────────────────────
                          CustomText(
                            text: "Job Description",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textBody.withValues(alpha: 0.6),
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text:
                            "Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColor.textBody,
                            height: 1.5,
                          ),

                          SizedBox(height: 24.h),

                          // ── Address ───────────────────────────────────
                          CustomText(
                            text: "Address",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textBody.withValues(alpha: 0.6),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              CustomText(
                                text:
                                "1901 Thornridge Cir. Shiloh, Hawaii 81063",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColor.textBody,
                              ),
                              SizedBox(width: 20.w),
                              GestureDetector(
                                onTap: () => context.push('/mapView'),
                                child: Icon(
                                  Icons.map_outlined,
                                  color: AppColor.primary,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          // ── Assigned Staff ────────────────────────────
                          CustomText(
                            text: "Assigned Staff",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.textBody.withValues(alpha: 0.6),
                          ),
                          SizedBox(height: 8.h),
                          CustomText(
                            text: "Shamim Islam",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.primary,
                          ),

                          SizedBox(height: 24.h),

                          // ── Status Tracker ────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Status Tracker",
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color:
                                AppColor.textBody.withValues(alpha: 0.6),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.primary
                                      .withValues(alpha: 0.15),
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

                          SizedBox(height: 40.h),

                          // ── Job Complete Button ───────────────────────
                          SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: GestureDetector(
                              onTap: () {
                                showCustomDialog(
                                  context,
                                  imagePath: IconPath.success2,
                                  title: "Job Successfully Completed",
                                  buttonText: "Done",
                                  buttonGradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFF8CC40F),
                                      Color(0xFF126A19),
                                    ]
                                  ),
                                  message: "The service is complete. Thank you for choosing us!",
                                  onPressed: () => context.pop(),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors:[
                                        Color(0xFF8CC40F),
                                        Color(0xFF126A19),
                                      ]
                                  ),
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: Color(0xFF9DC167)
                                  )
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: "Job Complete",
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    SizedBox(width: 8.w),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 20.sp,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ),
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
}