import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';
import 'package:saunders/features/employee_flow/profile/presentation/widget/recurring_job_details_screen.dart';

// ── Dummy model – replace with your real model/BLoC ───────────────────────────
class RecurringJobModel {
  final String serviceName;
  final String address;
  final String customerName;
  final String staffName;
  final String customerAvatar; // asset path
  final String staffAvatar; // asset path

  const RecurringJobModel({
    required this.serviceName,
    required this.address,
    required this.customerName,
    required this.staffName,
    required this.customerAvatar,
    required this.staffAvatar,
  });
}

// ── Screen ─────────────────────────────────────────────────────────────────────

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
      body: Stack(
        children: [
          // ── Full-screen nature background ──────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.homeBackground,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),

          // ── Gradient overlay – dark green top, fading down ─────────────
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xDD1B5E20),
                    Color(0xAA2E7D32),
                    Color(0x551B5E20),
                  ],
                  stops: [0.0, 0.3, 1.0],
                )
              ),
            ),
          ),

          // ── Content ────────────────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ── App Bar ───────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 38.r,
                          height: 38.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.7),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18.sp,
                            ),
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
                      // Invisible spacer to keep title centred
                      SizedBox(width: 38.r),
                    ],
                  ),
                ),

                // ── White rounded sheet ───────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.containerBackground,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                      child: Column(
                        children: [
                          // ── Scrollable list ──────────────────────────
                          Expanded(
                            child: ListView.separated(
                              padding: EdgeInsets.fromLTRB(
                                  16.w, 20.h, 16.w, 20.h),
                              itemCount: _jobs.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 14.h),
                              itemBuilder: (context, index) =>
                                  _RecurringJobCard(job: _jobs[index]),
                            ),
                          ),

                          // ── Bottom CTA ───────────────────────────────
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                20.w, 12.h, 20.w, 30.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F7F3),
                              border: Border(
                                top: BorderSide(
                                  color: const Color(0xFFDDE8DD),
                                  width: 1.h,
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: ElevatedButton(
                                onPressed: () =>
                                    context.push('/addRecurringJob'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: CustomText(
                                  text: 'Add New Recurring Job',
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
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

// ── Job Card ───────────────────────────────────────────────────────────────────

class _RecurringJobCard extends StatelessWidget {
  const _RecurringJobCard({required this.job});

  final RecurringJobModel job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push('/recurringJobDetails', extra: RecurringJobDetailsModel(
          jobType: 'Garden Cleanup',
          frequency: 'Weekly',
          nextOccurrence: '19 March 2026',
          stopDate: '19 December 2026',
          startTime: '09:00 AM',
          finishTime: '01:00 PM',
          dayOfWeekInMonth: 'Second Thursday',
          jobName: 'Garden Maintenance',
          customerName: 'Oliver Leo',
          customerAvatar: ImagePath.user,
          jobDescription: 'Regular garden maintenance service...',
          taskName: 'Garden Maintenance',
          taskDescription: 'Garden maintenance service including lawn mowing...',
          staffName: 'Darrell Steward',
          staffAvatar: ImagePath.user,
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFDDE8DD),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Service name
            CustomText(
              text: job.serviceName,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.textBody,
            ),

            SizedBox(height: 6.h),

            // Address in green
            CustomText(
              text: job.address,
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: AppColor.primary,
            ),

            SizedBox(height: 14.h),

            // Dashed divider
            _DashedDivider(),

            SizedBox(height: 14.h),

            // Customer + Staff row
            Row(
              children: [
                // Customer
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Customer',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textBody.withValues(alpha: 0.55),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _Avatar(assetPath: job.customerAvatar),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: CustomText(
                              text: job.customerName,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textBody,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Staff
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Staff',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColor.textBody.withValues(alpha: 0.55),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _Avatar(assetPath: job.staffAvatar),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: CustomText(
                              text: job.staffName,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.textBody,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Avatar ─────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  const _Avatar({required this.assetPath});

  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16.r,
      backgroundColor: const Color(0xFFDDE8DD),
      child: ClipOval(
        child: Image.asset(
          assetPath,
          width: 32.r,
          height: 32.r,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Icon(
            Icons.person,
            size: 18.r,
            color: AppColor.primary,
          ),
        ),
      ),
    );
  }
}

// ── Dashed Divider ─────────────────────────────────────────────────────────────

class _DashedDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final count =
        (constraints.maxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          children: List.generate(count, (_) {
            return Padding(
              padding: const EdgeInsets.only(right: dashSpace),
              child: Container(
                width: dashWidth,
                height: 1,
                color: const Color(0xFFCCDDCC),
              ),
            );
          }),
        );
      },
    );
  }
}