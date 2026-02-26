import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Full-screen subtle background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.12,
              child: Image.asset(
                ImagePath.quoteBackground,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // App bar - not wrapped, stays on top
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          size: 22.r,
                          color: AppColor.primary,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 12.w),
                      CustomText(
                        text: 'Trusted Local Trades',
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111111),
                      ),
                    ],
                  ),
                ),

                // Only the content list is wrapped in rounded container
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28.r),
                      ),
                    ),
                    child: state.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
                      itemCount: state.trades.length,
                      separatorBuilder: (_, __) => SizedBox(height: 20.h),
                      itemBuilder: (context, index) {
                        return _TradeCard(trade: state.trades[index]);
                      },
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

// ─── Trade Card (image on top) ────────────────────────────────────────────────

class _TradeCard extends StatelessWidget {
  final TradeModel trade;

  const _TradeCard({required this.trade});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h), // small breathing room
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image on top
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            child: Image.asset(
              trade.imagePath,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: double.infinity,
                  height: 180.h,
                  color: AppColor.primary.withValues(alpha: 0.08),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    color: AppColor.primary.withValues(alpha: 0.5),
                    size: 48.r,
                  ),
                );
              },
            ),
          ),

          // Text content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: trade.name,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1A1A1A),
                ),
                SizedBox(height: 8.h),
                CustomText(
                  text: trade.description,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF666666),
                  height: 1.38,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}