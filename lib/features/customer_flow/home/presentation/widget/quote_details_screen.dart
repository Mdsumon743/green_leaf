import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import '../../../../../core/constants/image_path.dart';
import '../../../../../core/utils/app_color.dart';

class QuoteDetailsScreen extends StatelessWidget {
  const QuoteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImagePath.quoteBackground,
              width: double.infinity,
              fit: BoxFit.fitWidth, // Spans the full width at the top
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.myQuotesDetailsBottumBG,
              width: double.infinity,
              fit: BoxFit.fitWidth, // Pinned strictly to the bottom
            ),
          ),

          // Overlay (slightly adjusted opacity for better readability)
          Container(
            color: Colors.black.withOpacity(0.42),
          ),

          SafeArea(
            child: Column(
              children: [
                // AppBar / Header
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20.sp,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'My Quotes Details',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      SizedBox(width: 44.w), // mirror left side
                    ],
                  ),
                ),

                Expanded(
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white,
                              Colors.white,
                              Colors.transparent,
                            ],
                            stops: const [0.0, 0.8, 1.0],
                          ).createShader(bounds);
                        },
                        blendMode: BlendMode.dstIn,
                        child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5FAF5), // very soft mint
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.07),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(38.r),
                            bottom: Radius.circular(38.r),
                          ),
                          child: Stack(
                            children: [
                              // Subtle bottom fade
                              SingleChildScrollView(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 28.w,
                                  vertical: 36.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header section - centered
                                    Center(
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12.r),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF36B840).withValues(alpha: 0.2),
                                              borderRadius: BorderRadius.circular(5.r),
                                              border: Border.all(color: Color(0xFF36B840).withValues(alpha: 0.3)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.green.withOpacity(0.08),
                                                  blurRadius: 12,
                                                  offset: const Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                showCustomDialog(
                                                  context,
                                                  imagePath: IconPath.success,
                                                  title: "Reminder!",
                                                  buttonText: "Done",
                                                  message:
                                                  "You have 2 days remaining to start your service. Be noted.",
                                                  onPressed: () => context.pop(),
                                                );
                                              },
                                              child: Image.asset(IconPath.appointment02,height: 20.h,width: 20.w,)
                                            ),
                                          ),
                                          SizedBox(height: 28.h),
                                          Text(
                                            'Quote: #1024',
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 6.h),
                                          Text(
                                            'Garden Maintenance',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFF6B7280),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 24.h),

                                    _buildDetailRow('Total Price', '€120.00', isPrice: true),

                                    SizedBox(height: 18.h),
                                    _buildDashedDivider(),
                                    SizedBox(height: 18.h),

                                    _buildDetailRow('Prefer Date', 'Friday, 16th July, 10:00AM'),

                                    SizedBox(height: 18.h),
                                    _buildDashedDivider(),
                                    SizedBox(height: 18.h),

                                    Text(
                                      'Job Description',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xFF424242),
                                      ),
                                    ),
                                    SizedBox(height: 14.h),
                                    Text(
                                      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),

                                    SizedBox(height: 18.h),
                                    _buildDashedDivider(),
                                    SizedBox(height: 18.h),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Status',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xFF5B616E),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 6.h,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFFAAD14).withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          child: Text(
                                            'Pending',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xFFFAAD14),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 80.h), // safe bottom space
                                  ],
                                ),
                              ),
                            ],
                          ),
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

  Widget _buildDetailRow(String label, String value, {bool isPrice = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF5B616E),
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: isPrice ? 21.sp : 15.sp,
              fontWeight: isPrice ? FontWeight.w600 : FontWeight.w400,
              color: isPrice ? const Color(0xFF2E7D32) : const Color(0xFF1E1E1E),
              letterSpacing: isPrice ? -0.3 : 0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDashedDivider() {
    return Container(
      height: 1.h,
      color: Colors.transparent,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final dashWidth = 5.w;
          final dashGap = 3.w;
          final count = (constraints.maxWidth / (dashWidth + dashGap)).floor();
          return Row(
            children: List.generate(
              count,
                  (_) => Container(
                width: dashWidth,
                height: 1.h,
                margin: EdgeInsets.only(right: dashGap),
                color: const Color(0xFFDADADA),
              ),
            ),
          );
        },
      ),
    );
  }
}