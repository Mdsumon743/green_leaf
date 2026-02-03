
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saunders/core/global/custom_text.dart';

import '../../providers/role_selection_provider.dart';


class RoleSelectButton extends ConsumerWidget {
  final String text;
  final UserRole role;
  final VoidCallback onPressed;

  const RoleSelectButton({
    super.key,
    required this.text,
    required this.role,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRole = ref.watch(selectedRoleProvider);
    final isSelected = selectedRole == role;

    /// BORDER GRADIENT (same for both)
    final borderGradient = const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF9DC167),
        Color(0xFF348317),
      ],
    );

    /// INNER BACKGROUND
    final innerGradient = isSelected
        ? const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF8CC40F),
        Color(0xFF348317),
      ],
    )
        : const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xff0F2A00),
        Color(0xff0B1E00),
      ],
    );

    return GestureDetector(
      onTap: () {
        ref.read(selectedRoleProvider.notifier).state = role;
        onPressed();
      },
      child: Container(
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: borderGradient,
          borderRadius: BorderRadius.circular(8.r),
        ),
        padding: EdgeInsets.all(2.2.r), // 🔥 thin pixel border
        child: Container(
          decoration: BoxDecoration(
            gradient: innerGradient,
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomText(
              text:   text,

                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                textAlign: TextAlign.center,


              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
