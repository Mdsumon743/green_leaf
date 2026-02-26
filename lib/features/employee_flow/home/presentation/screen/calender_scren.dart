

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../provider/calender_provider.dart';
import '../../provider/employee_home_provider.dart';
import '../widget/daily_calender_view.dart';
import '../widget/weekly_calender_view.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calState = ref.watch(calendarProvider);
    final calNotifier = ref.read(calendarProvider.notifier);
    final homeState = ref.watch(employeeHomeProvider);

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          Container(color: AppColor.primary),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ── Calendar Header ──────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                          size: 20.r,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      CustomText(
                        text: 'Calendar',
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),

                // ── White Sheet ──────────────────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F7F3),
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.r)),
                    ),
                    child: Column(
                      children: [
                        // ── Day / Weekly Tab ─────────────────────────────────
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30.r)),
                          ),
                          child: Row(
                            children: CalendarViewType.values.map((type) {
                              final active = calState.viewType == type;
                              final label =
                              type == CalendarViewType.daily ? 'Daily' : 'Weekly';
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => calNotifier.setViewType(type),
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                        EdgeInsets.symmetric(vertical: 15.h),
                                        child: CustomText(
                                          text: label,
                                          fontSize: 14.sp,
                                          fontWeight: active
                                              ? FontWeight.w700
                                              : FontWeight.w400,
                                          color: active
                                              ? AppColor.primary
                                              : const Color(0xFFAAAAAA),
                                        ),
                                      ),
                                      AnimatedContainer(
                                        duration:
                                        const Duration(milliseconds: 220),
                                        height: 2.5.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        decoration: BoxDecoration(
                                          color: active
                                              ? AppColor.primary
                                              : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(2.r),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.withValues(alpha: 0.12),
                        ),

                        // ── Date Navigation ──────────────────────────────────
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: calNotifier.goToPrev,
                                child: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.06),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_left_rounded,
                                    size: 20.r,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                              CustomText(
                                text: calState.viewType == CalendarViewType.daily
                                    ? _formatDailyHeader(calState.focusedDate)
                                    : _formatWeeklyHeader(calState.focusedDate),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                              GestureDetector(
                                onTap: calNotifier.goToNext,
                                child: Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.06),
                                        blurRadius: 6,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    Icons.chevron_right_rounded,
                                    size: 20.r,
                                    color: AppColor.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ── Calendar Content ─────────────────────────────────
                        Expanded(
                          child: calState.viewType == CalendarViewType.daily
                              ? DailyCalendarView(
                            date: calState.focusedDate,
                            services: homeState.services,
                          )
                              : WeeklyCalendarView(
                            focusedDate: calState.focusedDate,
                            services: homeState.services,
                            onDayTap: (date) {
                              calNotifier.setFocusedDate(date);
                              calNotifier.setViewType(CalendarViewType.daily);
                            },
                          ),
                        ),
                      ],
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

  String _formatDailyHeader(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final dayName = days[date.weekday - 1];
    return '$dayName, ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatWeeklyHeader(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return '${startOfWeek.day} ${months[startOfWeek.month - 1]} – ${endOfWeek.day} ${months[endOfWeek.month - 1]} ${endOfWeek.year}';
  }
}

// ─── Daily Calendar View ──────────────────────────────────────────────────────











