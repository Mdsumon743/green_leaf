import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';


// ─── Provider ─────────────────────────────────────────────────────────────────

final selectedPlanProvider = StateProvider<String?>((ref) => null);

// ─── Models ───────────────────────────────────────────────────────────────────

class PlanModel {
  final String name;
  final String price;
  final String description;
  final String imagePath;
  final String? secondImagePath;
  final List<String> features;
  final String visitsLabel;
  final Color accentColor;
  final Color headerColor;
  final bool isCenter;

  const PlanModel({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.secondImagePath,
    required this.features,
    required this.visitsLabel,
    this.accentColor = const Color(0xFF2E6B3E),
    this.headerColor = const Color(0xFF2E6B3E),
    this.isCenter = false,
  });
}

class ScheduleModel {
  final String month;
  final int visits;
  const ScheduleModel({required this.month, required this.visits});
}

// ─── Subscription Screen ──────────────────────────────────────────────────────

class SubscriptionScreen extends ConsumerWidget {
  const SubscriptionScreen({super.key});

  static final _plans = [
    PlanModel(
      name: 'Ultimate\nProgram',
      price: '£84',
      description:
      'Our most comprehensive package for lush, vibrant lawns.\n\nIncludes full seasonal treatment plan.',
      imagePath: ImagePath.subscriptionOne,
      secondImagePath: ImagePath.subscriptionTwo,
      features: const [
        'Spring Ready Treatment',
        'Summer Ready Treatment',
        'Oasis',
        'Seasonal Treatment (Spring, Summer, Autumn/Winter Long)',
        'Lawn Aeration, Scarification & Overseeding',
        'Pest & Disease Management',
        '*8–12 visits a year',
      ],
      visitsLabel: '8–12 visits a year',
      accentColor: const Color(0xFFB8860B),
      headerColor: const Color(0xFF8B6914),
    ),
    const PlanModel(
      name: 'Standard\nPackage',
      price: '£32',
      description:
      'Balanced package for a healthy and green lawn. Includes core treatments to maintain your garden.',
      imagePath: ImagePath.subscriptionTwo,
      secondImagePath: ImagePath.subscriptionThree,
      features: [
        'Spring Ready Treatment',
        'Summer Ready Treatment',
        'Oasis',
        'NutraGreen Summer Treatment',
        'NutraGreen Autumn/Winter Treatment',
        'Lawn Aeration',
        'Lawn Scarification',
        '*5–6 visits a year',
      ],
      visitsLabel: '5–6 visits a year',
      accentColor: Color(0xFF1A6BB0),
      headerColor: Color(0xFF1A6BB0),
      isCenter: true,
    ),
    const PlanModel(
      name: 'Basic\nPackage',
      price: '£14',
      description:
      'Perfect for essential care to keep your lawn green. Basic treatments to maintain your garden.',
      imagePath: ImagePath.subscriptionThree,
      secondImagePath: ImagePath.subscriptionOne,
      features: [
        'Spring Ready Treatment',
        'Summer Ready Treatment',
        'Oasis',
        'NutraGreen Summer Treatment & NutraGreen Autumn/Winter Treatment',
        '4–5 visits a year',
      ],
      visitsLabel: '4–5 visits a year',
      accentColor: Color(0xFF2E6B3E),
      headerColor: Color(0xFF2E6B3E),
    ),
  ];

