import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/image_path.dart';
import '../../../../../core/global/custom_button.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';
import 'address_card.dart';

class AddressManagement extends StatelessWidget {
  const AddressManagement({super.key});

  @override
  Widget build(BuildContext context) {
    // Address data
    final addresses = [
      {
        'title': 'Home',
        'address': '61480 Sunbrook Park,\nPC 5679',
        'isDefault': true,
      },
      {
        'title': 'Office',
        'address': '61480 Sunbrook Park,\nPC 5679',
        'isDefault': false,
      },
      {
        'title': 'Apartment',
        'address': '61480 Sunbrook Park,\nPC 5679',
        'isDefault': false,
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.roleBackground,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Column(
            children: [
              SizedBox(
                height: 52.h,
              ),

              // Header with back button and title
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                    ),
                    CustomText(
                      text: "Address",
                      textAlign: TextAlign.center,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.white,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 54.h,
              ),

              // Main content area
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 24.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  decoration: BoxDecoration(
                    // Semi-transparent white background for the top portion
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColor.containerBackground.withOpacity(0.95),
                        AppColor.containerBackground.withOpacity(0.7),
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.6, 1.0],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.r),
                      topLeft: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Address list
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: addresses.length,
                        separatorBuilder: (context, index) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final address = addresses[index];
                          return AddressCard(
                            title: address['title'] as String,
                            address: address['address'] as String,
                            isDefault: address['isDefault'] as bool,
                          );
                        },
                      ),

                      Spacer(),

                      // Add New Address button
                      Container(
                        margin: EdgeInsets.only(bottom: 35.h),
                        child: CustomButton(
                          text: "Add New Address",
                          onPressed: () {
                            context.push('/addAddress');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}