import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
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
                child: Container(
                  width: double.infinity,
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
                      stops: const [0.0, 0.5, 0.8, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Quote Icon & Number ───────────────────────
                          Center(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    color: AppColor.primary
                                        .withValues(alpha: 0.15),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.description_outlined,
                                    color: AppColor.primary,
                                    size: 32.sp,
                                  ),
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
                            child: ElevatedButton(
                              onPressed: () {
                                showCustomDialog(
                                  context,
                                  imagePath: IconPath.success,
                                  title: "Job Successfully Completed",
                                  buttonText: "Done",
                                  message:
                                  "The service is complete. Thank you for choosing us!",
                                  onPressed: () => context.pop(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                elevation: 0,
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
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Colors.white,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                            ),
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