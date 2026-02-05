

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';

import '../../../../core/constants/app_text.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_form_field.dart';
import '../../../../core/utils/app_color.dart';
import '../../provider/reset_password_provider.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              /// Back
              GestureDetector(
                onTap: () => context.pop(),
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

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title
                    CustomText(
                      text: AppText.resetPassword,
                      color: AppColor.authColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      font: AppFont.inter,
                    ),

                    SizedBox(height: 8.h),

                    CustomText(
                      text: AppText.resetPasswordDescription,
                      fontSize: 15.sp,
                      color: AppColor.authDescriptionColor,
                    ),

                    SizedBox(height: 32.h),



                    /// Password
                    CustomText(
                      text: "New Password",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      controller: notifier.passwordController,
                      hintText: "••••••",
                      obscureText: !state.isPasswordVisible,
                      suffixIcon: GestureDetector(
                        onTap: notifier.togglePasswordVisibility,
                        child: Icon(
                          state.isPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 20.h),

                    /// Confirm Password
                    CustomText(
                      text: "Confirm Password",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: AppColor.black,
                    ),

                    SizedBox(height: 10.h),

                    CustomTextFormField(
                      controller: notifier.confirmPasswordController,
                      hintText: "••••••",
                      obscureText: !state.isConfirmPasswordVisible,
                      suffixIcon: GestureDetector(
                        onTap: notifier.toggleConfirmPasswordVisibility,
                        child: Icon(
                          state.isConfirmPasswordVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 20.sp,
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    /// Button
                    CustomButton(
                      text: "Reset Password",
                      onPressed:(){
                        showCustomDialog(context, imagePath: IconPath.success, title: 'Password Changed', buttonText: "Done",
                        message: "Password changed succesfully, you can login again with new password", 
                        onPressed: (){
                          context.go("/login");
                        });
                      }
                      /*state.isLoading ? null : notifier.resetPassword,*/
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
}
