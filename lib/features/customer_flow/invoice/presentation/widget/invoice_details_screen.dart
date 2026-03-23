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
        children: [
          // ── 1. Top Background ──
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
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
              // Header (AppBar)
              Container(
                padding: EdgeInsets.only(top: 50.h, left: 20.w, right: 20.w, bottom: 20.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'View Details',
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 24.sp),
                  ],
                ),
              ),

              // ── 4. The Fading White Sheet ──
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      // Apply the fade to the container background itself
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.75, 1.0],
                      ),
                    ),
                    child: Column(
                      children: [
                        // Scrollable Area with ShaderMask
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Color(0xFFEDFFE8), Color(0xFFEDFFE8), Colors.transparent],
                                stops: const [0.0, 0.8, 1.0],
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.dstIn,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Column(
                                      children: [
                                        SizedBox(height: 24.h),
                                        Container(
                                            padding: EdgeInsets.all(16.r),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF36B840).withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(5.r),
                                              border: Border.all(color: const Color(0xFF36B840).withValues(alpha: 0.3)),
                                            ),
                                            child: Image.asset(IconPath.invoice3, height: 20.h, width: 20.h)),
                                        SizedBox(height: 12.h),
                                        CustomText(text: "Invoice: #1024", fontSize: 18.sp, fontWeight: FontWeight.w700, color: AppColor.textBody),
                                        CustomText(text: "Garden Maintenance", fontSize: 14.sp, color: AppColor.textBody.withValues(alpha: 0.6)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 32.h),
                                  _DetailRow(label: "Total Price", value: "€ 120.00", isPrice: true),
                                  SizedBox(height: 18.h),
                                  _DottedDivider(color: AppColor.primary),
                                  SizedBox(height: 18.h),
                                  _DetailRow(label: "Due Date", value: "Jan 15, 2026"),
                                  SizedBox(height: 18.h),
                                  _DottedDivider(color: AppColor.primary),
                                  SizedBox(height: 18.h),
                                  _StatusRow(label: "Status", value: "paid"),
                                  SizedBox(height: 18.h),
                                  _DottedDivider(color: AppColor.primary),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Sticky Button Area (Transparent to allow fade background to show)
                        Container(
                          padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
                          decoration: const BoxDecoration(color: Colors.transparent),
                          child: Container( // Outer container to hold the gradient
                            width: double.infinity,
                            height: 52.h,
                            decoration: BoxDecoration(
                              // --- GRADIENT CONFIGURATION ---
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF8CC40F),
                                  Color(0xFF126A19)
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: () => context.push("/paymentMethods"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent, // Make button transparent to show gradient
                                shadowColor: Colors.transparent,     // Remove default shadow
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
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
                                    size: 14.sp, // Slightly smaller icon usually looks cleaner
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