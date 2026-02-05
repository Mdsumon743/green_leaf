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
    // Sample data for visits
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
          /// ================= Background Images =================
          Column(
            children: [
              /// Top Background
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.visitBackground),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              /// Bottom Background
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.homeBackground),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// ================= Overlay =================
          Column(
            children: [
              Container(
                height: 200.h,
                color: AppColor.primary.withValues(alpha: 0.7),
              ),
              Expanded(
                child: Container(
                  color: Colors.white.withValues(alpha: 0.95),
                ),
              ),
            ],
          ),

          /// ================= Content =================
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ================= Header =================
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      CustomText(
                        text: "Upcoming Visits",
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 80.h),

                /// ================= Visit List =================
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28.r),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: visits.length,
                        itemBuilder: (context, index) {
                          final visit = visits[index];
                          return GestureDetector(
                            onTap: (){
                              context.push('/visitDetails');
                            },
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
          ),
        ],
      ),
    );
  }

  /// ================= Visit Card Widget =================
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
          /// ================= Visit Image =================
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

          /// ================= Visit Details =================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                CustomText(
                  text: title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textBody,
                ),
                SizedBox(height: 4.h),

                /// Date
                CustomText(
                  text: date,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textBody.withValues(alpha: 0.6),
                ),
                SizedBox(height: 8.h),

                /// Assigned Worker Label
                CustomText(
                  text: "Assigned Worker",
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textBody.withValues(alpha: 0.5),
                ),
                SizedBox(height: 2.h),

                /// Worker Name
                CustomText(
                  text: worker,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textBody,
                ),
                SizedBox(height: 8.h),

                /// Reminder or Status
                if (reminder != null && reminder.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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