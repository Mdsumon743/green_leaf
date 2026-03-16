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
        'address' : '123 Greenview St. Springfield, IL',
        'worker': 'Shamim Islam',
        'reminder': 'We\'ll see you soon!',
        'status': 'Pending',
      },
      {
        'image': ImagePath.visitTwo,
        'title': 'Hedge Trimming',
        'date': 'Friday, 16th July, 10:00AM',
        'address' : '123 Greenview St. Springfield, IL',
        'worker': 'Shamim Islam',
        'reminder': '',
        'status': 'Pending',
      },
      {
        'image': ImagePath.visitTwo,
        'title': 'Hedge Trimming',
        'date': 'Friday, 16th July, 10:00AM',
        'address' : '123 Greenview St. Springfield, IL',
        'worker': 'Shamim Islam',
        'reminder': '',
        'status': 'Pending ',
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
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF3FFF0), // The light background color from your image
                    ),
                    child: Column(
                      children: [
                        // 1. Add the FilterWidget here, inside the clipped area
                        // Padding top (e.g., 50.h to 60.h) is CRITICAL to push it below the curve dip
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 10.h),
                          child: FilterWidget(),
                        ),

                        // 2. The List of Cards
                        Expanded(
                          child: ListView.builder(
                            // Remove top padding here since FilterWidget handles it
                            padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 40.h),
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

