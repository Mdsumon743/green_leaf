import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/features/employee_flow/home/presentation/widget/status_badge.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/service_data_model.dart';

class TimeSlotRow extends StatelessWidget {
  final String timeLabel;
  final CustomerServiceModel? service;

  const TimeSlotRow({super.key, required this.timeLabel, this.service});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 60.w,
          child: Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: CustomText(
              text: timeLabel,
              fontSize: 11.sp,
              color: const Color(0xFF888888),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              if (service != null)
                Container(
                  margin: EdgeInsets.only(bottom: 4.h),
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColor.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColor.primary.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: AppColor.primary,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: service!.title,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColor.primary,
                            ),
                            SizedBox(height: 2.h),
                            CustomText(
                              text: service!.address,
                              fontSize: 11.sp,
                              color: const Color(0xFF555555),
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      StatusBadge(status: service!.status),
                    ],
                  ),
                )
              else
                Container(
                  height: 44.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withValues(alpha: 0.15),
                        width: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}