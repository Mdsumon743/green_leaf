import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> visits = [
      {
        'image': ImagePath.visitOne,
        'title': 'Garden Maintenance',
        'date': 'Friday, 16th July, 10:00AM',
        'worker': 'Shamim Islam',
        'reminder': 'We\'ll see you soon!',
        'status': '',
      },
      {
        'image': ImagePath.visitTwo,
        'title': 'Hedge Trimming',
        'date': 'Friday, 16th July, 10:00AM',
        'worker': 'Shamim Islam',
        'reminder': '',
        'status': 'Appointment Confirmed',
      },
      {
        'image': ImagePath.visitTwo,
        'title': 'Hedge Trimming',
        'date': 'Friday, 16th July, 10:00AM',
        'worker': 'Shamim Islam',
        'reminder': '',
        'status': '',
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // ── Full-screen background image ───────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ── Main column ────────────────────────────────────────────────
          Column(
            children: [
              // ── Header ─────────────────────────────────────────────────
              Container(
                padding: EdgeInsets.only(
                  top: 50.h,
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 70.w),
                    CustomText(
                      text: 'Upcoming Visits',
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),

              // ── White gradient sheet ────────────────────────────────────
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withValues(alpha: 0.95),
                        Colors.white.withValues(alpha: 0.7),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 0.8, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 40.h),
                      itemCount: visits.length,
                      itemBuilder: (context, index) {
                        final visit = visits[index];
                        return GestureDetector(
                          onTap: () => context.push('/visitDetails'),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 16.h),
                            child: _visitCard(
                              image: visit['image'],
                              title: visit['title'],
                              date: visit['date'],
                              worker: visit['worker'],
                              reminder: visit['reminder'],
                              status: visit['status'],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _visitCard({
    required String image,
    required String title,
    required String date,
    required String worker,
    String? reminder,
    String? status,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.containerBorder,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Visit Image ───────────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              image,
              width: 80.w,
              height: 130.h,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 12.w),

          // ── Visit Details ─────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textBody,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  text: date,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textBody.withValues(alpha: 0.6),
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: "Assigned Worker",
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textBody.withValues(alpha: 0.5),
                ),
                SizedBox(height: 2.h),
                CustomText(
                  text: worker,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textBody,
                ),
                SizedBox(height: 8.h),
                if (reminder != null && reminder.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: CustomText(
                      text: reminder,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBody,
                    ),
                  ),
                if (status != null && status.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: CustomText(
                      text: status,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.textBody,
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