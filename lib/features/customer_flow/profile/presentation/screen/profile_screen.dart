import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Top spacing for status bar
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // "Profile" title
              CustomText(
                text: 'Profile',
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),

              SizedBox(height: 60.h),

              // White card container
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Profile image positioned to overlap
                      Transform.translate(
                        offset: Offset(0, -40.h),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50.r,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 47.r,
                                backgroundImage: AssetImage(ImagePath.user),
                              ),
                            ),
                            // Blue checkmark badge
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 28.w,
                                height: 28.h,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.w,
                                  ),
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Name
                      Transform.translate(
                        offset: Offset(0, -30.h),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Oliver',
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            SizedBox(height: 4.h),
                            CustomText(
                              text: 'info@gmail.com',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Menu items
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          children: [
                            _buildMenuItem(
                              icon: Icons.edit_outlined,
                              title: 'Edit Profile',
                              onTap: () {
                                context.push("/editProfile");
                              },
                            ),
                            _buildMenuItem(
                              icon: Icons.location_on_outlined,
                              title: 'Address Management',
                              onTap: () {
                                context.push("/address");
                              },
                            ),
                            _buildMenuItem(
                              icon: Icons.settings_outlined,
                              title: 'Account Settings',
                              onTap: () {
                                context.push("/system");
                              },
                            ),
                            _buildMenuItem(
                              icon: Icons.spa_outlined,
                              title: 'Gardening Tips',
                              onTap: () {
                                context.push("/gardening");
                              },
                            ),
                            _buildMenuItem(
                              icon: Icons.person_add_outlined,
                              title: 'Refer a friend',
                              onTap: () {
                                context.push("/refer");
                              },
                            ),
                            _buildMenuItem(
                              icon: Icons.star_outline,
                              title: 'Reviews History',
                              onTap: () {
                                context.push("/review");
                              },

                            ),
                            _buildMenuItem(
                              icon: Icons.photo_library_outlined,
                              title: 'Gallery',
                              onTap: () {
                                context.push("/gallery");
                              },
                            ),
                            SizedBox(height: 10.h),
                            _buildMenuItem(
                              icon: Icons.logout,
                              title: 'Logout',
                              isLogout: true,
                              onTap: () {
                                showCustomDialog(context, imagePath: IconPath.confirmation, title: "Are You Sure?", buttonText: "cancel",
                                isDoubleButton: true, secondButtonText: "Logout", onPressed: (){
                                  context.pop();
                                    },
                                onSecondPressed: (){
                                  context.push('/login');
                                }, message: "Do you want to log out?");
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12.h),
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            // Leading Icon
            Icon(
              icon,
              color: isLogout ? Colors.red : Colors.black54,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            // Title
            Expanded(
              child: CustomText(
                text: title,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: isLogout ? Colors.red : Colors.black87,
              ),
            ),
            // Trailing arrow (if not logout)
            if (!isLogout)
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }

}