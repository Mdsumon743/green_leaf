import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_color.dart';
import '../../model/service_model.dart';
import '../screen/all_service_screen.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16.r)),
            child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: service.imagePath.isNotEmpty
                  ? Image.asset(
                service.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => PlaceholderImg(),
              )
                  : PlaceholderImg(),
            ),
          ),

          // Text content
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.fromLTRB(14.w, 0, 8.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.textDark,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.textLight,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Arrow button
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}