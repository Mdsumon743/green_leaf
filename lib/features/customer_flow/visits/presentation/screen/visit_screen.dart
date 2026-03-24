import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';
import 'package:saunders/features/customer_flow/visits/presentation/widget/visite_card.dart';

import '../widget/filter_widget.dart';

class VisitScreen extends StatelessWidget {
  const VisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> visits = [
      {
        'image': ImagePath.visitOne,
        'title': 'Garden Maintenance',
        'date': 'Friday, 16th July, 10:00AM',
        'address': '123 Greenview St. Springfield, IL',
        'worker': 'Shamim Islam',
        'reminder': 'We\'ll see you soon!',
        'status': 'Pending',
      },
      {
        'image': ImagePath.visitTwo,
        'title': 'Hedge Trimming',
        'date': 'Friday, 16th July, 10:00AM',
        'address': '123 Greenview St. Springfield, IL',
        'worker': 'Shamim Islam',
        'reminder': '',
        'status': 'Pending',
      },
      {
        'image': ImagePath.visitTwo,
        'title': 'Hedge Trimming',
        'date': 'Friday, 16th July, 10:00AM',
        'address': '123 Greenview St. Springfield, IL',
        'worker': 'Shamim Islam',
        'reminder': '',
        'status': 'Pending ',
      },
    ];

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 1. TOP BACKGROUND IMAGE
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImagePath.roleBackground, // Unified background
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 2. BOTTOM BACKGROUND IMAGE (Garden)
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.myQuotesDetailsBottumBG,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          /// 3. MAIN UI
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              /// AppBar (Centered Title)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 34.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                      ),
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Upcoming Visits',
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    SizedBox(width: 34.w), // Balance for back button
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              /// 4. Curved Content Area
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
                        /// Filter Widget (Pushed below the curve peak)
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 10.h),
                          child: FilterWidget(),
                        ),

                        /// The List of Cards
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 100.h),
                            itemCount: visits.length,
                            itemBuilder: (context, index) {
                              final visit = visits[index];
                              return Padding(
                                padding: EdgeInsets.only(bottom: 16.h),
                                child: VisiteCard(
                                  image: visit['image'],
                                  title: visit['title'],
                                  address: visit['address'],
                                  date: visit['date'],
                                  worker: visit['worker'],
                                  reminder: visit['reminder'],
                                  status: visit['status'],
                                ),
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
        ],
      ),
    );
  }
}