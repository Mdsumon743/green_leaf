


import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/global/custom_text.dart';
import '../../model/service_data_model.dart';

class StatusBadge extends StatelessWidget {
  final ServiceStatus status;
  const StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color text;
    String label;

    switch (status) {
      case ServiceStatus.pending:
        bg = const Color(0xFFFFF3E0);
        text = const Color(0xFFF57C00);
        label = 'Pending';
        break;
      case ServiceStatus.completed:
        bg = const Color(0xFFE8F5E9);
        text = const Color(0xFF2E7D32);
        label = 'Completed';
        break;
      case ServiceStatus.cancel:
        bg = const Color(0xFFFFEBEE);
        text = const Color(0xFFC62828);
        label = 'Cancel';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        text: label,
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        color: text,
      ),
    );
  }
}