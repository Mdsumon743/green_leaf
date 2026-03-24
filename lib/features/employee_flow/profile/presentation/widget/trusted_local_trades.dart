import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../../../../core/global/curve_clipper.dart';

// ─── Model ────────────────────────────────────────────────────────────────────

class TradeModel {
  final String id;
  final String name;
  final String description;
  final String imagePath;

  const TradeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

// ─── State & Notifier ─────────────────────────────────────────────────────────

class TrustedTradesState {
  final List<TradeModel> trades;
  final bool isLoading;

  const TrustedTradesState({
    this.trades = const [],
    this.isLoading = false,
  });

  TrustedTradesState copyWith({
    List<TradeModel>? trades,
    bool? isLoading,
  }) {
    return TrustedTradesState(
      trades: trades ?? this.trades,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class TrustedTradesNotifier extends StateNotifier<TrustedTradesState> {
  TrustedTradesNotifier() : super(const TrustedTradesState()) {
    _loadTrades();
  }

  void _loadTrades() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 800));
    state = state.copyWith(
      isLoading: false,
      trades: _mockTrades(),
    );
  }

  static List<TradeModel> _mockTrades() => [
    TradeModel(
      id: '1',
      name: 'Green Garden Care',
      description:
      'Local experts in regular garden maintenance, lawn care, planting & year-round garden health for homes & small businesses.',
      imagePath: ImagePath.localOne,
    ),
    TradeModel(
      id: '2',
      name: 'Urban Leaf Gardening',
      description:
      'Specialized balcony, rooftop & vertical gardening solutions — perfect for apartment living and small urban spaces.',
      imagePath: ImagePath.localTwo,
    ),
    TradeModel(
      id: '3',
      name: 'Fresh Lawn Services',
      description:
      'Professional lawn mowing, edging, grass trimming and outdoor area cleaning for residential & commercial properties.',
      imagePath: ImagePath.localThree,
    ),
    TradeModel(
      id: '4',
      name: 'SafeCut Pro',
      description:
      'Trusted tree trimming, shrub shaping, branch removal and complete garden tidy-up services — safe & organized spaces guaranteed.',
      imagePath: ImagePath.localFour,
    ),
  ];
}

final trustedTradesProvider = StateNotifierProvider<TrustedTradesNotifier, TrustedTradesState>(
      (ref) => TrustedTradesNotifier(),
);

// ─── Screen ───────────────────────────────────────────────────────────────────
class TrustedLocalTrades extends ConsumerWidget {
  const TrustedLocalTrades({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(trustedTradesProvider);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Stack(
        children: [
          // ── 1. Top Background Image (Role BG) ──────────────────────
          Positioned(
            top: 0, left: 0, right: 0, height: 250.h,
            child: Image.asset(
              ImagePath.roleBackground,
              fit: BoxFit.cover,
            ),
          ),

          // ── 2. Bottom Background Image (Garden) ────────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Image.asset(
              ImagePath.homeBackground,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ── App Bar ─────────────────────────────────────────────
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
                              color: Colors.white.withOpacity(0.7),
                              width: 1.5,
                            ),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: 'Trusted Local Trades',
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 38.r), // Spacer for centering
                    ],
                  ),
                ),

                // ── 3. Curved Sheet Container ─────────────────────────
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
                            AppColor.containerBackground.withOpacity(0.85),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6, 0.85, 1.0],
                        ),
                      ),
                      child: state.isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                        // Added 60.h top padding to clear the curve peak
                        padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 40.h),
                        itemCount: state.trades.length,
                        separatorBuilder: (_, __) => SizedBox(height: 20.h),
                        itemBuilder: (context, index) {
                          return _TradeCard(trade: state.trades[index]);
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
}

// ── Trade Card (Updated with standard white background) ──────────────────────

class _TradeCard extends StatelessWidget {
  final TradeModel trade;
  const _TradeCard({required this.trade});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Image.asset(
              trade.imagePath,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: trade.name,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  text: trade.description,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textBody.withOpacity(0.7),
                  height: 1.4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}