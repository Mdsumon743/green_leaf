import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuoteCard extends StatelessWidget {
  final String name; // e.g., "Garden Maintenance"
  final String category; // e.g., "Quote: #1024"
  final String status; // e.g., "Pending"
  final String price; // e.g., "€ 120.00"
  final VoidCallback onPressed;
  final String image; // Asset path for the garden image

  const QuoteCard({
    super.key,
    required this.name,
    required this.category,
    required this.status,
    required this.price,
    required this.onPressed,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF9FAF3), // Very light beige top
            Color(0xFFF3F5E7), // Slightly darker beige bottom
          ],
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal:  20.w,vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section (Image + Title + Status)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Garden Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  image,
                  height: 62.h,
                  width: 62.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8.w),
              // 2. Text Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 2a. Title
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF383A42), // Dark green-black
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        // 2b. Status Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 3.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100), // Capsule
                            color: const Color(0xFFFAAD14), // Rich orange
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    // 2c. Category/Quote
                    Row(
                      children: [
                        Text(
                          category,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF4A4E5A), // Greenish gray
                          ),
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              price,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF126A19), // Strong green
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),


          // Bottom Section (View Details Button)
          _buildGradientButton(context),
        ],
      ),
    );
  }

  // Helper Widget for the Gradient Border Button
  Widget _buildGradientButton(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        //height: 50.h,
        //padding: EdgeInsets.symmetric(vertical: 8.h),
        // --- Button Outer Border Gradient ---
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF9DC167),
              Color(0xFF348317),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF114316).withOpacity(0.4),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        // Border thickness
        padding: const EdgeInsets.all(1.5),
        child: Container(
          // --- Button Inner Gradient ---
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), // Match radius
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF8CC40F), // Lighter green top
                Color(0xFF126A19), // Dark green bottom
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'View Details',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}