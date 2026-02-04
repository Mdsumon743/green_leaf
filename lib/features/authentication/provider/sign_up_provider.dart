

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/legacy.dart';

class SignUpState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool isLoading;
  final String? errorMessage;

  SignUpState({
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SignUpState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
      isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}


class SignUpProvider extends StateNotifier<SignUpState> {
  SignUpProvider() : super(SignUpState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();

  void togglePasswordVisibility() {
    state = state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    );
  }

  void toggleConfirmPasswordVisibility() {
    state = state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    );
  }

  Future<void> login() async {
    if (emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      state = state.copyWith(errorMessage: 'Please fill in all fields');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      state = state.copyWith(errorMessage: 'Passwords do not match');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    await Future.delayed(const Duration(seconds: 2));

    state = state.copyWith(isLoading: false);
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneNumberController.clear();
    fullNameController.clear();
    super.dispose();
  }
}


final signUpProvider = StateNotifierProvider<SignUpProvider, SignUpState>(
      (ref) => SignUpProvider(),
);