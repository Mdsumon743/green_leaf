import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';
import 'package:saunders/core/global/curve_clipper.dart';

class HomeScreen extends StatelessWidget  {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Full-screen background image (like ReferalScreen) ──────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ── Main column ────────────────────────────────────────────────
          Column(

            children: [
              // ── Header ─────────────────────────────────────────────────
              Container(
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ),
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
                        width: 48.r,
                        height: 48.r,
                        decoration: BoxDecoration(
                          color: Color(0xFF126A19),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(0xFF188220),
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

              // ── White gradient sheet (like ReferalScreen) ──────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     AppColor.containerBackground,
                      //     AppColor.containerBackground.withValues(alpha: 0.95),
                      //     AppColor.containerBackground.withValues(alpha: 0.85),
                      //     AppColor.containerBackground.withValues(alpha: 0.75),
                      //   ],
                      //   stops: const [0.0, 0.5, 0.8, 1.0],
                      // ),
                      color: Color(0xFFF3FFF0)
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
                            // ── Top row: All Services + My Quote ────────────
                            SizedBox(height: 48.h,),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/allServices'),
                                    child: _homeCard(
                                      icon: IconPath.allService,
                                      title: 'All Services',
                                      subTitle: "View & Book"
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
                                      subTitle: "Estimate Overview"
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 14.h),

                            // ── Bottom row: Upcoming Visits + Invoices ───────
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/visit'),
                                    child: _homeCard(
                                      icon: IconPath.upcomingVisit,
                                      title: 'Upcoming Visits',
                                      subTitle: "3 Upcoming Visits"
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
                                      subTitle: "Pending & Past Due"
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 14.h),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/subscription'),
                                    child: _homeCard(
                                        icon: IconPath.homePackage,
                                        title: 'Packages',
                                        subTitle: "Various Service Bundles"
                                    ),
                                  ),
                                ),
                                SizedBox(width: 14.w),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () => context.push('/gardening'),
                                    child: _homeCard(
                                        icon: IconPath.gardeningTips,
                                        title: 'Gardening Tips',
                                        subTitle: "Various Service Bundles"
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // ── Next Visit card ──────────────────────────────
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
                                    child: GestureDetector(
                                      onTap: () {
                                        // Your navigation or logic here
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 14.h), // Adjust height
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          gradient: const LinearGradient(
                                            colors: [
                                              Color(0xFF8CC40F),
                                              Color(0xFF126A19),
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          border: Border.all(width: 2.w,color: Color(0xFF348317)),
                                          // Adding a subtle shadow to make it pop
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0xFF11A41C).withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                    )
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16.h),

                            // ── Request a Quote button ───────────────────────
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

                            SizedBox(height: 35.h),
                          ],
                        ),
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

  /// Card with a circular green icon background + label below
  Widget _homeCard({required String icon, required String title, required  String subTitle}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 22.h),
      decoration: _cardDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Center(
              child: Image.asset(
                icon,

              ),
            ),
          ),
          SizedBox(height: 12.h),
          CustomText(
            text: title,
            color: AppColor.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          CustomText(
            text: subTitle,
            color: AppColor.primary,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Color(0xFFF8F9EB),
      borderRadius: BorderRadius.circular(16.r),
      border: Border.all(
        color: Color(0xFF055726).withValues(alpha: 0.3),
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