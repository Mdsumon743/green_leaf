import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';

import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/curve_clipper.dart';

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
          // 1. Your Background Image (Already provided by you)
          Image.asset(
            ImagePath.quoteBackground,
            fit: BoxFit.cover,
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
                // 3. Curved Body with Fade-Away Effect
                Expanded(
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        // CHANGE: Use a Gradient here instead of a solid color
                        // This makes the white "sheet" physically disappear at the bottom
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xFFF3FFF0), // Your light green/white color
                            const Color(0xFFF3FFF0),
                            Colors.transparent,      // Fully clear at the bottom
                          ],
                          stops: const [0.0, 0.70, 1.0], // Card starts disappearing at 70%
                        ),
                      ),
                      child: ShaderMask(
                        blendMode: BlendMode.dstIn,
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.transparent
                            ],
                            stops: [0.0, 0.75, 1.0], // Content (cards) fades at 75%
                          ).createShader(bounds);
                        },
                        child: SingleChildScrollView(
                          // Increase bottom padding so the last payment method
                          // doesn't get cut off by the fade effect
                          padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 140.h),
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
                ),
              ],
            ),
          ),

          // 4. Floating "Save & Pay" Button at the bottom
          Positioned(
            bottom: 40.h,
            left: 20.w,
            right: 20.w,
            child: _buildGradientButton(),
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
    double? height,        // Card height
    double? width,         // Card width
    double? imageHeight,   // Logo height
    double? imageWidth,    // Logo width
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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF11A41C) : Colors.grey.shade200,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            /// ===== Leading Icon or Image =====
            if (icon != null)
              Icon(icon, size: imageHeight?.sp ?? 28.sp), // Fallback to 28

            if (imagePath != null)
              Image.asset(
                imagePath,
                width: imageWidth ?? 28.w,
                height: imageHeight ?? 28.h,
                fit: BoxFit.contain, // Ensures the logo doesn't distort
              ),

            SizedBox(width: 16.w),

            /// ===== Text Content =====
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

            /// ===== Radio Indicator =====
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
  Widget _buildGradientButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          colors: [Color(0xFF11A41C), Color(0xFF0F4A11)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF11A41C).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Save & Pay",
            style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.w),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
        ],
      ),
    );
  }
}