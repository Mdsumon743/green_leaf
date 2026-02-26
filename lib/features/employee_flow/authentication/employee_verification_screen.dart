

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:saunders/core/constants/icon_path.dart';

import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../authentication/provider/otp_verify_provider.dart';



class EmployeeVerificationCodeScreen extends ConsumerWidget {
  const EmployeeVerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpNotifier = ref.read(verifyOtpProvider.notifier);
    final otpState = ref.watch(verifyOtpProvider);

    // Pinput default theme
    final defaultPinTheme = PinTheme(
      width: 65.w,
      height: 65.h,
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: AppColor.primary,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.primary,
          width: 2,
        ),
      ),
    );

    // Focused pin theme
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.primary,
          width: 2,
        ),
      ),
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColor.primary,
      ),
    );

    // Empty pin theme
    final emptyPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFE0E0E0),
          width: 2,
        ),
      ),
      textStyle: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w700,
        color: AppColor.textBody,
      ),
    );

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
                      text: "Verification code",
                      color: AppColor.authColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 28.sp,
                      font: AppFont.inter,
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    CustomText(
                      text: "We sent a four digit code to your\nemail address",
                      fontSize: 15.sp,
                      color: AppColor.authDescriptionColor,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.left,
                    ),

                    SizedBox(height: 40.h),

                    // OTP Input Field
                    Center(
                      child: Pinput(
                        length: 4,
                        controller: otpNotifier.otpController,
                        focusNode: otpNotifier.otpFocusNode,
                        defaultPinTheme: emptyPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: defaultPinTheme,
                        showCursor: true,
                        cursor: Container(
                          width: 2,
                          height: 30.h,
                          color: AppColor.primary,
                        ),
                        onCompleted: (pin) {
                          // Auto-submit when all 4 digits are entered
                          otpNotifier.verifyOtp(pin);
                        },
                        onChanged: (value) {
                          otpNotifier.updateOtp(value);
                        },
                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      ),
                    ),

                    // Error Message
                    if (otpState.errorMessage != null) ...[
                      SizedBox(height: 16.h),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: CustomText(
                            text: otpState.errorMessage!,
                            color: AppColor.error,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],

                    SizedBox(height: 80.h),

                    // Sign Up Button
                    CustomButton(
                      text: "Verify",
                      onPressed: otpState.isLoading
                          ? null
                          : () {
                        showCustomDialog(context, imagePath: IconPath.success, title: "Account  verified Successfully", buttonText: "Done",
                            onPressed: (){
                              context.push('/allowLocation');
                            }
                        );
                        /*otpNotifier.verifyOtp(
                          otpNotifier.otpController.text,
                        );*/
                      },
                    ),

                    SizedBox(height: 24.h),

                    // Resend Code Timer or Button
                    Center(
                      child: otpState.canResend
                          ? GestureDetector(
                        onTap: () {
                          otpNotifier.resendOtp();
                        },
                        child: CustomText(
                          text: "Resend Code",
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColor.primary,
                        ),
                      )
                          : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Re-send code in ",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textBody,
                          ),
                          CustomText(
                            text: otpNotifier.formattedTimer,
                            color: AppColor.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Spam Folder Text
                    Center(
                      child: CustomText(
                        text: "Can't find the email? Check your spam folder.",
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                        color: AppColor.headerColor,
                        textAlign: TextAlign.center,
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
}