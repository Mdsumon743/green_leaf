import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_text.dart';
import '../../../../core/global/custom_button.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/global/custom_text_form_field.dart';
import '../../../../core/utils/app_color.dart';
import '../../provider/reset_password_provider.dart';

class ResetPasswordEmailScreen extends ConsumerWidget {
  const ResetPasswordEmailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider.notifier);
    final state = ref.watch(resetPasswordProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),

              /// Back
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.arrow_back,
                  color: AppColor.textBody,
                  size: 24.sp,
                ),
              ),

              SizedBox(height: 32.h),

              /// Title
              CustomText(
                text: AppText.reset,
                color: AppColor.authColor,
                fontWeight: FontWeight.w700,
                fontSize: 28.sp,
                font: AppFont.inter,
              ),

              SizedBox(height: 8.h),

              CustomText(
                text: "Enter your email to get a verification code.",
                fontSize: 15.sp,
                color: AppColor.authDescriptionColor,
              ),

              SizedBox(height: 32.h),

              /// Email Label
              CustomText(
                text: "Email Address",
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
                color: AppColor.black,
              ),

              SizedBox(height: 10.h),

              /// Email Input
              CustomTextFormField(
                controller: notifier.emailController,
                hintText: "Email Address",
                keyboardType: TextInputType.emailAddress,
              ),

              Spacer(),

              /// Button
              CustomButton(
                text: "Send Code",
                onPressed:(){
                  context.push("/forgotPasswordOtp");
                }
                ///state.isLoading ? null : notifier.resetPassword,
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
