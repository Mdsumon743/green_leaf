import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart'; // Import your clipper
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';

class SystemSetting extends StatefulWidget {
  const SystemSetting({super.key});

  @override
  State<SystemSetting> createState() => _SystemSettingState();
}

class _SystemSettingState extends State<SystemSetting> {
  bool emailNotifications = true;
  bool smsNotification = true;
  bool pushNotifications = false;


  // core/global/show_custom_dialog.dart

  Future<void> showCustomDialog(
      BuildContext context, {
        required String imagePath,
        required String title,
        required String message,
        required String buttonText,
        Color? buttonColor,
        Color? buttonTextColor, // Now valid
        bool isDoubleButton = false,
        String? secondButtonText,
        Color? secondButtonColor,
        Color? secondButtonTextColor, // Now valid
        required VoidCallback onPressed,
        VoidCallback? onSecondPressed,
      }) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        imagePath: imagePath,
        title: title,
        message: message,
        buttonText: buttonText,
        buttonColor: buttonColor,
        buttonTextColor: buttonTextColor, // Passing to Widget
        isDoubleButton: isDoubleButton,
        secondButtonText: secondButtonText,
        secondButtonColor: secondButtonColor,
        secondButtonTextColor: secondButtonTextColor, // Passing to Widget
        onPressed: onPressed,
        onSecondPressed: onSecondPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground, // Using background from image_c92ec0.png
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(Icons.arrow_back, color: AppColor.white, size: 24.sp),
                    ),
                    const Spacer(),
                    CustomText(
                      text: "Setting",
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                      fontSize: 20.sp,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // Main content with CurveClipper
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
                          Colors.transparent
                        ],
                        stops: const [0.0, 0.6, 0.8, 1.0],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          SizedBox(height: 60.h), // Space for the curve peak

                          // 1. NOTIFICATIONS GROUP
                          _buildWhiteGroupCard([
                            _buildSectionHeader(
                              icon: IconPath.notification,
                              title: "Notifications",
                              iconColor: const Color(0xFF126A19),
                              textColor: Color(0xFF2D2D2D)
                            ),
                            Divider(),
                            _buildToggleItem("Email Notifications", emailNotifications, (val) {
                              setState(() => emailNotifications = val);
                            }),
                            Divider(),
                            _buildToggleItem("SMS Notification", smsNotification, (val) {
                              setState(() => smsNotification = val);
                            }),
                            Divider(),
                            _buildToggleItem("Push Notifications", pushNotifications, (val) {
                              setState(() => pushNotifications = val);
                            }),
                          ]),

                          SizedBox(height: 20.h),

                          // 2. PASSWORD GROUP
                          _buildWhiteGroupCard([
                            _buildSectionHeader(
                              icon: IconPath.lockPassword,
                              title: "Password",
                              iconColor: const Color(0xFF126A19),
                            ),
                            const Divider(height: 24),
                            _buildActionButton(
                              text: "Change Password",
                              color: const Color(0xFFD4E7D7),
                              textColor: const Color(0xFF126A19),
                              onTap: () => context.push("/changePassword"),
                            ),
                          ]),

                          SizedBox(height: 20.h),

                          // 3. DANGER ZONE GROUP
                          _buildWhiteGroupCard([
                            _buildSectionHeader(
                              icon: IconPath.delete02,
                              title: "Danger Zone",
                              iconColor: Colors.red,
                              textColor: Colors.red,
                            ),
                            const Divider(height: 24),
                            CustomText(
                              text: "Once you delete your account, there is no going back. Please be certain.",
                              fontSize: 13.sp,
                              color: Colors.red,
                              maxLines: 2,
                            ),
                            SizedBox(height: 16.h),
                            _buildActionButton(
                              text: "Delete Account",
                              color: Colors.red,
                              textColor: Colors.white,
                              onTap: () {
                                showCustomDialog(
                                  context,
                                  imagePath: IconPath.confirmation,
                                  title: "Are You Sure?",
                                  message: "Do you want to Delete Account?",

                                  // Cancel Button (The "Primary" button in your code snippet)
                                  buttonText: "Cancel",
                                  buttonColor: Colors.transparent,
                                  buttonTextColor: Colors.black,
                                  isDoubleButton: true,
                                  secondButtonText: "Yes, Delete",
                                  secondButtonColor: const Color(0xFFE53935),
                                  secondButtonTextColor: Colors.white,
                                  onPressed: () => context.pop(),
                                  onSecondPressed: () {
                                    // Actual Delete logic here
                                  },
                                );
                              },
                            ),
                          ]),

                          SizedBox(height: 100.h), // Bottom padding for fade
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Helper for the white card containers
  Widget _buildWhiteGroupCard(List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildSectionHeader({
    required String icon,
    required String title,
    Color? iconColor,
    Color? textColor
  }) {
    final bool isSvg = icon.toLowerCase().endsWith('.svg'); // Check type

    return Row(
      children: [
        SizedBox(
          height: 24.h,
          width: 24.w,
          child: isSvg
              ? SvgPicture.asset( // Requires flutter_svg package
            icon,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                : null,
          )
              : Image.asset(
            icon,
            color: iconColor,
          ),
        ),
        SizedBox(width: 8.w),
        CustomText(
            text: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: textColor ?? const Color(0xFF2D3E50)
        ),
      ],
    );
  }
  Widget _buildToggleItem(String title, bool value, Function(bool) onChanged) {
    return Padding(
      // Set vertical to 0 or very small (2.h) to collapse space
      padding: EdgeInsets.symmetric(vertical: 0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 15.sp,
            color: const Color(0xFF2D2D2D),
            fontWeight: FontWeight.w400,
          ),
          Transform.scale(
            scale: 0.75, // Slightly smaller switch to match image_c99b5f
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFFFFFFFF),
              activeTrackColor: const Color(0xFF126A19),
              inactiveThumbColor: const Color(0xFF9098A1),
              inactiveTrackColor: const Color(0xFFE0E0E6),
              // --- Custom Colors End ---
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildActionButton({required String text, required Color color, required Color textColor, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12.r)),
        child: Center(child: CustomText(text: text, fontSize: 16.sp, fontWeight: FontWeight.w600, color: textColor)),
      ),
    );
  }
}


