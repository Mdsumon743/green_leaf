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

import '../../../../../core/global/curve_clipper.dart';

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
      resizeToAvoidBottomInset: false, // Prevents keyboard from squishing the curve
      body: Stack(
        children: [
          // ── Background image ───────────────────────────────────────
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground, // Using the consistent background
              fit: BoxFit.cover,
            ),
          ),

          // ── Main Content ───────────────────────────────────────────
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              // Header (Centered Title)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Icon(Icons.arrow_back, color: AppColor.white, size: 24.sp),
                    ),
                    const Spacer(),
                    CustomText(
                      text: "Change Password",
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      color: AppColor.white,
                    ),
                    const Spacer(),
                    SizedBox(width: 24.w), // Balances the back icon for perfect centering
                  ],
                ),
              ),

              SizedBox(height: 30.h),

              // ── Curved Container with Form ──────────────────────────
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.containerBackground,
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.6, 0.8, 1.0],
                      ),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 60.h), // Offset for the curve peak

                          // Old Password
                          _buildLabel("Old Password"),
                          CustomTextFormField(
                            controller: oldPasswordController,
                            hintText: "* * * * * *",
                            obscureText: !state.isOldPasswordVisible,
                            borderRadius: 12.r,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.1),
                            blurRadius: 10.r,
                            suffixIcon: _buildVisibilityToggle(
                              isVisible: state.isOldPasswordVisible,
                              onTap: notifier.toggleOldPasswordVisibility,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // New Password
                          _buildLabel("New Password"),
                          CustomTextFormField(
                            controller: newPasswordController,
                            hintText: "* * * * * *",
                            obscureText: !state.isNewPasswordVisible,
                            borderRadius: 12.r,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.1),
                            blurRadius: 10.r,
                            suffixIcon: _buildVisibilityToggle(
                              isVisible: state.isNewPasswordVisible,
                              onTap: notifier.toggleNewPasswordVisibility,
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Confirm Password
                          _buildLabel("Confirm New Password"),
                          CustomTextFormField(
                            controller: confirmPasswordController,
                            hintText: "* * * * * *",
                            obscureText: !state.isConfirmPasswordVisible,
                            borderRadius: 12.r,
                            shadowColor: const Color(0xFF055726).withValues(alpha: 0.1),
                            blurRadius: 10.r,
                            suffixIcon: _buildVisibilityToggle(
                              isVisible: state.isConfirmPasswordVisible,
                              onTap: notifier.toggleConfirmPasswordVisibility,
                            ),
                          ),

                          SizedBox(height: 120.h), // Bottom spacing for fixed button
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ── Fixed Bottom Button ────────────────────────────────────
          Positioned(
            bottom: 35.h,
            left: 20.w,
            right: 20.w,
            child: CustomButton(
              backgroundGradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF8CC40F),
                  Color(0xFF126A19)
                ]
              ),
              borderWidth: 2,
              borderRadius: 8.r,
              text: state.isLoading ? "Changing..." : "Submit",
              onPressed: state.isLoading
                  ? null
                  : () {
                final oldPass = oldPasswordController.text.trim();
                final newPass = newPasswordController.text.trim();
                final confirmPass = confirmPasswordController.text.trim();
                notifier.changePassword(oldPass, newPass, confirmPass);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ── Helper Widgets ─────────────────────────────────────────────────
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: CustomText(
        text: text,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: AppColor.textBody,
      ),
    );
  }

  Widget _buildVisibilityToggle({required bool isVisible, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        isVisible ? Icons.visibility : Icons.visibility_off,
        color: const Color(0xFF9098A1),
        size: 22.sp,
      ),
    );
  }
}