  static const _schedule = [
    ScheduleModel(month: 'February', visits: 1),
    ScheduleModel(month: 'March', visits: 2),
    ScheduleModel(month: 'April', visits: 2),
    ScheduleModel(month: 'May', visits: 2),
    ScheduleModel(month: 'June', visits: 2),
    ScheduleModel(month: 'July', visits: 2),
    ScheduleModel(month: 'August', visits: 2),
    ScheduleModel(month: 'September', visits: 2),
    ScheduleModel(month: 'October', visits: 2),
    ScheduleModel(month: 'November', visits: 1),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlan = ref.watch(selectedPlanProvider);

    return Scaffold(
      body: Stack(
        children: [
          // ── Full-screen green garden background ───────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),
          // Dark green overlay
          Positioned.fill(
            child: Container(
              color: const Color(0xFF1B4A28).withValues(alpha: 0.65),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Top bar ───────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.maybePop(context),
                          child: Container(
                            width: 36.r,
                            height: 36.r,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 16.r,
                            ),
                          ),
                        ),
                      ),
                      CustomText(
                        text: 'Subscription Plans',
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),

                // ── Saunders Header Logo ──────────────────────────────────
                Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(IconPath.greenLogo, height: 32.h),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Saunders',
                            font: AppFont.impact,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: 'Gardening Services',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // ── Scrollable body ───────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 40.h),
                    child: Column(
                      children: [
                        // ── 3-Column Plans Row ────────────────────────────
                        _ThreeColumnPlans(
                          plans: _plans,
                          selectedPlan: selectedPlan,
                          onSelect: (name) => ref
                              .read(selectedPlanProvider.notifier)
                              .state = name,
                        ),

                        SizedBox(height: 16.h),

                        // ── Garden Maintenance Card ───────────────────────
                        _GardenMaintenanceCard(schedule: _schedule),

                        SizedBox(height: 20.h),

                        /*// ── CTA Button ────────────────────────────────────
                        if (selectedPlan != null)
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E6B3E),
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                elevation: 4,
                              ),
                              child: CustomText(
                                text: 'Get Started with $selectedPlan',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),*/
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

// ─── Three Column Plans ───────────────────────────────────────────────────────

class _ThreeColumnPlans extends StatelessWidget {
  final List<PlanModel> plans;
  final String? selectedPlan;
  final void Function(String) onSelect;

  const _ThreeColumnPlans({
    required this.plans,
    required this.selectedPlan,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List.generate(plans.length, (i) {
          final plan = plans[i];
          final isSelected = selectedPlan == plan.name;
          final isCenter = plan.isCenter;

          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                left: i == 0 ? 0 : 3.w,
                right: i == plans.length - 1 ? 0 : 3.w,
                top: isCenter ? 0 : 12.h,
                bottom: isCenter ? 12.h : 0,
              ),
              child: GestureDetector(
                onTap: () => onSelect(plan.name),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    border: isSelected
                        ? Border.all(color: plan.accentColor, width: 2.5)
                        : Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(isCenter ? 0.25 : 0.15),
                        blurRadius: isCenter ? 20 : 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      _PlanHeader(plan: plan, isSelected: isSelected),

                      // Description
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 8.h, 10.w, 0),
                        child: Text(
                          plan.description,
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            color: const Color(0xFF555555),
                            height: 1.4,
                          ),
                        ),
                      ),

                      // Top image circle
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Container(
                            width: 80.r,
                            height: 80.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: plan.accentColor.withValues(alpha: 0.5),
                                width: 2.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: plan.accentColor.withValues(alpha: 0.15),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                plan.imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  color: plan.accentColor.withValues(alpha: 0.1),
                                  child: Icon(
                                    Icons.eco_rounded,
                                    color: plan.accentColor.withValues(alpha: 0.4),
                                    size: 28.r,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // Feature list
                      Padding(
                        padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 8.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: plan.features.map((f) {
                            final isStar = f.startsWith('*');
                            final text = isStar ? f.substring(1) : f;
                            return Padding(
                              padding: EdgeInsets.only(bottom: 5.h),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 3.h),
                                    child: Icon(
                                      isStar
                                          ? Icons.info_outline_rounded
                                          : Icons.check_circle_rounded,
                                      size: 10.r,
                                      color: plan.accentColor,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                      text,
                                      style: TextStyle(
                                        fontSize: 8.5.sp,
                                        color: const Color(0xFF444444),
                                        fontStyle: isStar
                                            ? FontStyle.italic
                                            : FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const Spacer(),

                      // Bottom image circle
                      if (plan.secondImagePath != null)
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 10.h),
                            child: Container(
                              width: 70.r,
                              height: 70.r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: plan.accentColor.withValues(alpha: 0.4),
                                  width: 2,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  plan.secondImagePath!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => Container(
                                    color: plan.accentColor.withValues(alpha: 0.08),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                      // Contact / location footer
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 8.w),
                        decoration: BoxDecoration(
                          color: plan.accentColor.withOpacity(0.06),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(16.r),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.phone_rounded,
                                    size: 9.r, color: plan.accentColor),
                                SizedBox(width: 3.w),
                                Text(
                                  '07852 428438',
                                  style: TextStyle(
                                    fontSize: 7.5.sp,
                                    fontWeight: FontWeight.w600,
                                    color: plan.accentColor,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(Icons.location_on_rounded,
                                    size: 9.r, color: plan.accentColor),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Text(
                                    'Milton Keynes & Surroundings',
                                    style: TextStyle(
                                      fontSize: 7.sp,
                                      color: const Color(0xFF666666),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─── Plan Header ─────────────────────────────────────────────────────────────

class _PlanHeader extends StatelessWidget {
  final PlanModel plan;
  final bool isSelected;

  const _PlanHeader({required this.plan, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(10.w, 12.h, 10.w, 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            plan.headerColor,
            plan.headerColor.withOpacity(0.75),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(15.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  plan.name,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.2,
                  ),
                ),
              ),
              Icon(Icons.eco_rounded, color: Colors.white70, size: 18.r),
            ],
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  plan.price,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '/month',
                  style: TextStyle(
                    fontSize: 8.sp,
                    color: Colors.white70,
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

// ─── Garden Maintenance Card ──────────────────────────────────────────────────

class _GardenMaintenanceCard extends StatelessWidget {
  final List<ScheduleModel> schedule;

  const _GardenMaintenanceCard({required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Green header with background image ──────────────────────
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Stack(
              children: [
                Image.asset(
                  ImagePath.quoteBackground,
                  width: double.infinity,
                  height: 120.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 120.h,
                    color: const Color(0xFF2E6B3E),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 120.h,
                  color: const Color(0xFF1B4A28).withValues(alpha: 0.7),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFB8860B),
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'Year-Round Garden Care',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Garden Maintenance Package',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.1,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Keep your garden looking its best in every season.',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Left: features ──────────────────────────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'This package includes:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      _featureBullet('Strimming and edging.'),
                      _featureBullet('Lawn mowing & precision cutting.'),
                      _featureBullet('Hedge trimming and shrub pruning.'),
                      _featureBullet('Weeding and general tidy up.'),
                    ],
                  ),
                ),

                SizedBox(width: 12.w),

                // ── Right: schedule table ────────────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF1B4A28),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      children: [
                        // Table header
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2E6B3E),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12.r)),
                          ),
                          child: Column(
                            children: [
                              Text(
                                'Scheduled Visits',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '18 visits per year',
                                style: TextStyle(
                                  fontSize: 9.sp,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Table rows
                        ...schedule.map(
                              (s) => _ScheduleTableRow(item: s),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Contact footer ───────────────────────────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2E6B3E),
              borderRadius:
              BorderRadius.vertical(bottom: Radius.circular(20.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Icon(Icons.phone_rounded,
                        size: 14.r, color: Colors.white),
                    SizedBox(width: 6.w),
                    Text(
                      '07852 428438',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.email_rounded,
                        size: 14.r, color: Colors.white),
                    SizedBox(width: 6.w),
                    Text(
                      'admin@saundersgardening.co.uk',
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _featureBullet(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 3.h),
            child: Icon(
              Icons.check_box_rounded,
              size: 12.r,
              color: const Color(0xFF2E6B3E),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 10.sp,
                color: const Color(0xFF333333),
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Schedule Table Row ───────────────────────────────────────────────────────

class _ScheduleTableRow extends StatelessWidget {
  final ScheduleModel item;

  const _ScheduleTableRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.08),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.month,
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            '${item.visits} ${item.visits == 1 ? 'visit' : 'visits'}',
            style: TextStyle(
              fontSize: 9.5.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}