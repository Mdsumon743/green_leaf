import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';
import 'package:saunders/features/employee_flow/profile/presentation/widget/recurring_job_details_screen.dart';

import '../../../../../core/global/custom_button.dart';

// ── Model ──────────────────────────────────────────────────────────────────
class RecurringJobModel {
  final String serviceName;
  final String address;
  final String customerName;
  final String staffName;
  final String customerAvatar;
  final String staffAvatar;

  const RecurringJobModel({
    required this.serviceName,
    required this.address,
    required this.customerName,
    required this.staffName,
    required this.customerAvatar,
    required this.staffAvatar,
  });
}

class RecurringJobScreen extends StatelessWidget {
  const RecurringJobScreen({super.key});

  static final List<RecurringJobModel> _jobs = List.generate(
    3,
        (_) => const RecurringJobModel(
      serviceName: 'Garden Maintenance',
      address: '8502 Preston Rd. Inglewood, Maine 98380',
      customerName: 'Oliver Leo',
      staffName: 'Darrell Steward',
      customerAvatar: ImagePath.user,
      staffAvatar: ImagePath.user,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // ── 1. Top Background Image ────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250.h,
            child: Image.asset(
              ImagePath.roleBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ── 2. Bottom Background Image (Garden) ────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              ImagePath.homeBackground,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // ── 3. Content ──────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ── App Bar ───────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: 'Recurring Jobs',
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 38.r),
                    ],
                  ),
                ),

                // ── 4. Curved White Sheet Container ───────────────────
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
                            AppColor.containerBackground.withOpacity(0.85),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6, 0.85, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 20.h),
                              itemCount: _jobs.length,
                              separatorBuilder: (_, __) => SizedBox(height: 14.h),
                              itemBuilder: (context, index) => _RecurringJobCard(job: _jobs[index]),
                            ),
                          ),

                          // ── Bottom CTA ───────────────────────────────
                          // ── Bottom CTA ───────────────────────────────
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 40.h),
                            child: CustomButton(
                              onPressed: () => context.push('/addRecurringJob'),
                              text: 'Add New Recurring Job',
                              borderWidth: 2,
                              borderGradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF348317),
                                    Color(0xFF9DC167),
                                  ]
                              ),
                              borderRadius: 8.r,
                              backgroundGradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF8CC40F),
                                  Color(0xFF126A19),
                                ]
                              ),
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
}

// ── FIXED JOB CARD ───────────────────────────────────────────────────────────

class _RecurringJobCard extends StatelessWidget {
  const _RecurringJobCard({required this.job});
  final RecurringJobModel job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // FIXED: Mapping RecurringJobModel to RecurringJobDetailsModel to resolve the error
        context.push(
          '/recurringJobDetails',
          extra: RecurringJobDetailsModel(
            jobType: 'Garden Maintenance',
            frequency: 'Weekly',
            nextOccurrence: '19 March 2026',
            stopDate: '19 December 2026',
            startTime: '09:00 AM',
            finishTime: '01:00 PM',
            dayOfWeekInMonth: 'Second Thursday',
            jobName: job.serviceName,
            customerName: job.customerName,
            customerAvatar: job.customerAvatar,
            jobDescription: 'Regular garden maintenance service including lawn mowing and pruning.',
            taskName: 'Garden Maintenance',
            taskDescription: 'Service includes full garden cleanup.',
            staffName: job.staffName,
            staffAvatar: job.staffAvatar,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: job.serviceName,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.black,
            ),
            SizedBox(height: 4.h),
            CustomText(
              text: job.address,
              fontSize: 13.sp,
              color: AppColor.primary,
              fontWeight: FontWeight.w400,
            ),
            SizedBox(height: 12.h),
            const Divider(color: Color(0xFFE8F0E8)),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: _UserMiniProfile(label: 'Customer', name: job.customerName, avatar: job.customerAvatar)),
                Expanded(child: _UserMiniProfile(label: 'Staff', name: job.staffName, avatar: job.staffAvatar)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _UserMiniProfile extends StatelessWidget {
  final String label, name, avatar;
  const _UserMiniProfile({required this.label, required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label, fontSize: 11.sp, color: Colors.grey),
        SizedBox(height: 6.h),
        Row(
          children: [
            CircleAvatar(radius: 14.r, backgroundImage: AssetImage(avatar)),
            SizedBox(width: 8.w),
            Flexible(
              child: CustomText(text: name, fontSize: 13.sp, fontWeight: FontWeight.w600, color: AppColor.black),
            ),
          ],
        ),
      ],
    );
  }
}