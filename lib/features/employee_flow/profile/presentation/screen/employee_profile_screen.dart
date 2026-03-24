import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';

class EmployeeProfileScreen extends StatelessWidget {
  const EmployeeProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. TOP GARDEN BACKGROUND
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250.h,
            child: Image.asset(
              ImagePath.homeBackground, // Using the garden image
              fit: BoxFit.cover,
            ),
          ),

          // 2. BOTTOM GARDEN BACKGROUND (Subtle)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 300.h,
            child: Opacity(
              opacity: 0.3, // Faded look at the bottom
              child: Image.asset(
                ImagePath.homeBackground,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // 3. MAIN CONTENT
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                SizedBox(height: 10.h),
                CustomText(
                  text: 'Profile',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                SizedBox(height: 30.h),

                // 4. CURVED OVERLAY
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
                            AppColor.containerBackground.withValues(alpha: 0.8),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.65, 0.8, 1.0],
                        )
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(height: 40.h),
                            // PROFILE IMAGE & BADGE
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  radius: 54.r,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 50.r,
                                    backgroundImage: AssetImage(ImagePath.user),
                                  ),
                                ),
                                Positioned(
                                  right: 4.w,
                                  bottom: 4.h,
                                  child: Container(
                                    padding: EdgeInsets.all(4.r),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF0EA5E9), // Specific blue from image
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.edit, size: 14.sp, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            CustomText(
                              text: 'Oliver',
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                            CustomText(
                              text: 'info@gmail.com',
                              fontSize: 14.sp,
                              color: const Color(0xFF6B7280),
                            ),
                            SizedBox(height: 24.h),

                            // 5. FIRST MENU CARD
                            _buildMenuCard([
                              _buildMenuItem(IconPath.edit, 'Edit Profile', () => context.push("/editProfile")),
                              _buildMenuItem(IconPath.address, 'Address', () => context.push("/address")),
                              _buildMenuItem(IconPath.jobSearch, 'Recurring Jobs', () => context.push("/recurringJob")),
                              _buildMenuItem(IconPath.settings02, 'Setting', () => context.push("/system")),
                            ]),

                            SizedBox(height: 16.h),

                            // 6. SECOND MENU CARD
                            _buildMenuCard([
                              _buildMenuItem(IconPath.agreement02, 'Trusted Local Trades', () => context.push("/localTrade")),
                              _buildMenuItem(IconPath.starSquare, 'Reviews History', () => context.push("/review")),
                              _buildMenuItem(IconPath.gallery, 'Gallery', () => context.push("/gallery")),
                              _buildMenuItem(IconPath.signOutAlt, 'Logout', () {
                                showCustomDialog(
                                  context,
                                  imagePath: IconPath.confirmation,
                                  title: "Are You Sure?",
                                  buttonText: "cancel",
                                  isDoubleButton: true,
                                  secondButtonText: "Logout",
                                  onPressed: () => context.pop(),
                                  onSecondPressed: () => context.push('/login'),
                                  message: "Do you want to log out?",
                                );
                              }, isLogout: true),
                            ]),
                            SizedBox(height: 100.h), // Space for Bottom Nav
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Wrapper to create the white card effect
  Widget _buildMenuCard(List<Widget> items) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: items),
    );
  }

  Widget _buildMenuItem(
      String iconPath,
      String title,
      VoidCallback onTap, {
        bool isLogout = false,
        bool showBorder = true, // Added to toggle the divider line
      }) {
    // Determine if the file is an SVG or an Image (PNG/JPG)
    bool isSvg = iconPath.toLowerCase().endsWith('.svg');

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: showBorder
              ? Border(bottom: BorderSide(color: const Color(0xFFF3F4F6), width: 1.h))
              : null,
        ),
        child: Row(
          children: [
            // Dynamic Icon Rendering
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: isSvg
                  ? SvgPicture.asset(
                iconPath,
                colorFilter: ColorFilter.mode(
                  isLogout ? Colors.redAccent : const Color(0xFF374151),
                  BlendMode.srcIn,
                ),
              )
                  : Image.asset(
                iconPath,
                color: isLogout ? Colors.redAccent : const Color(0xFF374151),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isLogout ? Colors.redAccent : const Color(0xFF374151),
              ),
            ),
            if (!isLogout)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: const Color(0xFF9CA3AF),
                size: 14.sp,
              ),
          ],
        ),
      ),
    );
  }
}