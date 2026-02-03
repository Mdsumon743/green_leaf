import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_text.dart';
import '../../../../core/constants/image_path.dart';
import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/app_color.dart';
import '../../providers/role_selection_provider.dart';
import '../widget/role_selection_button.dart';

class RoleSelectionScreen extends ConsumerWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(ImagePath.roleBackground, fit: BoxFit.cover),

          Container(color: Colors.black.withValues(alpha: 0.35)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 230.h,),
              CustomText(
                text: AppText.chooseRole,
                font: AppFont.impact,
                fontSize: 64.sp,
                color: AppColor.white,
                textAlign: TextAlign.center,
                height: 0.95,
              ),

              SizedBox(height: 6.h),

              CustomText(
                text: AppText.chooseRoleDescription,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColor.white,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 172.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    RoleSelectButton(
                      text: "Continue as a Customer",
                      role: UserRole.customer,
                      onPressed: () {
                        ref.read(selectedRoleProvider.notifier).state = UserRole.employee;
                        context.go("/customerOnBoarding");
                      },
                    ),
                    SizedBox(height: 14.h),
                    RoleSelectButton(
                      text: "Continue as an Employee",
                      role: UserRole.employee,
                      onPressed: (){},
                    ),


                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
