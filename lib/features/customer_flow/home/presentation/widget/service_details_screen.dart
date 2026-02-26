

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';


import '../../../../employee_flow/home/model/service_data_model.dart';
import '../screen/all_service_screen.dart';

class ServiceDetailsScreen extends StatelessWidget {
  final ServiceModel service;

  const ServiceDetailsScreen({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Full-screen background image (bushes/nature) ───────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.homeBackground, // reuse your existing bg image
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // ── Dark overlay so content is readable ───────────────────────
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xCC1B5E20), // dark green top
                    Color(0x881B5E20), // semi transparent mid
                    Color(0x331B5E20), // light bottom
                  ],
                  stops: [0.0, 0.35, 1.0],
                ),
              ),
            ),
          ),

          // ── Safe area content ──────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── App Bar ─────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 38.r,
                          height: 38.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.7),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      CustomText(
                        text: 'Service Details',
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),

                // ── White sheet ──────────────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F7F3),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(
                                  20.w, 24.h, 20.w, 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ── Service image card ─────────────────
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(16.r),
                                      border: Border.all(
                                        color: AppColor.containerBorder,
                                        width: 1.w,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.06),
                                          blurRadius: 12,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        // Image
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16.r),
                                          ),
                                          child: Image.asset(
                                            // Use service image if available,
                                            // else fall back to placeholder
                                            ImagePath.quoteBackground,
                                            width: double.infinity,
                                            height: 180.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        // Service name below image
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 12.h,
                                            horizontal: 16.w,
                                          ),
                                          child: CustomText(
                                            text: service.name,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColor.textBody,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: 24.h),

                                  // ── Total Price row ────────────────────
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'Total Price',
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColor.textBody,
                                      ),
                                      CustomText(
                                        text: service.price.toString(),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w700,
                                        color: AppColor.textBody,
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 20.h),

                                  // ── Divider ────────────────────────────
                                  Divider(
                                    color: AppColor.containerBorder,
                                    thickness: 1.h,
                                  ),

                                  SizedBox(height: 16.h),

                                  // ── Service Description ────────────────
                                  CustomText(
                                    text: 'Service Description',
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.textBody,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    text: service.description,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.textBody
                                        .withValues(alpha: 0.65),
                                    height: 1.6,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ── Bottom Quote button ──────────────────────
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                20.w, 12.h, 20.w, 32.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F7F3),
                              border: Border(
                                top: BorderSide(
                                  color: AppColor.containerBorder,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: ElevatedButton(
                                onPressed: () =>
                                    context.push('/requestInquiry'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'Quote',
                                      color: Colors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}