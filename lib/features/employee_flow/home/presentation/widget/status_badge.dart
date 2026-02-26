import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/service_data_model.dart';

class StatusBadge extends StatelessWidget {
  final ServiceStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color, bg) = switch (status) {
      ServiceStatus.pending => (
      'Pending',
      const Color(0xFFFFA500),
      const Color(0xFFFFF3E0)
      ),
      ServiceStatus.completed => (
      'Completed',
      AppColor.primary,
      const Color(0xFFE8F5E9)
      ),
      ServiceStatus.cancel => (
      'Cancelled',
      const Color(0xFFE53935),
      const Color(0xFFFFEBEE)
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: CustomText(
        text: label,
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    );
  }
}