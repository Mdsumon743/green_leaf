import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/features/authentication/presentation/screen/forgot_password_otp_verification.dart';
import 'package:saunders/features/authentication/presentation/screen/login_screen.dart';
import 'package:saunders/features/authentication/presentation/screen/reset_password_email_screen.dart';
import 'package:saunders/features/authentication/presentation/screen/sign_up_screen.dart';
import 'package:saunders/features/authentication/presentation/screen/verification_code_screen.dart';
import 'package:saunders/features/customer_flow/home/presentation/screen/my_quote_page.dart';
import 'package:saunders/features/customer_flow/home/presentation/widget/quote_details_screen.dart';
import 'package:saunders/features/customer_flow/home/presentation/widget/request_inqury_page.dart';
import 'package:saunders/features/customer_flow/invoice/presentation/screen/invoice_screen.dart';
import 'package:saunders/features/customer_flow/invoice/presentation/widget/invoice_details_screen.dart';
import 'package:saunders/features/customer_flow/invoice/presentation/widget/payment_system.dart';
import 'package:saunders/features/customer_flow/message/presentation/screen/chat_screen.dart';
import 'package:saunders/features/customer_flow/navigation/presentation/screen/customer_nav_bar.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/add_address.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/address_management.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/change_password.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/edit_profile.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/gallery_screen.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/gardening_tips.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/refer_history.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/referal_screen.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/review_history.dart';
import 'package:saunders/features/customer_flow/profile/presentation/widget/system_setting.dart';
import 'package:saunders/features/customer_flow/visits/presentation/screen/visit_screen.dart';
import 'package:saunders/features/customer_flow/visits/presentation/widget/map_view.dart';
import 'package:saunders/features/customer_flow/visits/presentation/widget/visit_details_screen.dart';
import 'package:saunders/features/notification/model/presentation/screen/notification_screen.dart';
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
      GoRoute(path: '/forgotPasswordOtp', builder: (context, state)=>ForgotPasswordOtpVerificationCodeScreen()),
      GoRoute(path: '/customerNav', builder: (context, state)=>CustomerNavBar()),
      GoRoute(path: '/visit', builder: (context, state)=>VisitScreen()),
      GoRoute(path: '/invoice', builder: (context, state)=>InvoiceScreen()),
      GoRoute(path: '/requestInquiry', builder: (context, state)=>RequestInquiryPage()),
      GoRoute(path: '/notification', builder: (context, state)=>NotificationScreen()),
      GoRoute(path: '/visitDetails', builder: (context, state)=>VisitDetailsScreen()),
      GoRoute(path: '/mapView', builder: (context, state)=>MapView()),
      GoRoute(path: '/chat', builder: (context, state)=>ChatScreen()),
      GoRoute(path: '/invoiceDetails', builder: (context, state)=>InvoiceDetailsScreen()),
      GoRoute(path: '/paymentScreen', builder: (context, state)=>PaymentScreen()),
      GoRoute(path: '/editProfile', builder: (context, state)=>EditProfile()),
      GoRoute(path: '/address', builder: (context, state)=>AddressManagement()),
      GoRoute(path: '/system', builder: (context, state)=>SystemSetting()),
      GoRoute(path: '/gardening', builder: (context, state)=>GardeningTips()),
      GoRoute(path: '/refer', builder: (context, state)=>ReferalScreen()),
      GoRoute(path: '/review', builder: (context, state)=>ReviewHistory()),
      GoRoute(path: '/gallery', builder: (context, state)=>GalleryScreen()),
      GoRoute(path: '/addAddress', builder: (context, state)=>AddAddress()),
      GoRoute(path: '/referHistory', builder: (context, state)=>ReferHistory()),
      GoRoute(path: '/changePassword', builder: (context, state)=>ChangePasswordScreen()),
    ],
  );
});
