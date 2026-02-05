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
      body: Stack(
        children: [
          /// ================= Two Background Images =================
          Column(
            children: [
              /// Top Background Image
              Container(
                height: 300.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.quoteBackground), // Top background
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              /// Bottom Background Image
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.homeBackground), // Bottom background - replace with your bottom image path
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// ================= Green Overlay (optional) =================
          Column(
            children: [
              Container(
                height: 300.h,
                color: AppColor.primary.withValues(alpha: 0.65),
              ),
              Expanded(
                child: Container(
                  color: Colors.white.withValues(alpha: 0.95), // Semi-transparent white for bottom section
                ),
              ),
            ],
          ),

          /// ================= Page Content =================
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// ================= Header Content =================
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 24.r,
                              backgroundColor: Colors.white,
                              child: ClipOval(
                                child: Image.asset(
                                  ImagePath.user,
                                  width: 48.w,
                                  height: 48.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Hi, Shane!",
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: "Welcome Back",
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontSize: 12.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push('/notification');
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: AppColor.primary,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              IconPath.notification,
                              width: 20.w,
                              height: 20.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Space to show background image
                  SizedBox(height: 140.h),

                  /// ================= White Content Container =================
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 24.h),
                      child: Column(
                        children: [
                          /// ================= My Quote =================
                          GestureDetector(
                            onTap: () {
                              context.push('/myQuote');
                            },
                            child: _homeCard(
                              width: 335.w,
                              icon: IconPath.myQuote,
                              title: "My Quote",
                            ),
                          ),

                          SizedBox(height: 16.h),

                          /// ================= Upcoming + Invoices =================
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context.push("/visit");
                                  },
                                  child: _homeCard(
                                    width: 160.w,
                                    icon: IconPath.upcomingVisit,
                                    title: "Upcoming Visits",
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    context.push('/invoice');
                                  },
                                  child: _homeCard(
                                    width: 160.w,
                                    icon: IconPath.homeInvoice,
                                    title: "Invoices",
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 24.h),

                          /// ================= Next Visit =================
                          Container(
                            padding: EdgeInsets.all(20.r),
                            decoration: _cardDecoration(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Next Visit",
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
                                      text: "Lawn Mowin",
                                      color: AppColor.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                    ),
                                    CustomText(
                                      text: "2026-01-28 at 10:00 AM",
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
                                          text: "View Details",
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

                          SizedBox(height: 36.h),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/requestInquiry');
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
                              text: "Request a Quote",
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
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ================= Reusable Home Card =================
  Widget _homeCard({
    required String icon,
    required String title,
    required double width,
  }) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 22.h),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          SvgPicture.asset(
            icon,
            width: 48.w,
            height: 48.h,
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: title,
            color: AppColor.textBody,
            fontSize: 16.sp,
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