class CustomDialog extends StatelessWidget {
  final String imagePath;
  final String title;
  final String message;
  final String buttonText;
  final Color? buttonColor;
  final Color? buttonTextColor; // Added this
  final bool isDoubleButton;
  final String? secondButtonText;
  final Color? secondButtonColor;
  final Color? secondButtonTextColor; // Added this
  final VoidCallback onPressed;
  final VoidCallback? onSecondPressed;

  const CustomDialog({
    super.key,
    required this.imagePath,
    required this.title,
    required this.message,
    required this.buttonText,
    this.buttonColor,
    this.buttonTextColor, // Added to constructor
    this.isDoubleButton = false,
    this.secondButtonText,
    this.secondButtonColor,
    this.secondButtonTextColor, // Added to constructor
    required this.onPressed,
    this.onSecondPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagePath, width: 80.r, height: 80.r),
            SizedBox(height: 16.h),
            CustomText(
              text: title,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: message,
              fontSize: 14.sp,
              textAlign: TextAlign.center,
              color: AppColor.textBody.withOpacity(0.7),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                if (isDoubleButton) ...[
                  Expanded(
                    child: _DialogButton(
                      text: secondButtonText ?? "Cancel",
                      onTap: onSecondPressed ?? () => Navigator.pop(context),
                      color: secondButtonColor ?? Colors.grey.shade100,
                      // Using the new text color variable here:
                      textColor: secondButtonTextColor ?? AppColor.black,
                    ),
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: _DialogButton(
                    text: buttonText,
                    onTap: onPressed,
                    color: buttonColor ?? AppColor.primary,
                    // Using the new text color variable here:
                    textColor: buttonTextColor ?? Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Internal helper for Dialog Buttons
class _DialogButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;

  const _DialogButton({
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: CustomText(
            text: text,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}