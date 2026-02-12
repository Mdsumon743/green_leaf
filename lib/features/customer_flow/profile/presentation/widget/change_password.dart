import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';

/// ---------------------------
/// Riverpod State Provider
/// ---------------------------
class ChangePasswordState {
  final bool isOldPasswordVisible;
  final bool isNewPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;

  ChangePasswordState({
    this.isOldPasswordVisible = false,
    this.isNewPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isLoading = false,
  });

  ChangePasswordState copyWith({
    bool? isOldPasswordVisible,
    bool? isNewPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
  }) {
    return ChangePasswordState(
      isOldPasswordVisible: isOldPasswordVisible ?? this.isOldPasswordVisible,
      isNewPasswordVisible: isNewPasswordVisible ?? this.isNewPasswordVisible,
      isConfirmPasswordVisible:
      isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChangePasswordNotifier extends StateNotifier<ChangePasswordState> {
  ChangePasswordNotifier() : super(ChangePasswordState());

  void toggleOldPasswordVisibility() {
    state = state.copyWith(isOldPasswordVisible: !state.isOldPasswordVisible);
  }

  void toggleNewPasswordVisibility() {
    state = state.copyWith(isNewPasswordVisible: !state.isNewPasswordVisible);
  }

  void toggleConfirmPasswordVisibility() {
    state =
        state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible);
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> changePassword(String oldPass, String newPass, String confirmPass) async {
    setLoading(true);

    // Simulate API call delay
    await Future.delayed(Duration(seconds: 2));

    // TODO: Add real API call here

    setLoading(false);
  }
}

final changePasswordProvider =
StateNotifierProvider<ChangePasswordNotifier, ChangePasswordState>(
        (ref) => ChangePasswordNotifier());

/// ---------------------------
/// UI Screen
/// ---------------------------
class ChangePasswordScreen extends ConsumerWidget {
  ChangePasswordScreen({super.key});

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(changePasswordProvider);
    final notifier = ref.read(changePasswordProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                ImagePath.quoteBackground,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button + Title
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(Icons.arrow_back, color: AppColor.white),
                      ),
                      SizedBox(width: 12.w),
                      CustomText(
                        text: "Change Password",
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                        color: AppColor.white,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),

                  // Scrollable Form
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Old Password",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            controller: oldPasswordController,
                            hintText: "Enter old password",
                            obscureText: !state.isOldPasswordVisible,
                            suffixIcon: GestureDetector(
                              onTap: notifier.toggleOldPasswordVisibility,
                              child: Icon(
                                state.isOldPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColor.textBody,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          CustomText(
                            text: "New Password",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            controller: newPasswordController,
                            hintText: "Enter new password",
                            obscureText: !state.isNewPasswordVisible,
                            suffixIcon: GestureDetector(
                              onTap: notifier.toggleNewPasswordVisibility,
                              child: Icon(
                                state.isNewPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColor.textBody,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          CustomText(
                            text: "Confirm New Password",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 12.h),
                          CustomTextFormField(
                            controller: confirmPasswordController,
                            hintText: "Confirm new password",
                            obscureText: !state.isConfirmPasswordVisible,
                            suffixIcon: GestureDetector(
                              onTap: notifier.toggleConfirmPasswordVisibility,
                              child: Icon(
                                state.isConfirmPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: AppColor.textBody,
                              ),
                            ),
                          ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),

                  // Change Button
                  CustomButton(
                    text: state.isLoading ? "Changing..." : "Change Password",
                    onPressed: state.isLoading
                        ? null
                        : () {
                      final oldPass = oldPasswordController.text.trim();
                      final newPass = newPasswordController.text.trim();
                      final confirmPass =
                      confirmPasswordController.text.trim();
                      notifier.changePassword(oldPass, newPass, confirmPass);
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
