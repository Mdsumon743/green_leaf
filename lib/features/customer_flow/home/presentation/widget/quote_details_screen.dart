import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:go_router/go_router.dart";
import "package:saunders/core/constants/icon_path.dart";
import "package:saunders/core/global/show_custom_dialog.dart";
import "../../../../../core/constants/image_path.dart";

class QuoteDetailsScreen extends StatelessWidget {
  const QuoteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            ImagePath.quoteBackground,
            fit: BoxFit.cover,
          ),

          // Dark Overlay
          Container(
            color: Colors.black.withValues(alpha: 0.35),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          child: Icon(
                            Icons.arrow_back,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'My Quotes Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // Details Card - Fills remaining space
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F4F0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50.r),
                        topRight: Radius.circular(50.r),
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Gradient at bottom
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 150.h,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  const Color(0xFFF0F4F0).withValues(alpha: 0.0),
                                  const Color(0xFFF0F4F0).withValues(alpha: 0.3),
                                  const Color(0xFFF0F4F0).withValues(alpha: 0.6),
                                  const Color(0xFFF0F4F0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Content
                        SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 32.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Calendar Icon and Quote Header
                              Center(
                                child: Column(
                                  children: [
                                    // Calendar Icon Container
                                    GestureDetector(
                                      onTap: (){

                                        showCustomDialog(context, imagePath: IconPath.success, title: "Reminder!", buttonText: "Done",
                                        message: "You have 2 days remaining to start your service. Be noted.",
                                          onPressed: (){
                                          context.pop();
                                          }
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(12.w),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFD4E8D4),
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        child: Icon(
                                          Icons.calendar_today_outlined,
                                          color: const Color(0xFF66BB6A),
                                          size: 28.sp,
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 20.h),

                                    Text(
                                      'Quote: #1024',
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF1A1A1A),
                                      ),
                                    ),
                                    SizedBox(height: 6.h),
                                    Text(
                                      'Garden Maintenance',
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xFF7A7A7A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 32.h),

                              // Total Price Row
                              _buildDetailRow(
                                'Total Price',
                                '€120.00',
                                isPriceRow: true,
                              ),

                              SizedBox(height: 6.h),
                              _buildDashedDivider(),
                              SizedBox(height: 20.h),

                              // Prefer Date Row
                              _buildDetailRow(
                                'Prefer Date',
                                'Friday, 16th July, 10:00AM',
                              ),

                              SizedBox(height: 6.h),
                              _buildDashedDivider(),
                              SizedBox(height: 24.h),

                              // Job Description Section
                              Text(
                                'Job Description',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF7A7A7A),
                                ),
                              ),

                              SizedBox(height: 12.h),

                              Text(
                                'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF1A1A1A),
                                  height: 1.6,
                                ),
                              ),

                              SizedBox(height: 24.h),
                              _buildDashedDivider(),
                              SizedBox(height: 24.h),

                              // Status Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF7A7A7A),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFFF3E0),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Text(
                                      'Pending',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: const Color(0xFFFFA726),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 40.h), // Extra space at bottom
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildDetailRow(String label, String value, {bool isPriceRow = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF7A7A7A),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isPriceRow ? 20.sp : 14.sp,
              fontWeight: isPriceRow ? FontWeight.w700 : FontWeight.w500,
              color: isPriceRow ? const Color(0xFF27AE60) : const Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return Row(
      children: List.generate(
        40,
            (index) => Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            height: 1.h,
            color: const Color(0xFFD0D0D0),
          ),
        ),
      ),
    );
  }
}