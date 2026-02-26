

/*
import 'package:flutter/material.dart';
import 'package:saunders/core/utils/app_color.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
    );
  }
}
*/

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/features/authentication/provider/sign_up_provider.dart';

import '../../../../core/constants/app_text.dart';

import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_form_field.dart';
import '../../../../core/utils/app_color.dart';

class EmployeeSignUpScreen extends ConsumerWidget {
  const EmployeeSignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpNotifier = ref.read(signUpProvider.notifier);
    final signUpState = ref.watch(signUpProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              // Back Button
              GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColor.textBody,
                    size: 24.sp,
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              // Main Content
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    CustomText(
                      text: AppText.signUp,
                      color: AppColor.authColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      font: AppFont.inter,
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    CustomText(
                      text: "Create account and enjoy all services",
                      fontSize: 15.sp,
                      color: AppColor.authDescriptionColor,
                      fontWeight: FontWeight.w400,
                    ),

                    SizedBox(height: 32.h),

                    /// Full Name
                    CustomText(
                      text: "Full Name",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    // Email Input
                    CustomTextFormField(
                      controller: signUpNotifier.fullNameController,
                      hintText: "Full Name",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 20.h),

                    /// Email Label
                    CustomText(
                      text: "Email Address",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    // Email Input
                    CustomTextFormField(
                      controller: signUpNotifier.emailController,
                      hintText: "Email Address",
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 20.h),
                    SizedBox(height: 20.h),

                    /// Email Label
                    CustomText(
                      text: "Phone Number",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    // Email Input
                    CustomTextFormField(
                      controller: signUpNotifier.phoneNumberController,
                      hintText: "Phone Number",
                      keyboardType: TextInputType.phone,
                    ),

                    SizedBox(height: 20.h),

                    // Password Label
                    CustomText(
                      text: "Password",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    // Password Input with visibility toggle
                    CustomTextFormField(
                      controller: signUpNotifier.passwordController,
                      hintText: "••••••",
                      obscureText: !signUpState.isPasswordVisible,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signUpNotifier.togglePasswordVisibility();
                        },
                        child: Icon(
                          signUpState.isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColor.textBody.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                      ),
                    ),


                    SizedBox(height: 20.h),

                    // Password Label
                    CustomText(
                      text: "ConfirmPassword",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    // Password Input with visibility toggle
                    CustomTextFormField(
                      controller: signUpNotifier.confirmPasswordController,
                      hintText: "••••••",
                      obscureText: !signUpState.isConfirmPasswordVisible,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          signUpNotifier.toggleConfirmPasswordVisibility();
                        },
                        child: Icon(
                          signUpState.isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColor.textBody.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                      ),
                    ),


                    SizedBox(height: 16.h),

                    // Forgot Password


                    SizedBox(height: 32.h),

                    // Divider with "Or login with"


                    SizedBox(height: 32.h),

                    // Social Login Buttons


                    SizedBox(height: 80.h),

                    // Login Button
                    CustomButton(
                      text: "Create Account",
                      onPressed: signUpState.isLoading
                          ? null
                          : () {
                        context.push("/employeeVerification");
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Sign Up Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Already have an account? ",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textBody,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push("/login");
                            },

                            child: CustomText(
                              text: "Sign in",
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        width: 56.w,
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xFFDFE1E7),
          ),
          borderRadius: BorderRadius.circular(100.r),
          color: const Color(0xFFE8F5E9).withValues(alpha: 0.3),
        ),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
