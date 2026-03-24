import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';

import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/curve_clipper.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String selectedMethod = 'mastercard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // 2. Custom Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            "Payment methods",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balancing spacer
                    ],
                  ),
                ),

                // 3. Curved Body with Fade-Away Effect
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
                      child: SingleChildScrollView(
                        // Significant bottom padding to ensure list items don't hide behind button
                        padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 120.h),
                        child: Column(
                          children: [
                            _buildPaymentCard(
                              icon: Icons.apple,
                              label: "Apple Pay",
                              value: "apple",
                            ),
                            SizedBox(height: 16.h),
                            _buildPaymentCard(
                              imagePath: IconPath.googlePay,
                              label: "Pay",
                              value: "google",
                              imageHeight: 24.h,
                            ),
                            SizedBox(height: 16.h),
                            _buildPaymentCard(
                              icon: Icons.credit_card,
                              label: "Mastercard / Credit",
                              subtitle: "**** 4468",
                              value: "mastercard",
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

          // 4. Fixed Bottom Button (Removed from Column to sit on top of everything)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
              child: GestureDetector(
                onTap: () {
                  // Handle Save & Pay logic
                },
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
                        color: const Color(0xFF126A19).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Save & Pay",
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
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard({
    IconData? icon,
    String? imagePath,
    required String label,
    String? subtitle,
    required String value,
    double? height,
    double? width,
    double? imageHeight,
    double? imageWidth,
  }) {
    bool isSelected = selectedMethod == value;
    return GestureDetector(
      onTap: () => setState(() => selectedMethod = value),
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: EdgeInsets.all(16.r),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.5), // Subtle background for card
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF11A41C) : Colors.white.withValues(alpha: 0.3),
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            if (icon != null) Icon(icon, size: imageHeight?.sp ?? 28.sp, color: AppColor.primary),
            if (imagePath != null)
              Image.asset(
                imagePath,
                width: imageWidth ?? 28.w,
                height: imageHeight ?? 28.h,
                fit: BoxFit.contain,
              ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                    ),
                ],
              ),
            ),
            Container(
              height: 20.r,
              width: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF11A41C) : Colors.grey,
                  width: 2.w,
                ),
              ),
              child: isSelected
                  ? Center(
                child: Container(
                  height: 10.r,
                  width: 10.r,
                  decoration: const BoxDecoration(
                    color: Color(0xFF11A41C),
                    shape: BoxShape.circle,
                  ),
                ),
              )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}