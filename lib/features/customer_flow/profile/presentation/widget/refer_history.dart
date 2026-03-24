import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/global/curve_clipper.dart'; // Ensure this is imported
import 'package:saunders/features/customer_flow/profile/presentation/widget/referrl_card.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/stat_card.dart';
import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import '../../provider/referal_provider.dart';

class ReferHistory extends ConsumerWidget {
  const ReferHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(referralStatsProvider);
    final referrals = ref.watch(referralsListProvider);

    return Scaffold(
      body: Stack(
        children: [
          // ── Background image ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground, // Consistent background
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // ── Header (Centered Title) ──────────────────────────────
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    const Spacer(),
                    CustomText(
                      text: 'Referral History',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w), // Balance for back icon
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // ── Curved Content Area ──────────────────────────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(), // Custom Clipper applied here
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
                        stops: const [0.0, 0.7, 0.8 , 1.0],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60.h), // Offset for curve peak

                        // Stats Cards Row
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: SizedBox(
                            height: 140.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: stats.length,
                              separatorBuilder: (context, index) => SizedBox(width: 16.w),
                              itemBuilder: (context, index) {
                                final stat = stats[index];
                                return StatCard(
                                  title: stat.title,
                                  value: stat.value,
                                  icon: stat.icon,
                                );
                              },
                            ),
                          ),
                        ),

                        SizedBox(height: 32.h),

                        // Your Referrals Title
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: CustomText(
                            text: "Your Referrals",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColor.textBody,
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Referrals List
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                              bottom: 50.h,
                            ),
                            itemCount: referrals.length,
                            separatorBuilder: (context, index) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final referral = referrals[index];
                              return ReferralCard(
                                name: referral.name,
                                date: referral.date,
                                amount: referral.amount,
                                status: referral.status,
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