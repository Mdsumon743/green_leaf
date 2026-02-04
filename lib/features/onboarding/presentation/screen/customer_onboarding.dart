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

class CustomerOnboarding extends ConsumerWidget {
  const CustomerOnboarding({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(ImagePath.customerBackground, fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.35)),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 230.h),

              CustomText(
                text: AppText.gardenText,
                font: AppFont.impact,
                fontSize: 64.sp,
                color: AppColor.white,
                textAlign: TextAlign.center,
                height: 0.95,
              ),

              SizedBox(height: 172.h),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    RoleSelectButton(
                      text: "Request a Quote",
                      role: UserRole.customer,
                      onPressed: () {
                        ref.read(selectedRoleProvider.notifier).state =
                            UserRole.customer;
                        context.push("/myQuote");
                      },
                    ),

                    SizedBox(height: 14.h),

                    Row(
                      children: [
                        Expanded(
                          child: RoleSelectButton(
                            text: "Log in",
                            role: UserRole.employee,
                            onPressed: () {
                              ref.read(selectedRoleProvider.notifier).state =
                                  UserRole.customer;
                              context.push("/login");
                            },
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: RoleSelectButton(
                            text: "Sign up",
                            role: UserRole.employee,
                            onPressed: () {},
                          ),
                        ),
                      ],
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
