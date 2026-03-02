import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';

import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/custom_text.dart';
import '../../model/service_model.dart';
import '../../provider/service_provider.dart';





const List<ServiceModel> _allServices = [
  ServiceModel(
    id: 1,
    name: 'Garden Maintenance',
    price: '€ 120.00',
    description: 'Plant care, weeding pruning.',
    category: 'popular',
    distanceKm: 2.5,
    imagePath: ImagePath.gardening,
  ),
  ServiceModel(
    id: 2,
    name: 'Hedge Trimming',
    price: '€ 95.00',
    description: 'Plant care, weeding pruning.',
    category: 'popular',
    distanceKm: 5.1,
    imagePath: ImagePath.house,
  ),
  ServiceModel(
    id: 3,
    name: 'Lawn Mowing',
    price: '€ 80.00',
    description: 'Plant care, weeding pruning.',
    category: 'popular',
    distanceKm: 8.4,
    imagePath: ImagePath.house,
  ),
  ServiceModel(
    id: 4,
    name: 'Garden Maintenance',
    price: '€ 120.00',
    description: 'Plant care, weeding pruning.',
    category: 'seasonal',
    distanceKm: 12.0,
    imagePath: ImagePath.gardening,
  ),

];

final filteredServicesProvider = Provider<List<ServiceModel>>((ref) {
  final filter = ref.watch(servicesFilterProvider);
  return _allServices.where((s) {
    if (filter.searchQuery.isNotEmpty &&
        !s.name.toLowerCase().contains(filter.searchQuery.toLowerCase()) &&
        !s.description
            .toLowerCase()
            .contains(filter.searchQuery.toLowerCase())) {
      return false;
    }
    if (s.distanceKm > filter.maxDistanceKm) return false;
    if (filter.selectedTab != ServiceCategory.all &&
        s.category != filter.selectedTab.name) return false;
    if (filter.filterCategory != null &&
        filter.filterCategory != ServiceCategory.all &&
        s.category != filter.filterCategory!.name) return false;
    return true;
  }).toList();
});

// ── Theme Colors ──────────────────────────────────────────────────────────────



// ── Screen ────────────────────────────────────────────────────────────────────

class AllServicesScreen extends ConsumerStatefulWidget {
  const AllServicesScreen({super.key});

