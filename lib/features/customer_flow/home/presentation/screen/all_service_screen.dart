

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

// ── Model ──────────────────────────────────────────────────────────────────────

class ServiceModel {
  final int id;
  final String name;
  final String price;
  final String description;

  const ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });
}

// ── Screen ─────────────────────────────────────────────────────────────────────

class AllServicesScreen extends StatelessWidget {
  const AllServicesScreen({super.key});

  // Replace with real data / BLoC / provider as needed
  static const List<ServiceModel> _services = [
    ServiceModel(
      id: 1,
      name: 'Garden Maintenance',
      price: '€ 120.00',
      description:
      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
    ),
    ServiceModel(
      id: 2,
      name: 'Garden Maintenance',
      price: '€ 120.00',
      description:
      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
    ),
    ServiceModel(
      id: 3,
      name: 'Garden Maintenance',
      price: '€ 120.00',
      description:
      'Garden maintenance service including lawn mowing, hedge trimming, weed removal, and general garden cleanup.',
    ),
    ServiceModel(
      id: 4,
      name: 'Lawn Mowing',
      price: '€ 80.00',
      description:
      'Professional lawn mowing service with edge trimming and grass clipping cleanup included.',
    ),
    ServiceModel(
      id: 5,
      name: 'Hedge Trimming',
      price: '€ 95.00',
      description:
      'Expert hedge and shrub trimming to keep your garden neat and well maintained year round.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: Column(
        children: [
          // ── App bar (stays green) ──────────────────────────────────────
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
              child: Row(
                children: [
                  // Back button
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
                  SizedBox(width: 14.w),
                  CustomText(
                    text: 'All Services',
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),

          // ── White sheet ───────────────────────────────────────────────
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
                child: ListView.separated(
                  padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
                  itemCount: _services.length,
                  separatorBuilder: (_, __) => SizedBox(height: 14.h),
                  itemBuilder: (context, index) {
                    return _ServiceCard(service: _services[index]);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Service Card ───────────────────────────────────────────────────────────────

class _ServiceCard extends StatelessWidget {
  const _ServiceCard({required this.service});

  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.containerBorder,
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
      padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Price row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CustomText(
                  text: service.name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textBody,
                ),
              ),
              SizedBox(width: 8.w),
              CustomText(
                text: service.price,
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.textBody,
              ),
            ],
          ),

          SizedBox(height: 8.h),

          // Description
          CustomText(
            text: service.description,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.textBody.withValues(alpha: 0.6),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),

          SizedBox(height: 14.h),

          // View Details button
          SizedBox(
            width: double.infinity,
            height: 46.h,
            child: ElevatedButton(
              onPressed: () => context.push(
                '/serviceDetail',
                extra: service,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'View Details',
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 14.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}