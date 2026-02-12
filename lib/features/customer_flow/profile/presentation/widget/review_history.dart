import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 50.w),
                    Text(
                      'Reviews History',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content area with gradient
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 32.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.95),
                        Colors.white.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.5, 0.8, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.only(bottom: 100.h),
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
        border: Border.all(
          color: Color(0xFF055726),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with service name and actions
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
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9CA3AF),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 20.sp,
                      color: Color(0xFF055726),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: onDelete,
                    child: Icon(
                      Icons.delete_outline,
                      size: 20.sp,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Star Rating
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                size: 20.sp,
                color: Color(0xFFFFC107),
              );
            }),
          ),

          SizedBox(height: 12.h),

          // Review Comment
          CustomText(
            text: comment,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}