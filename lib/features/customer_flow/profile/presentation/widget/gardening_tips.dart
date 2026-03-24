import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

// ──────────────────────────────────────────────────────────────
// Providers
// ──────────────────────────────────────────────────────────────

final expandedSectionsProvider = StateNotifierProvider<ExpandedSectionsNotifier, Set<int>>((ref) {
  return ExpandedSectionsNotifier();
});

class ExpandedSectionsNotifier extends StateNotifier<Set<int>> {
  ExpandedSectionsNotifier() : super({0});

  void toggle(int index) {
    final newSet = Set<int>.from(state);
    if (newSet.contains(index)) {
      newSet.remove(index);
    } else {
      newSet.add(index);
    }
    state = newSet;
  }

  bool isExpanded(int index) => state.contains(index);
}

// ──────────────────────────────────────────────────────────────
// Main Screen
// ──────────────────────────────────────────────────────────────

class GardeningTips extends ConsumerWidget {
  const GardeningTips({super.key});

  static const _tipsData = [
    {
      'title': 'Beginner Gardening Tips',
      'tips': [
        "Start small — it's better to care for a few plants well than many poorly.",
        'Always read the plant label before planting.',
        'Most plants die from overwatering, not underwatering.',
        'Check soil moisture with your finger before watering.',
        'Choose plants suited to your local climate.',
        'Good soil matters more than fancy fertilizers.',
        'Sun-loving plants need 6-8 hours of sunlight daily.',
        'Shade plants still need light — just indirect.',
        "Don't plant too deeply; roots need air.",
        'Be patient — plants grow on their own schedule.',
      ],
    },
    {
      'title': 'Watering Tips',
      'tips': [
        'Water deeply and less frequently to encourage deep root growth.',
        'Water in the early morning to reduce evaporation.',
        'Avoid watering leaves to prevent fungal diseases.',
        'Use mulch to retain soil moisture.',
        'Check soil moisture before watering - stick your finger 2 inches deep.',
        'Adjust watering based on weather and season.',
        'Container plants need more frequent watering.',
      ],
    },
    {
      'title': 'Sun & Placement Tips',
      'tips': [
        'Observe sunlight patterns in your garden throughout the day.',
        'Full sun = 6+ hours of direct sunlight daily.',
        'Partial shade = 3-6 hours of sunlight daily.',
        'Full shade = less than 3 hours of direct sun.',
        'South-facing areas get the most sun.',
        'North-facing areas are best for shade plants.',
        'Consider seasonal sun changes when planting.',
      ],
    },
    {
      'title': 'Soil & Feeding Tips',
      'tips': [
        'Test your soil pH before planting.',
        'Add organic matter like compost to improve soil quality.',
        'Different plants need different soil types.',
        'Feed plants during growing season, not dormancy.',
        'Over-fertilizing can harm plants more than under-fertilizing.',
        'Use slow-release fertilizers for consistent nutrition.',
        'Mulch helps maintain soil temperature and moisture.',
      ],
    },
    {
      'title': 'Pruning & Maintenance Tips',
      'tips': [
        'Prune in late winter or early spring for most plants.',
        'Always use sharp, clean pruning tools.',
        'Remove dead, diseased, or damaged branches first.',
        'Prune to shape and control plant size.',
        'Deadhead flowers to encourage more blooms.',
        "Don't remove more than 1/3 of plant material at once.",
        'Sterilize tools between plants to prevent disease spread.',
      ],
    },
    {
      'title': 'Pest & Disease Tips',
      'tips': [
        'Inspect plants regularly for signs of pests or disease.',
        'Remove affected leaves or branches immediately.',
        'Encourage beneficial insects like ladybugs.',
        'Use neem oil as a natural pest deterrent.',
        'Maintain good air circulation to prevent fungal issues.',
        'Avoid overhead watering which promotes disease.',
        'Quarantine new plants before adding to garden.',
      ],
    },
    {
      'title': 'Container Gardening Tips',
      'tips': [
        'Ensure containers have drainage holes.',
        'Use quality potting mix, not garden soil.',
        'Container plants need more frequent feeding.',
        'Group plants with similar water needs.',
        'Consider pot size - bigger is often better.',
        'Repot when roots become crowded.',
        'Protect containers from extreme temperatures.',
      ],
    },
    {
      'title': 'Seasonal Gardening Tips',
      'tips': [
        'Spring: Prepare soil and start seeds indoors.',
        'Summer: Water regularly and deadhead flowers.',
        'Fall: Plant bulbs and divide perennials.',
        'Winter: Protect tender plants from frost.',
        'Adjust care routines based on seasonal changes.',
        "Plan next season's garden during dormant months.",
        'Clean and maintain tools during off-season.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedSections = ref.watch(expandedSectionsProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 72.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: _buildBackButton(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🌿 ', style: TextStyle(fontSize: 24.sp)),
            Text(
              'Gardening Tips',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.3,
                shadows: [
                  Shadow(color: Colors.black45, blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
            ),
            Text(' 🌿', style: TextStyle(fontSize: 24.sp)),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              ImagePath.quoteBackground,
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.lighten,
              color: const Color(0xFFE8F5E9).withValues(alpha: 0.20),
            ),
          ),

          // Overlay gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.35, 0.65, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.22),
                    Colors.transparent,
                    Colors.white.withValues(alpha: 0.04),
                    Colors.white.withValues(alpha: 0.12),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 56.h), // appbar space

                // Tagline pill
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    decoration: ShapeDecoration(
                      shape: const StadiumBorder(),
                      color: const Color(0xFF4CAF50).withValues(alpha: 0.16),
                    ),
                    child: CustomText(
                     text:  'Right Plant • Right Place • Right Care',

                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                        letterSpacing: 0.1,

                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 16.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAF5),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(36.r)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 24,
                          offset: const Offset(0, -8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          '${_tipsData.length} Categories  •  ${_tipsData.fold<int>(0, (sum, e) => sum + (e['tips'] as List).length)} Tips',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF5D6B55),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 40.h),
                            itemCount: _tipsData.length,
                            itemBuilder: (context, index) {
                              final section = _tipsData[index];
                              final isExpanded = expandedSections.contains(index);
                              return TipSection(
                                title: section['title'] as String,
                                tips: section['tips'] as List<String>,
                                isExpanded: isExpanded,
                                index: index,
                                onToggle: () => ref.read(expandedSectionsProvider.notifier).toggle(index),
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
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Icon(
        Icons.arrow_back_rounded,
        color: Colors.white,
        size: 22.sp,
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
// Tip Section Card
// ──────────────────────────────────────────────────────────────

class TipSection extends StatelessWidget {
  final String title;
  final List<String> tips;
  final bool isExpanded;
  final int index;
  final VoidCallback onToggle;

  const TipSection({
    super.key,
    required this.title,
    required this.tips,
    required this.isExpanded,
    required this.index,
    required this.onToggle,
  });

  static const _sectionColors = [
    Color(0xFF2E7D32), // deep green
    Color(0xFF388E3C),
    Color(0xFF4CAF50),
    Color(0xFF66BB6A),
    Color(0xFF558B2F),
    Color(0xFF689F38),
    Color(0xFF33691E),
    Color(0xFF1B5E20),
  ];

  static const _emojis = [
    '🌱', '💧', '☀️', '🌿', '✂️', '🐞', '🪴', '🍂',
  ];

  @override
  Widget build(BuildContext context) {
    final colorIndex = index % _sectionColors.length;
    final baseColor = _sectionColors[colorIndex];
    final headerColor = baseColor.withValues(alpha: 0.94);
    final dotColor = baseColor.withValues(alpha: 0.80);
    final emoji = _emojis[colorIndex];

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(24.r),
          onTap: onToggle,
          splashColor: baseColor.withValues(alpha: 0.12),
          highlightColor: baseColor.withValues(alpha: 0.08),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 340),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: baseColor.withValues(alpha: 0.16), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: baseColor.withValues(alpha: 0.14),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [headerColor, headerColor.withValues(alpha: 0.88)],
                    ),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Row(
                    children: [
                      Text(emoji, style: TextStyle(fontSize: 26.sp)),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.24,
                            letterSpacing: -0.1,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0.0,
                        duration: const Duration(milliseconds: 420),
                        curve: Curves.easeInOutBack,
                        child: Icon(
                          Icons.expand_more_rounded,
                          color: Colors.white,
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                ),

                // Content
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 360),
                  crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  firstCurve: Curves.easeOut,
                  secondCurve: Curves.easeIn,
                  sizeCurve: Curves.easeInOutCubic,
                  firstChild: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
                    child: Column(
                      children: tips.asMap().entries.map((entry) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 14.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 6.h),
                                child: Container(
                                  width: 9.r,
                                  height: 9.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: dotColor,
                                  ),
                                ),
                              ),
                              SizedBox(width: 14.w),
                              Expanded(
                                child: Text(
                                  entry.value,
                                  style: TextStyle(
                                    fontSize: 14.5.sp,
                                    height: 1.48,
                                    color: const Color(0xFF1F2A1D),
                                    letterSpacing: -0.15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  secondChild: const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}