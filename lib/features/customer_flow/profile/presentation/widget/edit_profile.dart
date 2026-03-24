import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../../../../core/global/curve_clipper.dart';
class EditProfile extends StatelessWidget {
  EditProfile({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set resizeToAvoidBottomInset to true to handle keyboard overlay
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // ── Background Image ───────────────────────────────────────
          Positioned.fill(
            child: Opacity(
              opacity: 0.7,
              child: Image.asset(
                ImagePath.roleBackground,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ── Main Content ───────────────────────────────────────────
          Column(
            children: [
              SizedBox(height: 52.h),

              // Custom AppBar Row
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
                      text: "Edit Profile",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w), // Balance for the back arrow
                  ],
                ),
              ),

              SizedBox(height: 54.h),

              // ── Curved Gradient Container ──────────────────────────
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
                          AppColor.containerBackground.withValues(alpha: 0.85),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Extra space to push content below the curve peak
                          SizedBox(height: 60.h),

                          // Full Name Field
                          CustomText(
                            text: "Full Name",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            controller: nameController,
                            hintText: "Full Name",
                            borderRadius: 12.r,
                          ),

                          SizedBox(height: 16.h),

                          // Email Field
                          CustomText(
                            text: "Email",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            controller: emailController,
                            hintText: "abc32@gmail.com",
                            hintTextColor: Colors.white,
                            containerColor: Color(0xFF126A19),
                            textColor: Colors.white,
                            borderRadius: 12.r,
                          ),

                          SizedBox(height: 16.h),

                          // Phone Number Field
                          CustomText(
                            text: "Phone Number",
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            controller: phoneController,
                            hintText: "+880 1517053529",
                            borderRadius: 12.r,
                          ),

                          // Ensure there's space at the bottom for scrolling
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Fixed Bottom Button ────────────────────────────────────
          Positioned(
            bottom: 35.h,
            left: 20.w,
            right: 20.w,
            child: CustomButton(
              text: "Save",
              borderRadius: 12.r,
              backgroundGradient: LinearGradient(
                colors: [
                  Color(0xFF8CC40F),
                  Color(0xFF126A19),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              onPressed: () {
                // Handle logic
              },
            ),
          ),
        ],
      ),
    );
  }
}
