import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/features/employee_flow/home/presentation/widget/status_badge.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/service_data_model.dart';

class WeeklyServiceTile extends StatelessWidget {
  final CustomerServiceModel service;

  const WeeklyServiceTile({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: _statusColor(service.status),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: service.title,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: service.preferDate,
                  fontSize: 11.sp,
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          StatusBadge(status: service.status),
        ],
      ),
    );
  }

  Color _statusColor(ServiceStatus status) {
    switch (status) {
      case ServiceStatus.pending:
        return const Color(0xFFFFA500);
      case ServiceStatus.completed:
        return AppColor.primary;
      case ServiceStatus.cancel:
        return const Color(0xFFE53935);
    }
  }
}