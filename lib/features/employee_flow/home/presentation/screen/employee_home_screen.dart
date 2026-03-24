import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/global/curve_clipper.dart';
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
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 1. TOP BACKGROUND IMAGE
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImagePath.roleBackground,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 2. BOTTOM BACKGROUND IMAGE (Garden)
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.homeBackground,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          /// 3. MAIN UI
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Row(
                        children: [
                          _buildHeaderIcon(
                            icon: Icons.calendar_month_rounded,
                            onTap: () => _openCalendar(context),
                          ),
                          SizedBox(width: 10.w),
                          _buildHeaderIcon(
                            icon: Icons.notifications_none_rounded,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Curved White Sheet ──────────────────────────────────────
                Expanded(
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.containerBackground,
                            AppColor.containerBackground,
                            AppColor.containerBackground.withValues(alpha: 0.8),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.65, 0.8, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          // ── TAB DESIGN MATCHING PICTURE ───────────────────
                          Padding(
                            padding: EdgeInsets.only(top: 50.h),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                // Full width bottom border (the light grey line)
                                Container(
                                  height: 1.5.h,
                                  width: MediaQuery.of(context).size.width -40.w,
                                  color: Colors.black.withValues(alpha: 0.05),
                                ),
                                Row(
                                  children: List.generate(_tabs.length, (i) {
                                    final active = state.selectedTab == i;
                                    return Expanded(
                                      child: GestureDetector(
                                        onTap: () => notifier.setTab(i),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: 12.h),
                                              child: CustomText(
                                                text: _tabs[i],
                                                fontSize: 15.sp,
                                                fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                                                color: active ? AppColor.primary : const Color(0xFF4B5563),
                                              ),
                                            ),
                                            // The active underline indicator
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 250),
                                                height: 2.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: active ? AppColor.primary : Colors.transparent,
                                                  borderRadius: BorderRadius.circular(2.r),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),

                          // Cards List
                          Expanded(
                            child: state.filteredServices.isEmpty
                                ? Center(
                              child: CustomText(
                                text: 'No ${_tabs[state.selectedTab]} services',
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            )
                                : ListView.separated(
                              padding: EdgeInsets.fromLTRB(16.w, 15.h, 16.w, 100.h),
                              itemCount: state.filteredServices.length,
                              separatorBuilder: (_, __) => SizedBox(height: 14.h),
                              itemBuilder: (context, index) {
                                final service = state.filteredServices[index];
                                return ServiceCard(
                                  service: service,
                                  onViewDetails: () {
                                    context.push("/serviceDetailScreen/${service.id}");
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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

  Widget _buildHeaderIcon({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.r,
        height: 40.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF126A19),
          border: Border.all(color: const Color(0xFF188220), width: 1),
        ),
        child: Icon(icon, color: Colors.white, size: 20.sp),
      ),
    );
  }

  void _openCalendar(BuildContext context) {
    context.push("/calenderScreen");
  }
}