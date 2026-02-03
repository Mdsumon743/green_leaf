import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/features/onboarding/presentation/screen/customer_onboarding.dart';
import 'package:saunders/features/onboarding/presentation/screen/role_selection_screen.dart';

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
      builder: (context, state)=> const CustomerOnboarding())
    ],
  );
});
