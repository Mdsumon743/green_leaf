

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/features/employee_flow/home/presentation/widget/CustomDivider.dart';

import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/curve_clipper.dart';
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
            top: 0,
            left: 0,
            right: 0,
            height: 300.h, // Fixed height for the top section
            child: Image.asset(
              ImagePath.notificationTopBG,
              fit: BoxFit.cover,
            ),
          ),

          /// 2. BOTTOM GARDEN BACKGROUND
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.homeBackground,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          /// 3. WHITE OVERLAY FOR GARDEN
          // This ensures the bottom garden is subtle and doesn't distract from text
          Align(
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
                    ],
                  ),
                ),

                // ── CurveClipper applied here ────────────────────────────────
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
                            AppColor.containerBackground.withValues(alpha: 0.75),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.65, 0.8, 1.0],
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Quote Info Card ──────────────────────────────
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.all(10.r),
                                    decoration: BoxDecoration(
                                      color: AppColor.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: Image.asset(IconPath.appointment02,height: 20.h,width: 20.w,)
                                  ),
                                ),
                                SizedBox(height: 8.h,),
                                Center(
                                  child: CustomText(
                                    text: 'Quote: ${service.quoteNumber}',
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.black,
                                  ),
                                ),
                                SizedBox(height: 4.h,),
                                Center(
                                  child: CustomText(
                                    text: service.title,
                                    fontSize: 16.sp,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                SizedBox(height: 24.h),
                                DetailRow(
                                  label: 'Total Price',
                                  value: '€${service.price.toStringAsFixed(2)}',
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

                                // ── Photos Sections ────────────────────────
                                SizedBox(height: 10.h),
                                _buildPhotoHeader(
                                  title: 'Before Photo',
                                  onAdd: () => notifier.addBeforePhoto(service.id),
                                ),
                                if (service.beforePhotos.isNotEmpty) ...[
                                  SizedBox(height: 8.h),
                                  PhotoRow(photos: service.beforePhotos),
                                ],

                                SizedBox(height: 14.h),

                                _buildPhotoHeader(
                                  title: 'After Photo',
                                  onAdd: () => notifier.addAfterPhoto(service.id),
                                ),
                                if (service.afterPhotos.isNotEmpty) ...[
                                  SizedBox(height: 8.h),
                                  PhotoRow(photos: service.afterPhotos),
                                ],

                                SizedBox(height: 24.h),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // ── Completed Button ─────────────────────────────
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
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF8CC40F),
                                        Color(0xFF126A19)
                                      ]
                                    ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Extracted helper for photo headers to keep the code clean
  Widget _buildPhotoHeader({required String title, required VoidCallback onAdd}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: title,
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
          color: AppColor.black,
        ),
        GestureDetector(
          onTap: onAdd,
          child: Image.asset(IconPath.imageAdd,height: 32.h,width: 32.w,),
        ),
      ],
    );
  }
}
