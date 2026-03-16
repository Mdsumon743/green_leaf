import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_color.dart';
import 'custom_text.dart';

void showCustomDialog(
    BuildContext context, {
      required String imagePath,
      required String title,
      String? message,
      required String buttonText,
      String? secondButtonText,
      void Function()? onPressed,
      void Function()? onSecondPressed,
      bool isDoubleButton = false,
      // New Parameters
      Color? buttonColor,
      Gradient? buttonGradient,
    }) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Container(
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF252525) : Colors.white,
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, height: 120.h, width: 120.w),
              SizedBox(height: 20.h),
              CustomText(
                text: title,
                textAlign: TextAlign.center,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: isDarkMode ? Colors.white : AppColor.textBody,
              ),
              if (message != null && message.isNotEmpty) ...[
                SizedBox(height: 10.h),
                CustomText(
                  text: message,
                  textAlign: TextAlign.center,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                ),
              ],
              SizedBox(height: 24.h),
              isDoubleButton
                  ? Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onPressed ?? () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: AppColor.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: CustomText(text: buttonText, color: AppColor.primary),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: _buildFlexibleButton(
                      text: secondButtonText ?? 'Cancel',
                      onTap: onSecondPressed ?? () => Navigator.pop(context),
                      color: buttonColor,
                      gradient: buttonGradient,
                    ),
                  ),
                ],
              )
                  : _buildFlexibleButton(
                text: buttonText,
                onTap: onPressed ?? () {},
                color: buttonColor,
                gradient: buttonGradient,
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget _buildFlexibleButton({
  required String text,
  required VoidCallback onTap,
  Color? color,
  Gradient? gradient,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        // If gradient is provided, use it.
        // If not, but color is provided, use null (color takes over).
        // If both are null, use the default green gradient.
        gradient: gradient ?? (color == null ? const LinearGradient(
          colors: [Color(0xFF11A41C), Color(0xFF0F4A11)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ) : null),
        color: color,
        boxShadow: [
          BoxShadow(
            color: (color ?? const Color(0xFF11A41C)).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: CustomText(
          text: text,
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16.sp,
        ),
      ),
    ),
  );
}