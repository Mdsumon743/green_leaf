import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/features/employee_flow/home/presentation/widget/status_card.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/service_data_model.dart';


class ServiceCard extends StatelessWidget {
  final CustomerServiceModel service;
  final VoidCallback onViewDetails;

  const ServiceCard({required this.service, required this.onViewDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
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
              CustomText(
                text: service.title,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.black,
              ),
              StatusBadge(status: service.status),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Quote: ${service.quoteNumber}',
                fontSize: 16.sp,
                color: Color(0xFF4A4E5A),
              ),
              CustomText(
                text: '€ ${service.price.toStringAsFixed(2)}',
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.primary,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: onViewDetails,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: Alignment.topCenter,
                  begin: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF126A19),
                    Color(0xFF8CC40F),
                  ]
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'View Details',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6.w),
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white, size: 13.r),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}