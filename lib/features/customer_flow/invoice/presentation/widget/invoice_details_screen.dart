import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

// ... existing imports

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1. Top Background ──
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImagePath.roleBackground, // Consistent with previous screens
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── 2. Bottom Garden Background ──
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.myQuotesDetailsBottumBG,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          // ── 3. Main UI ──
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // Header (Centered Title)
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
                      text: 'View Details',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w), // Balance for back icon
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              // ── 4. Curved Content Area ──
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
                        stops: const [0.0, 0.4, 0.7, 1.0],
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
                                Center(
                                  child: Column(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(16.r),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF36B840).withValues(alpha: 0.1),
                                            shape: BoxShape.circle, // Circular icon container
                                            border: Border.all(color: const Color(0xFF36B840).withValues(alpha: 0.2)),
                                          ),
                                          child: Image.asset(IconPath.invoice3, height: 24.h, width: 24.h)),
                                      SizedBox(height: 16.h),
                                      CustomText(
                                        text: "Invoice: #1024",
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
                                _DetailRow(label: "Total Price", value: "£ 120.00", isPrice: true),
                                SizedBox(height: 18.h),
                                _DottedDivider(color: AppColor.primary.withValues(alpha: 0.3)),
                                SizedBox(height: 18.h),
                                _DetailRow(label: "Due Date", value: "Jan 15, 2026"),
                                SizedBox(height: 18.h),
                                _DottedDivider(color: AppColor.primary.withValues(alpha: 0.3)),
                                SizedBox(height: 18.h),
                                _StatusRow(label: "Status", value: "Paid"),
                                SizedBox(height: 18.h),
                                _DottedDivider(color: AppColor.primary.withValues(alpha: 0.3)),
                              ],
                            ),
                          ),
                        ),

                        // Pay Now Button
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
                          child: GestureDetector(
                            onTap: () => context.push("/paymentMethods"),
                            child: Container(
                              width: double.infinity,
                              height: 54.h,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Color(0xFF8CC40F), Color(0xFF126A19)],
                                ),
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
                                    text: "Pay Now",
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

// ── Helper Widgets for cleaner code ──

class _DetailRow extends StatelessWidget {
  final String label, value;
  final bool isPrice;
  const _DetailRow({required this.label, required this.value, this.isPrice = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: label, fontSize: 14.sp, color: AppColor.textBody),
        CustomText(
          text: value,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: isPrice ? AppColor.socialLogoColor : AppColor.black,
        ),
      ],
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label, value;
  const _StatusRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(text: label, fontSize: 14.sp, color: AppColor.textBody),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: AppColor.primary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: CustomText(
            text: value,
            fontSize: 12.sp,
            color: AppColor.socialLogoColor,
          ),
        ),
      ],
    );
  }
}

// ... _DottedDivider remains the same

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