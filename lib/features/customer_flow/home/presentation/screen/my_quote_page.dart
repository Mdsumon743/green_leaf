import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/core/constants/image_path.dart';

import '../../../../onboarding/providers/role_selection_provider.dart';
import '../../provider/quote_provider.dart';
import '../widget/quote_card.dart';
import 'package:go_router/go_router.dart';


class MyQuotePage extends ConsumerWidget {
  const MyQuotePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotes = ref.watch(quotesProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.asset(
            ImagePath.quoteBackground, // Update with your ImagePath.quoteBackground
            fit: BoxFit.cover,
          ),

          // Dark Overlay
          Container(
            color: Colors.black.withValues(alpha: 0.35),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          child: Icon(
                            Icons.arrow_back,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'My Quotes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w), // Balance the back button
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Quotes List
                Expanded(
                  child: quotes.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 64.sp,
                          color: Colors.white.withValues(alpha: 0.7),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No quotes available',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                      : ListView.builder(
                    padding: EdgeInsets.only(
                      top: 8.h,
                      bottom: 24.h,
                    ),
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      final quote = quotes[index];
                      return QuoteCard(
                        name: quote.name,
                        category: quote.category,
                        status: quote.statusText,
                        price: quote.formattedPrice,
                        onPressed: () {
                          ref.read(selectedRoleProvider.notifier).state =
                              UserRole.customer;
                          context.push("/quoteDetails");
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 10.h,),

                // Awaiting Approval Button at the bottom
      Container(
        margin: EdgeInsets.only(left: 200.w, right: 20.w),
        child: SizedBox(
          height: 48.h,
          child: Container(
            padding: EdgeInsets.all(2), // Border thickness (2px)
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF9DC167), // Border gradient start
                  Color(0xFF348317), // Border gradient end
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r), // 8 - 2 padding
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF126A19), // Background gradient start
                    Color(0xFF8CC40F), // Background gradient end
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(6.r),
                  onTap: () {
                    // Handle awaiting approval action
                  },
                  child: Center(
                    child: Text(
                      'Awaiting Approval',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
              ],
            ),
          ),
        ],
      ),
    );
  }




}