import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart'; // Ensure this is imported
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';

class AddAddress extends StatelessWidget {
  AddAddress({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController postCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Prevents the background from jumping when keyboard appears
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // ── Background Image ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ── Main Content ───────────────────────────────────────────
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // Custom Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(Icons.arrow_back, color: AppColor.white),
                    ),
                    const Spacer(),
                    CustomText(
                      text: "Add New Address",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w), // Balance back icon
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // ── Curved Form Container ──────────────────────────────
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
                          AppColor.containerBackground, // Should be your light green/white tint
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 0.8, 1.0],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.h), // Space for the curve

                          _buildLabel("Title"),
                          CustomTextFormField(
                            controller: titleController,
                            hintText: "Home",
                            borderRadius: 12.r,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.4),
                            blurRadius: 6.r,
                            // Adding the 1px border with a specific color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFE0E0E0), width: 1.w),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFB6BAC3), width: 1.w),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          _buildLabel("Street Address"),
                          CustomTextFormField(
                            controller: streetController,
                            hintText: "Street Address",
                            borderRadius: 12.r,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.4),
                            blurRadius: 6.r,
                            // Adding the 1px border with a specific color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFE0E0E0), width: 1.w),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFB6BAC3), width: 1.w),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          _buildLabel("City"),
                          CustomTextFormField(
                            controller: cityController,
                            hintText: "City",
                            borderRadius: 12.r,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.4),
                            blurRadius: 6.r,
                            // Adding the 1px border with a specific color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFE0E0E0), width: 1.w),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFB6BAC3), width: 1.w),
                            ),
                          ),

                          SizedBox(height: 16.h),

                          _buildLabel("Postcode"),
                          CustomTextFormField(
                            controller: postCodeController,
                            hintText: "Postcode",
                            borderRadius: 12.r,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.4),
                            blurRadius: 6.r,
                            // Adding the 1px border with a specific color
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFE0E0E0), width: 1.w),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: const Color(0xFFB6BAC3), width: 1.w),
                            ),
                          ),

                          SizedBox(height: 120.h), // Padding for buttons
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Bottom Buttons (Cancel & Add) ─────────────────────────
          Positioned(
            bottom: 35.h,
            left: 20.w,
            right: 20.w,
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                    borderRadius: 8.r,
                    borderGradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF9DC167),
                        Color(0xFF348317)
                      ]
                    ),
                    text: "Cancel",
                    borderWidth: 2,
                    textColor: const Color(0xFF126A19),
                    backgroundColor: Colors.white,
                    isOutlined: true,
                    onPressed: () => context.pop(),
                  ),
                ),
                SizedBox(width: 15.w),
                Expanded(
                  child: CustomButton(
                    borderRadius: 8.r,
                    borderGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF348317),
                          Color(0xFF9DC167),
                        ]
                    ),
                    backgroundGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF8CC40F),
                          Color(0xFF126A19),
                        ]
                    ),
                    text: "Add Address",
                    borderWidth: 2,
                    onPressed: () {
                      // Save logic here
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for consistent label styling
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        text: text,
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        color: Colors.black, // Match deep text color in image
      ),
    );
  }
}