import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';

import '../../../../../core/utils/app_color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The bottom navigation bar from your image should be handled in your ShellRoute/Main Screen
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground,
              fit: BoxFit.cover,
            ),
          ),

          // Main content
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              CustomText(
                text: 'Profile',
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),

              SizedBox(height: 30.h), // Adjusted spacing

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
                        stops: const [0.0, 0.5, 0.8, 1.0],
                      )
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 40.h), // Space for the curve

                        // Profile image
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 55.r,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 52.r,
                                backgroundImage: AssetImage(ImagePath.user),
                              ),
                            ),
                            // Edit Icon Badge (Matching the blue/pencil style)
                            Container(
                              padding: EdgeInsets.all(4.r),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2196F3),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(Icons.edit_note, size: 18.sp, color: Colors.white),
                            ),
                          ],
                        ),

                        SizedBox(height: 12.h),
                        CustomText(
                          text: 'Oliver',
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2D3E50),
                        ),
                        CustomText(
                          text: 'info@gmail.com',
                          fontSize: 14.sp,
                          color: const Color(0xFF7D8C97),
                        ),

                        SizedBox(height: 25.h),

                        // Menu items
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            children: [
                              // FIRST GROUP
                              _buildMenuSection([
                                _MenuItemData(IconPath.edit, 'Edit Profile', () => context.push("/editProfile")),
                                _MenuItemData(IconPath.address, 'Address Management', () => context.push("/address")),
                                _MenuItemData(IconPath.settings, 'Account Setting', () => context.push("/system")),
                              ]),

                              SizedBox(height: 16.h),

                              // SECOND GROUP
                              _buildMenuSection([
                                _MenuItemData(IconPath.keyframesMultiple, 'Gardening Tips', () => context.push("/gardening")),
                                _MenuItemData(IconPath.userSquare, 'Refer a friend', () => context.push("/refer")),
                                _MenuItemData(IconPath.starSquare, 'Reviews History', () => context.push("/review")),
                                _MenuItemData(IconPath.gallery, 'Gallery', () => context.push("/gallery")),
                                _MenuItemData(IconPath.signOutAlt, 'Logout', () {
                                  showCustomDialog(context,
                                      imagePath: IconPath.confirmation,
                                      title: "Are You Sure?",
                                      buttonText: "cancel",
                                      isDoubleButton: true,
                                      secondButtonText: "Logout",
                                      onPressed: () => context.pop(),
                                      onSecondPressed: () => context.push('/login'),
                                      message: "Do you want to log out?"
                                  );
                                }, isLogout: true),
                              ]),
                              SizedBox(height: 30.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper to build the white card sections seen in the image
  Widget _buildMenuSection(List<_MenuItemData> items) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Column(
            children: [
              _buildMenuItem(
                icon: item.icon,
                title: item.title,
                onTap: item.onTap,
                isLogout: item.isLogout,
              ),
              if (index != items.length - 1)
                Divider(height: 1, thickness: 1, color: Colors.grey.shade100, indent: 20.w,endIndent: 20.w,),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    // Logic to determine which widget to use
    final bool isSvg = icon.toLowerCase().endsWith('.svg');
    final Color iconColor = isLogout ? Colors.redAccent : const Color(0xFF2D2D2D);

    return ListTile(
      onTap: onTap,
      // -4 reduces the vertical height to the minimum
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      leading: SizedBox(
        height: 24.h,
        width: 24.w,
        child: isSvg
            ? SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        )
            : Image.asset(
          icon,
          color: iconColor,
        ),
      ),
      title: Transform.translate(
        offset: Offset(-8.w, 0), // Reduces gap between icon and text
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: iconColor,
          ),
        ),
      ),
      trailing: isLogout
          ? null
          : Icon(Icons.chevron_right, color: Colors.grey.shade400, size: 20.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
    );
  }
}

// Simple data class for mapping
class _MenuItemData {
  final String icon;
  final String title;
  final VoidCallback onTap;
  final bool isLogout;
  _MenuItemData(this.icon, this.title, this.onTap, {this.isLogout = false});
}