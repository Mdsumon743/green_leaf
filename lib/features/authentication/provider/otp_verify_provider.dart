


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class VerifyOtpState {
  final bool isLoading;
  final String? errorMessage;
  final String otp;
  final int resendTimer;
  final bool canResend;

  VerifyOtpState({
    this.isLoading = false,
    this.errorMessage,
    this.otp = '',
    this.resendTimer = 43,
    this.canResend = false,
  });

  VerifyOtpState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? otp,
    int? resendTimer,
    bool? canResend,
  }) {
    return VerifyOtpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      otp: otp ?? this.otp,
      resendTimer: resendTimer ?? this.resendTimer,
      canResend: canResend ?? this.canResend,
    );
  }
}

class VerifyOtpProvider extends StateNotifier<VerifyOtpState> {
  VerifyOtpProvider() : super(VerifyOtpState()) {
    _startResendTimer();
  }

  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  Timer? _resendTimer;

  void _startResendTimer() {
    _resendTimer?.cancel();
    state = state.copyWith(resendTimer: 43, canResend: false);

    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendTimer > 0) {
        state = state.copyWith(resendTimer: state.resendTimer - 1);
      } else {
        state = state.copyWith(canResend: true);
        timer.cancel();
      }
    });
  }

  void updateOtp(String value) {
    state = state.copyWith(otp: value, errorMessage: null);
  }

  Future<void> verifyOtp(String otp) async {
    if (otp.length != 4) {
      state = state.copyWith(errorMessage: 'Please enter a 4-digit code');
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // TODO: Implement your verify OTP logic here
      // Example: await authService.verifyOtp(otp);

      await Future.delayed(const Duration(seconds: 2)); // Simulating API call

      // For demo purposes, accept "1234" as valid OTP
      if (otp == "1234") {
        state = state.copyWith(isLoading: false);
        // Navigate to success/home screen
      } else {
        throw Exception('Invalid verification code');
      }

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Invalid verification code. Please try again.',
      );

      // Clear OTP field on error
      otpController.clear();
    }
  }

  Future<void> resendOtp() async {
    if (!state.canResend) {
      state = state.copyWith(
        errorMessage: 'Please wait before resending code',
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // TODO: Implement your resend OTP logic here
      // Example: await authService.resendOtp(email);

      await Future.delayed(const Duration(seconds: 1)); // Simulating API call

      state = state.copyWith(isLoading: false);

      // Restart timer
      _startResendTimer();

      // Show success message (you can add a success state if needed)

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to resend code. Please try again.',
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  String get formattedTimer {
    final minutes = state.resendTimer ~/ 60;
    final seconds = state.resendTimer % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    otpController.dispose();
    otpFocusNode.dispose();
    _resendTimer?.cancel();
    super.dispose();
  }
}

final verifyOtpProvider = StateNotifierProvider<VerifyOtpProvider, VerifyOtpState>(
      (ref) => VerifyOtpProvider(),
);