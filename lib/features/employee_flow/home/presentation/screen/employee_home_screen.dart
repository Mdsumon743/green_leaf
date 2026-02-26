import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/features/employee_flow/home/presentation/screen/service_details_screen.dart';
import '../../../../../core/constants/image_path.dart';
import '../../../../../core/utils/app_color.dart';
import '../../provider/employee_home_provider.dart';
import '../widget/service_card.dart';
import 'calender_scren.dart';

class EmployeeHomeScreen extends ConsumerWidget {
  const EmployeeHomeScreen({super.key});

  static const _tabs = ['Pending', 'Completed', 'Cancel'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employeeHomeProvider);
    final notifier = ref.read(employeeHomeProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Stack(
        children: [
          Container(color: AppColor.primary),

          // Garden photo at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 180.h,
              child: Image.asset(
                ImagePath.homeBackground,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Avatar + name
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22.r,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.asset(
                                ImagePath.user,
                                width: 44.w,
                                height: 44.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Hi, Shane!',
                                color: Colors.white,
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              CustomText(
                                text: 'Welcome Back',
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Action icons
                      Row(
                        children: [
                          // Calendar icon
                          GestureDetector(
                            onTap: () => _openCalendar(context),
                            child: Container(
                              width: 40.r,
                              height: 40.r,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.calendar_month_rounded,
                                  color: Colors.white,
                                  size: 20.r,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          // Notification icon
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.7),
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.notifications_none_rounded,
                                color: Colors.white,
                                size: 22.r,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── White sheet (tabs + list) ────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F7F3),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: Column(
                      children: [
                        // Tab row
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30.r),
                            ),
                          ),
                          child: Row(
                            children: List.generate(_tabs.length, (i) {
                              final active = state.selectedTab == i;
                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => notifier.setTab(i),
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 15.h,
                                        ),
                                        child: CustomText(
                                          text: _tabs[i],
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
                                        duration: const Duration(
                                          milliseconds: 220,
                                        ),
                                        height: 2.5.h,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                        ),
                                        decoration: BoxDecoration(
                                          color: active
                                              ? AppColor.primary
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                            2.r,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),

                        Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey.withValues(alpha: 0.12),
                        ),

                        // Cards
                        Expanded(
                          child: state.filteredServices.isEmpty
                              ? Center(
                                  child: CustomText(
                                    text:
                                        'No ${_tabs[state.selectedTab]} services',
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                )
                              : ListView.separated(
                                  padding: EdgeInsets.fromLTRB(
                                    16.w,
                                    18.h,
                                    16.w,
                                    40.h,
                                  ),
                                  itemCount: state.filteredServices.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(height: 14.h),
                                  itemBuilder: (context, index) {
                                    final service =
                                        state.filteredServices[index];
                                    return ServiceCard(
                                      service: service,
                                      onViewDetails: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => ServiceDetailScreen(
                                              serviceId: service.id,
                                            ),
                                          ),
                                        );
                                      },
                                    );
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

  void _openCalendar(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CalendarScreen()),
    );
  }
}
