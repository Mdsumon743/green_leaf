import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../../../../core/global/curve_clipper.dart';

// ─────────────────────────────────────────────────────────────────────────────
// MODEL
// ─────────────────────────────────────────────────────────────────────────────

class RecurringJobDetailsModel {
  final String jobType;
  final String frequency;
  final String nextOccurrence;
  final String stopDate;
  final String startTime;
  final String finishTime;
  final String dayOfWeekInMonth;
  final String jobName;
  final String customerName;
  final String? customerAvatar;
  final String jobDescription;
  final String taskName;
  final String taskDescription;
  final String staffName;
  final String? staffAvatar;

  const RecurringJobDetailsModel({
    required this.jobType,
    required this.frequency,
    required this.nextOccurrence,
    required this.stopDate,
    required this.startTime,
    required this.finishTime,
    required this.dayOfWeekInMonth,
    required this.jobName,
    required this.customerName,
    this.customerAvatar,
    required this.jobDescription,
    required this.taskName,
    required this.taskDescription,
    required this.staffName,
    this.staffAvatar,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// PROVIDER  – accepts the model passed via GoRouter extra
// ─────────────────────────────────────────────────────────────────────────────

final recurringJobDetailsProvider =
Provider.family<RecurringJobDetailsModel, RecurringJobDetailsModel>(
      (ref, model) => model,
);

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class RecurringJobDetailsScreen extends ConsumerWidget {
  final RecurringJobDetailsModel job;

  const RecurringJobDetailsScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(recurringJobDetailsProvider(job));

    return Scaffold(
      body: Stack(
        children: [
          // ── 1. Top Background Image ────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250.h,
            child: Image.asset(
              ImagePath.roleBackground, // Using brand role background
              fit: BoxFit.cover,
            ),
          ),

          // ── 2. Bottom Garden Background ─────────────────────────────
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
                            text: 'Job Details',
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

                // ── 4. Curved White Sheet ─────────────────────────────
                Expanded(
                  child: ClipPath(
                    clipper:            CurveClipper(), // Applying your CurveClipper
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
                          stops: const [0.0, 0.6, 0.85, 1.0],
                        ),
                      ),
                      child: SingleChildScrollView(
                        // Extra top padding (60.h) to clear the curve peak
                        padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 40.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Schedule details rows ─────────────────
                            _DetailRow(
                              label: 'Job Type',
                              value: details.jobType,
                              valueColor: AppColor.primary,
                            ),
                            _Divider(),
                            _DetailRow(
                              label: 'Frequency',
                              value: details.frequency,
                              valueColor: AppColor.primary,
                            ),
                            _Divider(),
                            _DetailRow(
                              label: 'Next Occurrence',
                              value: details.nextOccurrence,
                            ),
                            _Divider(),
                            _DetailRow(
                              label: 'Stop Date',
                              value: details.stopDate,
                            ),
                            _Divider(),
                            _DetailRow(
                              label: 'Start time',
                              value: details.startTime,
                            ),
                            _Divider(),
                            _DetailRow(
                              label: 'Finish Time',
                              value: details.finishTime,
                            ),
                            _Divider(),
                            _DetailRow(
                              label: 'Day of week in month',
                              value: details.dayOfWeekInMonth,
                            ),

                            SizedBox(height: 28.h),

                            // ── Job Information ───────────────────────
                            _SectionHeader('Job Information'),
                            SizedBox(height: 16.h),

                            _DetailRow(
                              label: 'Job Name',
                              value: details.jobName,
                            ),
                            _Divider(),

                            _DetailRow(
                              label: 'Customer name',
                              valueWidget: _AvatarName(
                                name: details.customerName,
                                assetPath: details.customerAvatar,
                              ),
                            ),
                            _Divider(),

                            _DescriptionBlock(
                              label: 'Job Description',
                              text: details.jobDescription,
                            ),

                            SizedBox(height: 28.h),

                            // ── New Task ──────────────────────────────
                            _SectionHeader('New Task'),
                            SizedBox(height: 16.h),

                            _DetailRow(
                              label: 'Task Name',
                              value: details.taskName,
                            ),
                            _Divider(),

                            _DescriptionBlock(
                              label: 'Job Description',
                              text: details.taskDescription,
                            ),

                            _Divider(),

                            _DetailRow(
                              label: 'Staff Name',
                              valueWidget: _AvatarName(
                                name: details.staffName,
                                assetPath: details.staffAvatar,
                              ),
                            ),
                            SizedBox(height: 8.h),
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
}
// ─────────────────────────────────────────────────────────────────────────────
// REUSABLE WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

/// Single label ↔ value row
class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    this.value,
    this.valueWidget,
    this.valueColor,
  }) : assert(value != null || valueWidget != null);

  final String label;
  final String? value;
  final Widget? valueWidget;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label – fixed width so values align
          SizedBox(
            width: 160.w,
            child: CustomText(
              text: label,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.textBody.withValues(alpha: 0.6),
            ),
          ),
          Expanded(
            child: valueWidget ??
                CustomText(
                  text: value ?? '',
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? AppColor.textBody,
                  textAlign: TextAlign.end,
                ),
          ),
        ],
      ),
    );
  }
}

/// Multi-line description block (label on top, text below)
class _DescriptionBlock extends StatelessWidget {
  const _DescriptionBlock({required this.label, required this.text});

  final String label;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 13.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.textBody.withValues(alpha: 0.6),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: text,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.textBody.withValues(alpha: 0.85),
            height: 1.6,
          ),
        ],
      ),
    );
  }
}

/// Avatar + name side by side
class _AvatarName extends StatelessWidget {
  const _AvatarName({required this.name, this.assetPath});

  final String name;
  final String? assetPath;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CircleAvatar(
          radius: 14.r,
          backgroundColor: const Color(0xFFDDE8DD),
          child: ClipOval(
            child: assetPath != null
                ? Image.asset(
              assetPath!,
              width: 28.r,
              height: 28.r,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(
                Icons.person,
                size: 16.r,
                color: AppColor.primary,
              ),
            )
                : Icon(
              Icons.person,
              size: 16.r,
              color: AppColor.primary,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        CustomText(
          text: name,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: AppColor.textBody,
        ),
      ],
    );
  }
}

/// Section title
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: title,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.textBody,
    );
  }
}

/// Thin divider line
class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1.h,
      color: const Color(0xFFE8F0E8),
    );
  }
}