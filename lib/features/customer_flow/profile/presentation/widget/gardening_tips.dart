import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/tips_section.dart';

// State provider for managing expanded sections
final expandedSectionsProvider =
StateNotifierProvider<ExpandedSectionsNotifier, Set<int>>((ref) {
  return ExpandedSectionsNotifier();
});

class ExpandedSectionsNotifier extends StateNotifier<Set<int>> {
  ExpandedSectionsNotifier() : super({0}); // Initially expand first section

  void toggle(int index) {
    if (state.contains(index)) {
      state = {...state}..remove(index);
    } else {
      state = {...state, index};
    }
  }

  bool isExpanded(int index) {
    return state.contains(index);
  }
}

class GardeningTips extends ConsumerWidget {
  const GardeningTips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedSections = ref.watch(expandedSectionsProvider);

    final tipsData = [
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
                    SizedBox(width: 80.w),
                    Text(
                      'Gardening Tips',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Content area with gradient to show background at bottom
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 24.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    // Use gradient instead of solid color to reveal background at bottom
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
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 100.h), // Add bottom padding
                    itemCount: tipsData.length,
                    itemBuilder: (context, index) {
                      final section = tipsData[index];
                      final isExpanded = expandedSections.contains(index);

                      return TipSection(
                        title: section['title'] as String,
                        tips: section['tips'] as List<String>,
                        isExpanded: isExpanded,
                        onToggle: () {
                          ref
                              .read(expandedSectionsProvider.notifier)
                              .toggle(index);
                        },
                      );
                    },
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