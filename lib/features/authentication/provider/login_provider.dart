import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class LoginState {
  final bool isPasswordVisible;
  final bool isLoading;
  final String? errorMessage;

  LoginState({
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isPasswordVisible,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class LoginProvider extends StateNotifier<LoginState> {
  LoginProvider() : super(LoginState());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  Future<void> login() async {
    // Validate inputs
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      state = state.copyWith(errorMessage: 'Please fill in all fields');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // TODO: Implement your login logic here
      // Example: await authService.login(email, password);

      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      state = state.copyWith(isLoading: false);

      // Navigate to home or show success
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

final loginProvider = StateNotifierProvider<LoginProvider, LoginState>(
      (ref) => LoginProvider(),
);