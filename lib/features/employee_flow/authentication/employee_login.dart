

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/app_text.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';
import 'package:saunders/features/authentication/provider/sign_up_provider.dart';



class EmployeeLoginScreen extends ConsumerWidget {
  const EmployeeLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.read(signUpProvider.notifier);
    final loginState = ref.watch(signUpProvider);

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
                      text: AppText.login,
                      color: AppColor.authColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      font: AppFont.inter,
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    CustomText(
                      text: "Log In to your account",
                      fontSize: 15.sp,
                      color: AppColor.authDescriptionColor,
                      fontWeight: FontWeight.w400,
                    ),

                    SizedBox(height: 32.h),

                    // Email Label
                    CustomText(
                      text: "Email Address",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    // Email Input
                    CustomTextFormField(
                      controller: loginNotifier.emailController,
                      hintText: "Email Address",
                      keyboardType: TextInputType.emailAddress,
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
                      controller: loginNotifier.passwordController,
                      hintText: "••••••",
                      obscureText: !loginState.isPasswordVisible,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          loginNotifier.togglePasswordVisibility();
                        },
                        child: Icon(
                          loginState.isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColor.textBody.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          context.push('/resetPassword');
                          // Navigate to forgot password
                        },
                        child: CustomText(
                          text: "Forgot Password?",
                          color: AppColor.error,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Divider with "Or login with"
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColor.headerColor.withValues(alpha: 0.3),
                            height: 1.h,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: CustomText(
                            text: "Or login with",
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            color: AppColor.textBody.withValues(alpha: 0.6),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: AppColor.headerColor.withValues(alpha: 0.3),
                            height: 1.h,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32.h),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Google Button
                        _buildSocialButton(
                          iconPath: IconPath.google,
                          onTap: () {
                            // Google login
                          },
                        ),
                        SizedBox(width: 20.w),
                        // Apple Button
                        _buildSocialButton(
                          iconPath: IconPath.apple,
                          onTap: () {
                            // Apple login
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 80.h),

                    // Login Button
                    CustomButton(
                      text: "Log In",
                      onPressed: loginState.isLoading
                          ? null
                          : () {
                        context.push('/customerNav');
                        /*loginNotifier.login();*/
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Sign Up Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Don't have an account? ",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textBody,
                          ),
                          GestureDetector(
                            onTap: () {
                              context.push("/employeeSignUp");
                            },

                            child: CustomText(
                              text: "Sign Up",
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