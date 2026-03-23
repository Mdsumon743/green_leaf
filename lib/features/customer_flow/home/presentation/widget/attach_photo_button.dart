import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/icon_path.dart';

class AttachPhotosButton extends StatelessWidget {
  final int count;
  final VoidCallback? onTap; // Added callback for functionality

  const AttachPhotosButton({
    super.key,
    required this.count,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF8CC40F), // Lighter top for border
              Color(0xFF126A19), // Darker bottom for border
            ],
          ),
        ),
        // The thickness of the border is controlled by this padding
        padding: const EdgeInsets.all(2),
        child: Container(
          // --- INNER CONTAINER: The Button Background ---
          decoration: BoxDecoration(
            // Slightly smaller radius to align perfectly inside the border
            borderRadius: BorderRadius.circular(10.5.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8CC40F),
                Color(0xFF126A19),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                IconPath.camera,
                height: 20.h,
                width: 20.w,
              ),
              SizedBox(width: 10.w),
              Text(
                count > 0
                    ? 'Attach Photos ($count/5)'
                    : 'Attach Photos (Optional)',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 12.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}