import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/global/curve_clipper.dart'; // Ensure this is imported
import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../provider/review_provider.dart';

class ReviewHistory extends ConsumerWidget {
  const ReviewHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(reviewsListProvider);

    return Scaffold(
      body: Stack(
        children: [
          // ── Background image ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground, // Consistent background
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // ── Header (Centered Title) ──────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Reviews History',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w), // Balance for back icon
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // ── Curved Content Area ──────────────────────────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(), // Applied here
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.containerBackground,
                          AppColor.containerBackground,
                          AppColor.containerBackground.withOpacity(0.85),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.4, 0.7, 1.0],
                      ),
                    ),
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        top: 60.h, // Space for the curve peak
                        left: 20.w,
                        right: 20.w,
                        bottom: 100.h,
                      ),
                      itemCount: reviews.length,
                      separatorBuilder: (context, index) => SizedBox(height: 16.h),
                      itemBuilder: (context, index) {
                        final review = reviews[index];
                        return ReviewCard(
                          serviceName: review.serviceName,
                          date: review.date,
                          rating: review.rating,
                          comment: review.comment,
                          onEdit: () {
                            // Handle edit action
                          },
                          onDelete: () {
                            // Handle delete action
                          },
                        );
                      },
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
}

class ReviewCard extends StatelessWidget {
  final String serviceName;
  final String date;
  final int rating;
  final String comment;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ReviewCard({
    super.key,
    required this.serviceName,
    required this.date,
    required this.rating,
    required this.comment,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04), // Softer shadow
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: serviceName,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.textBody,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: date,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9098A1),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      child: Image.asset(IconPath.edit04,height: 24.h,width: 24.w,)
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      child: Image.asset(IconPath.delete02,height: 24.h,width: 24.h,),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                size: 18.sp,
                color: const Color(0xFFFFC107),
              );
            }),
          ),
          SizedBox(height: 10.h),
          CustomText(
            text: comment,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF455A64),
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}