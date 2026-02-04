import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/features/authentication/presentation/screen/login_screen.dart';
import 'package:saunders/features/authentication/presentation/screen/reset_password_email_screen.dart';
import 'package:saunders/features/authentication/presentation/screen/sign_up_screen.dart';
import 'package:saunders/features/authentication/presentation/screen/verification_code_screen.dart';
import 'package:saunders/features/customer_flow/home/presentation/screen/my_quote_page.dart';
import 'package:saunders/features/customer_flow/home/presentation/widget/quote_details_screen.dart';
import 'package:saunders/features/onboarding/presentation/screen/customer_onboarding.dart';
import 'package:saunders/features/onboarding/presentation/screen/role_selection_screen.dart';

import '../features/authentication/presentation/screen/reset_password_screen.dart';
import '../features/splash/presentation/screen/splash_screen.dart';

import '../features/splash/provider/splash_state_provider.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final isLoading = ref.watch(splashProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final location = state.uri.toString();

      if (isLoading) {
        // While loading, stay on splash
        if (location != '/splash') return '/splash';
      } else {
        // After loading, navigate to onboarding if still on splash
        if (location == '/splash') return '/roleSelection';
      }


      return null; // no redirect
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/roleSelection',
        builder: (context, state) => const RoleSelectionScreen(),
      ),
      GoRoute(path: "/customerOnBoarding",
      builder: (context, state)=> const CustomerOnboarding()),
      GoRoute(path: '/myQuote', builder: (context, state)=>MyQuotePage()),
      GoRoute(path: '/quoteDetails', builder: (context, state)=>QuoteDetailsScreen()),
      GoRoute(path: '/login', builder: (context, state)=>LoginScreen()),
      GoRoute(path: '/signUp', builder: (context, state)=>SignUpScreen()),
      GoRoute(path: '/verificationCode', builder: (context, state)=>VerificationCodeScreen()),
      GoRoute(path: '/resetPassword', builder: (context, state)=>ResetPasswordEmailScreen()),
      GoRoute(path: '/resetPasswordScreen', builder: (context, state)=>ResetPasswordScreen()),
    ],
  );
});
