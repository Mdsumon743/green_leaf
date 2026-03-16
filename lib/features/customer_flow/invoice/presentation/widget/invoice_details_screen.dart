import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

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
                      'View Details',
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
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 40.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ── Invoice Icon & Number ─────────────────────
                          Center(
                            child: Column(
                              children: [
                                SizedBox(height: 24 .h,),
                                Container(
                                  padding: EdgeInsets.all(16.r),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF36B840).withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: Border.all(color: Color(0xFF36B840).withValues(alpha: 0.3)),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: Image.asset(
                                    IconPath.invoice3,
                                    height: 20.h,
                                    width: 20.h,
                                  )
                                ),
                                SizedBox(height: 12.h),
                                CustomText(
                                  text: "Invoice: #1024",
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColor.textBody,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: "Garden Maintenance",
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.textBody
                                      .withValues(alpha: 0.6),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 32.h),

                          // ── Total Price ───────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Total Price",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AppColor.textBody,
                              ),
                              CustomText(
                                text: "€ 120.00",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.socialLogoColor,
                              ),
                            ],
                          ),

                          SizedBox(height: 18.h),
                          _DottedDivider(color: AppColor.primary),
                          SizedBox(height: 18.h),

                          // ── Due Date ──────────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Due Date",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AppColor.textBody,
                              ),
                              CustomText(
                                text: "Jan 15, 2026",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.black,
                              ),
                            ],
                          ),

                          SizedBox(height: 18.h),
                          _DottedDivider(color: AppColor.primary),
                          SizedBox(height: 18.h),

                          // ── Status ────────────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "Status",
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                color: AppColor.textBody,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color:
                                  AppColor.primary.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: CustomText(
                                  text: "paid",
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.socialLogoColor,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 18.h),
                          _DottedDivider(color: AppColor.primary),
                          SizedBox(height: 40.h),

                          // ── Pay Now Button ────────────────────────────
                          SizedBox(
                            width: double.infinity,
                            height: 52.h,
                            child: ElevatedButton(
                              onPressed: () =>
                                  context.push("/paymentMethods"),
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
                                    text: "Pay Now",
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

// ── Dotted Divider ─────────────────────────────────────────────────────────────

class _DottedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const _DottedDivider({
    this.height = 1,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 4.w;
        final dashSpace = 4.w;
        final dashCount =
        (constraints.maxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (index) {
            return Container(
              width: dashWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}