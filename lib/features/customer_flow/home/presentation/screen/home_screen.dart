import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          // ── Full green background ──────────────────────────────────────
          Container(color: AppColor.primary),

          // ── Grass / nature background at bottom of green section ───────
          Positioned(
            top: 120.h,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 200.h,
              child: Image.asset(
                ImagePath.homeBackground,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),

          // ── Main content ───────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ───────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar + greeting
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 23.r,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.asset(
                                ImagePath.user,
                                width: 46.w,
                                height: 46.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Hi, Shane!',
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              CustomText(
                                text: 'Welcome Back',
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Notification icon
                      GestureDetector(
                        onTap: () => context.push('/notification'),
                        child: Container(
                          width: 40.r,
                          height: 40.r,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.7),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              IconPath.notification,
                              width: 20.w,
                              height: 20.h,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── White sheet (scrollable content) ──────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.containerBackground,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Top row: All Services + My Quote ──────────
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () =>
                                        context.push('/allServices'),
                                    child: _homeCard(
                                      icon: IconPath.myQuote,
                                      title: 'All Services',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/myQuote'),
                                    child: _homeCard(
                                      icon: IconPath.myQuote,
                                      title: 'My Quote',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 14.h),

                            // ── Bottom row: Upcoming Visits + Invoices ─────
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/visit'),
                                    child: _homeCard(
                                      icon: IconPath.upcomingVisit,
                                      title: 'Upcoming\nVisits',
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/invoice'),
                                    child: _homeCard(
                                      icon: IconPath.homeInvoice,
                                      title: 'Invoices',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // ── Next Visit card ────────────────────────────
                            Container(
                              padding: EdgeInsets.all(20.r),
                              decoration: _cardDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Next Visit',
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.textBody,
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'Lawn Mowin',
                                        color: AppColor.primary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                      ),
                                      CustomText(
                                        text: '2026-01-28 at 10:00 AM',
                                        fontSize: 12.sp,
                                        color: AppColor.textBody
                                            .withValues(alpha: 0.7),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 48.h,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.r),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          CustomText(
                                            text: 'View Details',
                                            color: Colors.white,
                                            fontSize: 16.sp,
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
                                ],
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // ── Request a Quote button ─────────────────────
                            SizedBox(
                              width: double.infinity,
                              height: 48.h,
                              child: ElevatedButton(
                                onPressed: () =>
                                    context.push('/requestInquiry'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(10.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'Request a Quote',
                                      color: Colors.white,
                                      fontSize: 16.sp,
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
                          ],
                        ),
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

  /// Card with a circular green icon background + label below
  Widget _homeCard({required String icon, required String title}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 22.h),
      decoration: _cardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Circular green background for icon
          Container(
            width: 56.r,
            height: 56.r,
            decoration: const BoxDecoration(
              color: AppColor.primary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 28.w,
                height: 28.h,
                /*colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),*/
              ),
            ),
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: title,
            color: AppColor.textBody,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(
        color: AppColor.containerBorder,
        width: 1.w,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}