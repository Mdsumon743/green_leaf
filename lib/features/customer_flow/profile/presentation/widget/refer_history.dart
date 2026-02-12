import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
            ),
          ),

          Column(
            children: [
              // Header
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
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: 50.w),
                    Text(
                      'Referral History',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content area with gradient
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 32.h,
                    left: 20.w,
                    right: 20.w,
                  ),
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
                      stops: [0.0, 0.5, 0.8, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stats Cards
                      SizedBox(
                        height: 150.h,
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

                      SizedBox(height: 32.h),

                      // Your Referrals Title
                      CustomText(
                        text: "Your Referrals",
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textBody,
                      ),

                      SizedBox(height: 16.h),

                      // Referrals List
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.only(bottom: 100.h),
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
            ],
          ),
        ],
      ),
    );
  }
}



