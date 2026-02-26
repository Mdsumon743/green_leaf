

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/features/employee_flow/home/presentation/widget/CustomDivider.dart';

import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../model/service_data_model.dart';
import '../../provider/employee_home_provider.dart';
import '../widget/detail_row_column.dart';
import '../widget/details_row.dart';
import '../widget/photo_row.dart';
import '../widget/status_card.dart';


class ServiceDetailScreen extends ConsumerWidget {
  final String serviceId;
  const ServiceDetailScreen({super.key, required this.serviceId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(employeeHomeProvider);
    final notifier = ref.read(employeeHomeProvider.notifier);

    final service = state.services.firstWhere((s) => s.id == serviceId);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // ── Background ─────────────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 220.h,
              child: Image.asset(
                ImagePath.homeBackground,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 220.h,
              color: Colors.white.withValues(alpha: 0.88),
            ),
          ),

          // ── Content ────────────────────────────────────────────────────────
          SafeArea(
            child: Column(
              children: [
                // ── App Bar ──────────────────────────────────────────────────
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: 20.r, color: AppColor.black),
                      ),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: 'Service Details',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColor.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(Icons.calendar_today_outlined,
                            size: 18.r, color: AppColor.primary),
                      ),
                    ],
                  ),
                ),

                // ── Scrollable body ──────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding:
                    EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ── Quote Info Card ──────────────────────────────────
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CustomText(
                                  text: 'Quote: ${service.quoteNumber}',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.black,
                                ),
                              ),
                              Center(
                                child: CustomText(
                                  text: service.title,
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 14.h),
                              DetailRow(
                                label: 'Total Price',
                                value:
                                '€${service.price.toStringAsFixed(2)}',
                                valueColor: AppColor.primary,
                                valueBold: true,
                              ),
                              CustomDivider(),
                              DetailRow(
                                label: 'Prefer Date',
                                value: service.preferDate,
                              ),
                              CustomDivider(),
                              DetailRowColumn(
                                label: 'Address',
                                value: service.address,
                              ),
                              CustomDivider(),
                              DetailRowColumn(
                                label: 'Job Description',
                                value: service.jobDescription,
                              ),
                              CustomDivider(),
                              DetailRow(
                                label: 'Status',
                                widget: StatusBadge(status: service.status),
                              ),
                              CustomDivider(),

                              // ── Before Photos ───────────────────────────────
                              SizedBox(height: 10.h),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'Before Photo',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        notifier.addBeforePhoto(service.id),
                                    child: Container(
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                        color: AppColor.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                      ),
                                      child: Icon(Icons.add_rounded,
                                          color: AppColor.primary, size: 18.r),
                                    ),
                                  ),
                                ],
                              ),
                              if (service.beforePhotos.isNotEmpty) ...[
                                SizedBox(height: 8.h),
                                PhotoRow(photos: service.beforePhotos),
                              ],

                              SizedBox(height: 14.h),

                              // ── After Photos ────────────────────────────────
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    text: 'After Photo',
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        notifier.addAfterPhoto(service.id),
                                    child: Container(
                                      padding: EdgeInsets.all(6.r),
                                      decoration: BoxDecoration(
                                        color: AppColor.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                      ),
                                      child: Icon(Icons.add_rounded,
                                          color: AppColor.primary, size: 18.r),
                                    ),
                                  ),
                                ],
                              ),
                              if (service.afterPhotos.isNotEmpty) ...[
                                SizedBox(height: 8.h),
                                PhotoRow(photos: service.afterPhotos),
                              ],

                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // ── Completed Button (only for pending) ──────────────
                        if (service.status == ServiceStatus.pending)
                          GestureDetector(
                            onTap: () {
                              notifier.markCompleted(service.id);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 52.h,
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: 'Completed',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(Icons.arrow_forward_ios_rounded,
                                      color: Colors.white, size: 16.r),
                                ],
                              ),
                            ),
                          ),

                        SizedBox(height: 32.h),
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
}