  @override
  ConsumerState<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends ConsumerState<AllServicesScreen> {
  final _searchController = TextEditingController();

  static const _tabs = [
    (ServiceCategory.popular, 'Popular'),
    (ServiceCategory.seasonal, 'Seasonal'),
    (ServiceCategory.all, 'All'),
    (ServiceCategory.offer, 'Offer'),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openFilterSheet() {
    final current = ref.read(servicesFilterProvider);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _FilterBottomSheet(
        initialDistance: current.maxDistanceKm,
        initialCategory: current.filterCategory,
        onApply: (distance, category) {
          ref
              .read(servicesFilterProvider.notifier)
              .applyFilter(maxDistanceKm: distance, category: category);
        },
        onReset: () =>
            ref.read(servicesFilterProvider.notifier).resetFilters(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(servicesFilterProvider);
    final services = ref.watch(filteredServicesProvider);
    final notifier = ref.read(servicesFilterProvider.notifier);
    final hasActiveFilter =
        filter.filterCategory != null || filter.maxDistanceKm < 50;

    return Scaffold(
      backgroundColor: AppColor.scaffoldBg,
      body: Stack(
        children: [
          // ── Green header background ─────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 215.h,
            child:  DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColor.headerGradientStart,
                    AppColor.headerGradientEnd,
                  ],
                ),
              ),
            ),
          ),

          // ── Decorative leaves top-right ─────────────────────────────
          Positioned(
            top: -10,
            right: -14,
            child: Opacity(
              opacity: 0.28,
              child: Icon(Icons.eco_rounded, color: Colors.white, size: 130.r),
            ),
          ),
          Positioned(
            top: 14,
            right: 68,
            child: Opacity(
              opacity: 0.13,
              child: Icon(Icons.eco_rounded, color: Colors.white, size: 60.r),
            ),
          ),

          // ── All content ─────────────────────────────────────────────
          Column(
            children: [
              // ── AppBar ─────────────────────────────────────────────
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 34.w,
                          height: 34.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 15.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomText(
                        text:  'All Services',
                          textAlign: TextAlign.center,

                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.2,

                        ),
                      ),
                      SizedBox(width: 34.w), // balance
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // ── Search + Filter row ───────────────────────────────
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    // Search
                    Expanded(
                      child: Container(
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(22.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.07),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: CustomTextFormField(
                          controller: _searchController,
                          onChanged: notifier.setSearch, hintText: 'search',

                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),

                    // Filter icon button
                    GestureDetector(
                      onTap: _openFilterSheet,
                      child: Container(
                        width: 44.w,
                        height: 44.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.92),
                          borderRadius: BorderRadius.circular(22.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.07),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.tune_rounded,
                              color: AppColor.primary,
                              size: 19.sp,
                            ),
                            if (hasActiveFilter)
                              Positioned(
                                top: 9,
                                right: 9,
                                child: Container(
                                  width: 7,
                                  height: 7,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE05252),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              // ── Filter tabs ────────────────────────────────────────
              SizedBox(
                height: 34.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: _tabs.map((t) {
                    final isSelected = filter.selectedTab == t.$1;
                    return GestureDetector(
                      onTap: () => notifier.setTab(t.$1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeInOut,
                        margin: EdgeInsets.only(right: 8.w),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColor.primary : Colors.white,
                          borderRadius: BorderRadius.circular(17.r),
                          border: Border.all(
                            color: isSelected
                                ? AppColor.primary
                                : AppColor.tabUnselectedBorder,
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          t.$2,
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color:
                            isSelected ? Colors.white : AppColor.textMid,
                            height: 1,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 14.h),

              // ── Service list ───────────────────────────────────────
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.scaffoldBg,
                    borderRadius: BorderRadius.vertical(
                        top: Radius.circular(26.r)),
                  ),
                  child: services.isEmpty
                      ? _EmptyState()
                      : ListView.separated(
                    padding: EdgeInsets.fromLTRB(
                        16.w, 18.h, 16.w, 40.h),
                    itemCount: services.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: 12.h),
                    itemBuilder: (_, i) =>
                        ServiceCard(service: services[i]),
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



class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.cardBorder, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(16.r)),
            child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: service.imagePath.isNotEmpty
                  ? Image.asset(
                service.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => PlaceholderImg(),
              )
                  : PlaceholderImg(),
            ),
          ),

          // Text content
          Expanded(
            child: Padding(
              padding:
              EdgeInsets.fromLTRB(14.w, 0, 8.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    service.name,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.textDark,
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColor.textLight,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Arrow button
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius: BorderRadius.circular(9.r),
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 13.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlaceholderImg extends StatelessWidget {
  const PlaceholderImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD4E8CC),
      child: Center(
        child: Icon(
          Icons.park_rounded,
          color: AppColor.primary.withValues(alpha: 0.45),
          size: 34,
        ),
      ),
    );
  }
}

// ── Empty State ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, color: AppColor.textLight, size: 52.r),
          SizedBox(height: 12.h),
          Text(
            'No services found',
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppColor.textMid),
          ),
          SizedBox(height: 5.h),
          Text(
            'Try adjusting your filters or search.',
            style: TextStyle(fontSize: 12.sp, color: AppColor.textLight),
          ),
        ],
      ),
    );
  }
}

// ── Filter Bottom Sheet ───────────────────────────────────────────────────────

class _FilterBottomSheet extends StatefulWidget {
  final double initialDistance;
  final ServiceCategory? initialCategory;
  final void Function(double distance, ServiceCategory? category) onApply;
  final VoidCallback onReset;

  const _FilterBottomSheet({
    required this.initialDistance,
    required this.initialCategory,
    required this.onApply,
    required this.onReset,
  });

  @override
  State<_FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<_FilterBottomSheet> {
  late double _distance;
  ServiceCategory? _selectedCategory;

  static const _labels = {
    ServiceCategory.popular: 'Popular',
    ServiceCategory.seasonal: 'Seasonal',
    ServiceCategory.all: 'All',
    ServiceCategory.offer: 'Offer',
  };

  @override
  void initState() {
    super.initState();
    _distance = widget.initialDistance;
    _selectedCategory = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26.r)),
      ),
      padding: EdgeInsets.fromLTRB(22.w, 0, 22.w, 34.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFDCE8D8),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),

          // Title + Reset
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter Services',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.textDark,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _distance = 50;
                    _selectedCategory = null;
                  });
                  widget.onReset();
                },
                child: Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Category label
          Text(
            'Category',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColor.textDark,
            ),
          ),
          SizedBox(height: 10.h),

          // Category chips
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: ServiceCategory.values.map((cat) {
              final isSelected = _selectedCategory == cat;
              return GestureDetector(
                onTap: () => setState(
                        () => _selectedCategory = isSelected ? null : cat),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColor.primary
                        : const Color(0xFFF2F7F0),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: isSelected
                          ? AppColor.primary
                          : const Color(0xFFDCE8D8),
                    ),
                  ),
                  child: Text(
                    _labels[cat]!,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color:
                      isSelected ? Colors.white : AppColor.textMid,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 24.h),

          // Nearby location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nearby Location',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.textDark,
                ),
              ),
              Container(
                padding:
                EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF7EB),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${_distance.toInt()} km',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Slider
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColor.primary,
              inactiveTrackColor: const Color(0xFFDCE8D8),
              thumbColor: AppColor.primary,
              overlayColor: AppColor.primary.withValues(alpha: 0.12),
              trackHeight: 4,
              thumbShape:
              const RoundSliderThumbShape(enabledThumbRadius: 9),
            ),
            child: Slider(
              value: _distance,
              min: 1,
              max: 50,
              divisions: 49,
              onChanged: (v) => setState(() => _distance = v),
            ),
          ),

          // Distance tick labels
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [1, 10, 20, 30, 50].map((km) {
                final active = _distance.toInt() >= km;
                return GestureDetector(
                  onTap: () =>
                      setState(() => _distance = km.toDouble()),
                  child: Column(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: active
                              ? AppColor.primary
                              : const Color(0xFFDCE8D8),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '$km km',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: active ? AppColor.primary : AppColor.textLight,
                          fontWeight: active
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 28.h),

          // Apply button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: () {
                widget.onApply(_distance, _selectedCategory);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: Text(
                'Apply Filters',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Entry Point ───────────────────────────────────────────────────────────────

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AllServicesScreen(),
      ),
    ),
  );
}