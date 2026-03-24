import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/constants/icon_path.dart';
import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/curve_clipper.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

// Models
class GalleryCategory {
  final String name;

  GalleryCategory({required this.name});
}

class GalleryItem {
  final String title;
  final String category;
  final String beforeImage;
  final String afterImage;

  GalleryItem({
    required this.title,
    required this.category,
    required this.beforeImage,
    required this.afterImage,
  });
}

// Providers
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

final categoriesProvider = Provider<List<GalleryCategory>>((ref) {
  return [
    GalleryCategory(name: 'All'),
    GalleryCategory(name: 'Lawns'),
    GalleryCategory(name: 'Hedges'),
    GalleryCategory(name: 'Landscaping'),
  ];
});

final galleryItemsProvider = Provider<List<GalleryItem>>((ref) {
  return [
    GalleryItem(
      title: 'Lawn Restoration',
      category: 'Lawns',
      beforeImage: ImagePath.galleryOne,
      afterImage: ImagePath.galleryTwo,
    ),
    GalleryItem(
      title: 'Lawn Maintenance',
      category: 'Lawns',
      beforeImage: ImagePath.galleryThree,
      afterImage: ImagePath.galleryFour,
    ),
    GalleryItem(
      title: 'Hedge Trimming',
      category: 'Hedges',
      beforeImage: ImagePath.galleryOne,
      afterImage: ImagePath.galleryThree
    ),
    GalleryItem(
      title: 'Garden Landscaping',
      category: 'Landscaping',
      beforeImage: ImagePath.galleryFour,
      afterImage: ImagePath.galleryTwo,
    ),
  ];
});

final filteredGalleryItemsProvider = Provider<List<GalleryItem>>((ref) {
  final selectedCategory = ref.watch(selectedCategoryProvider);
  final allItems = ref.watch(galleryItemsProvider);

  if (selectedCategory == 'All') {
    return allItems;
  }

  return allItems.where((item) => item.category == selectedCategory).toList();
});

class GalleryScreen extends ConsumerWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final filteredItems = ref.watch(filteredGalleryItemsProvider);

    return Scaffold(
      body: Stack(
        children: [
          // ── Background image ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground, // Consistent with other screens
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
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Gallery',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(11.67.r),
                      decoration: BoxDecoration(
                        color: Color(0xFF126A19),
                        shape: BoxShape.circle,
                        border: Border.all(width: 0.83,color: Color(0xFF188220)
                        )
                      ),
                        child: Image.asset(IconPath.filterEdit,height: 16.67.h,width: 16.67.w,)
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // ── Curved Content Area ──────────────────────────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(), // Applied the clipper
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.containerBackground,
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.85),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.65, 0.8, 1.0],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60.h), // Offset for the curve peak

                        // Category Filters (Horizontal scroll)
                        SizedBox(
                          height: 44.h,
                          child: ListView.separated(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            separatorBuilder: (context, index) => SizedBox(width: 8.w),
                            itemBuilder: (context, index) {
                              final category = categories[index];
                              final isSelected = selectedCategory == category.name;

                              return GestureDetector(
                                onTap: () {
                                  ref.read(selectedCategoryProvider.notifier).state = category.name;
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF126A19) : Colors.transparent,
                                    borderRadius: BorderRadius.circular(25.r),
                                    border: Border.all(color: Color(0xFF126A19),width: 1),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.04),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: category.name,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected ? Colors.white : const Color(0xFF126A19),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Gallery Items List
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 100.h),
                            itemCount: filteredItems.length,
                            separatorBuilder: (context, index) => SizedBox(height: 24.h),
                            itemBuilder: (context, index) {
                              final item = filteredItems[index];
                              return GalleryItemCard(
                                title: item.title,
                                beforeImage: item.beforeImage,
                                afterImage: item.afterImage,
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

class GalleryItemCard extends StatelessWidget {
  final String title;
  final String beforeImage;
  final String afterImage;

  const GalleryItemCard({
    super.key,
    required this.title,
    required this.beforeImage,
    required this.afterImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        CustomText(
          text: title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1F2937),
        ),

        SizedBox(height: 12.h),

        // Before & After Images
        Row(
          children: [
            // Before Image
            Expanded(
              child: BeforeAfterImage(
                image: beforeImage,
                label: 'Before',
              ),
            ),

            SizedBox(width: 12.w),

            // After Image
            Expanded(
              child: BeforeAfterImage(
                image: afterImage,
                label: 'After',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BeforeAfterImage extends StatelessWidget {
  final String image;
  final String label;

  const BeforeAfterImage({
    super.key,
    required this.image,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
          onError: (exception, stackTrace) {
            // Fallback for missing images
          },
        ),
      ),
      child: Stack(
        children: [
          // Gradient overlay at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.r),
                  bottomRight: Radius.circular(16.r),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.6),
                  ],
                ),
              ),
            ),
          ),

          // Label
          Positioned(
            bottom: 12.h,
            left: 12.w,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}