
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/features/employee_flow/home/presentation/widget/weekly_service_tile.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/service_data_model.dart';

class WeeklyCalendarView extends StatelessWidget {
  final DateTime focusedDate;
  final List<CustomerServiceModel> services;
  final void Function(DateTime) onDayTap;

  const WeeklyCalendarView({super.key,
    required this.focusedDate,
    required this.services,
    required this.onDayTap,
  });

  @override
  Widget build(BuildContext context) {
    final startOfWeek = focusedDate.subtract(Duration(days: focusedDate.weekday - 1));
    final weekDays = List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
    const dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final today = DateTime.now();

    return Column(
      children: [
        // Day headers
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: List.generate(7, (i) {
              final day = weekDays[i];
              final isToday = day.year == today.year &&
                  day.month == today.month &&
                  day.day == today.day;
              final isFocused = day.year == focusedDate.year &&
                  day.month == focusedDate.month &&
                  day.day == focusedDate.day;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onDayTap(day),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Column(
                      children: [
                        CustomText(
                          text: dayLabels[i],
                          fontSize: 11.sp,
                          color: const Color(0xFF888888),
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 4.h),
                        Container(
                          width: 30.r,
                          height: 30.r,
                          decoration: BoxDecoration(
                            color: isToday
                                ? AppColor.primary
                                : isFocused
                                ? AppColor.primary.withValues(alpha: 0.15)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CustomText(
                              text: '${day.day}',
                              fontSize: 13.sp,
                              fontWeight: isToday || isFocused
                                  ? FontWeight.w700
                                  : FontWeight.w400,
                              color: isToday
                                  ? Colors.white
                                  : isFocused
                                  ? AppColor.primary
                                  : const Color(0xFF333333),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),

        Divider(
          height: 1,
          thickness: 1,
          color: Colors.grey.withValues(alpha: 0.15),
        ),
        SizedBox(height: 12.h),

        // Weekly service cards
        Expanded(
          child: services.isEmpty
              ? Center(
            child: CustomText(
              text: 'No tasks this week',
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 40.h),
            itemCount: 7,
            itemBuilder: (context, dayIndex) {
              final day = weekDays[dayIndex];
              // For demo purposes, show pending services on specific days
              final dayServices = _getServicesForDay(dayIndex);
              if (dayServices.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h, top: 4.h),
                    child: CustomText(
                      text:
                      '${dayLabels[dayIndex]}, ${day.day}',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.primary,
                    ),
                  ),
                  ...dayServices.map(
                        (s) => WeeklyServiceTile(service: s),
                  ),
                  SizedBox(height: 12.h),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  List<CustomerServiceModel> _getServicesForDay(int dayIndex) {
    // Demo distribution: spread services across weekdays
    return services.where((s) {
      final id = int.tryParse(s.id) ?? 0;
      return (id - 1) % 7 == dayIndex;
    }).toList();
  }
}