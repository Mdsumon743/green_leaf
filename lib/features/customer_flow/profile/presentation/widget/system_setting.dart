import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              SizedBox(height: 50.h),

              // Header
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColor.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 100.w),
                    CustomText(
                      text: "Setting",
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                      fontSize: 20.sp,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // Main content
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Notifications Section
                        _buildSectionHeader(
                          icon: Icons.notifications_outlined,
                          title: "Notifications",
                        ),

                        SizedBox(height: 16.h),

                        // Email Notifications
                        _buildToggleItem(
                          title: "Email Notifications",
                          value: emailNotifications,
                          onChanged: (val) {
                            setState(() {
                              emailNotifications = val;
                            });
                          },
                        ),

                        SizedBox(height: 12.h),

                        // SMS Notification
                        _buildToggleItem(
                          title: "SMS Notification",
                          value: smsNotification,
                          onChanged: (val) {
                            setState(() {
                              smsNotification = val;
                            });
                          },
                        ),

                        SizedBox(height: 12.h),

                        // Push Notifications
                        _buildToggleItem(
                          title: "Push Notifications",
                          value: pushNotifications,
                          onChanged: (val) {
                            setState(() {
                              pushNotifications = val;
                            });
                          },
                        ),

                        SizedBox(height: 32.h),

                        // Password Section
                        _buildSectionHeader(
                          icon: Icons.lock_outline,
                          title: "Password",
                        ),

                        SizedBox(height: 16.h),

                        // Change Password Button
                        GestureDetector(
                          onTap: (){
                            context.push("/changePassword");
                          },
                          child: Container(
                            width: double.infinity,
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFD4E7D7),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: CustomText(
                                text: "Change Password",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF2D5F3C),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Danger Zone Section
                        _buildSectionHeader(
                          icon: Icons.delete_outline,
                          title: "Danger Zone",
                          iconColor: Colors.red,
                          textColor: Colors.red,
                        ),

                        SizedBox(height: 12.h),

                        // Warning Text
                        CustomText(
                          text: "Once you delete your account, there is no going back. Please be certain.",
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                          maxLines: 3,
                        ),

                        SizedBox(height: 16.h),

                        // Delete Account Button
                        GestureDetector(
                          onTap: (){
                            showCustomDialog(context, imagePath: IconPath.deleteConfirmation, title: "Are You Sure?", buttonText: "Delete", message: "Do you want to Delete Account?",
                            isDoubleButton: true, secondButtonText: "cancel", onPressed: (){}, onSecondPressed: (){
                              context.pop();
                                });
                          },
                          child: Container(
                            width: double.infinity,
                            height: 52.h,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: CustomText(
                                text: "Delete Account",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    Color? iconColor,
    Color? textColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 22.sp,
          color: iconColor ?? Color(0xFF2D5F3C),
        ),
        SizedBox(width: 8.w),
        CustomText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: textColor ?? AppColor.textBody,
        ),
      ],
    );
  }

  Widget _buildToggleItem({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: title,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.textBody,
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Color(0xFF4CAF50),
            activeTrackColor: Color(0xFF81C784),
            inactiveThumbColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[300],
          ),
        ],
      ),
    );
  }
}