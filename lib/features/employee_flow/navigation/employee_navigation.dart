



import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/features/employee_flow/home/presentation/screen/employee_home_screen.dart';
import 'package:saunders/features/employee_flow/profile/presentation/widget/subscription_screen.dart';
import '../../customer_flow/invoice/presentation/screen/invoice_screen.dart';
import '../../customer_flow/message/presentation/screen/message_screen.dart';
import '../profile/presentation/screen/employee_profile_screen.dart';

// State provider for selected index
final selectedIndexProvider = StateProvider<int>((ref) => 0);





class EmployeeNavigation extends ConsumerWidget {
  const EmployeeNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    final screens = [
      const EmployeeHomeScreen(),
      const InvoiceScreen(),
      const MessageScreen(),
      const SubscriptionScreen(),
      const EmployeeProfileScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: screens[selectedIndex],
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Container(
      height: 90.h, // Adjusted height to match reference
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r), // Increased radius for a more prominent curve
          topRight: Radius.circular(20.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(ref, 0, IconPath.home, IconPath.activeHome, 'Home', selectedIndex),
          _buildNavItem(ref, 1, IconPath.invoice, IconPath.activeInvoice, 'Invoice', selectedIndex),
          _buildNavItem(ref, 2, IconPath.message, IconPath.activeMessage, 'Message', selectedIndex),
          _buildNavItem(ref, 3, IconPath.package1, IconPath.activePackage, 'Package', selectedIndex, isImage: true),
          _buildNavItem(ref, 4, IconPath.profile, IconPath.activeProfile, 'Profile', selectedIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(
      WidgetRef ref,
      int index,
      String icon,
      String activeIcon,
      String label,
      int currentIndex,
      {bool isImage = false}
      ) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => ref.read(selectedIndexProvider.notifier).state = index,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 24.h,
            width: 24.w,
            child: isImage
                ? Image.asset(icon, color: isSelected ? const Color(0xFF126A19) : const Color(0xFF4B5563))
                : SvgPicture.asset(isSelected ? activeIcon : icon),
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xFF126A19) : const Color(0xFF4B5563),
            ),
          ),
        ],
      ),
    );
  }
}

