

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';

class InvoiceDetailsScreen extends StatelessWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// ================= Background Images =================
          Column(
            children: [
              /// Top Background
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(ImagePath.visitBackground),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              /// Bottom Background
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImagePath.homeBackground),
                      fit: BoxFit.cover,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// ================= Overlay =================
          Column(
            children: [
              Container(
                height: 200.h,
                color: AppColor.primary.withValues(alpha: 0.7),
              ),
              Expanded(
                child: Container(
                  color: const Color(0xFFF5FFF2).withValues(alpha: 0.95),
                ),
              ),
            ],
          ),

          /// ================= Content =================
          SafeArea(
            child: Column(
              children: [
                /// ================= Header =================
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      CustomText(
                        text: "View Details",
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                /// ================= Content Card =================
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5FFF2),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(28.r),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ================= Quote Icon & Number =================
                            Center(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16.r),
                                    decoration: BoxDecoration(
                                      color: AppColor.primary.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.description_outlined,
                                      color: AppColor.primary,
                                      size: 32.sp,
                                    ),
                                  ),
                                  SizedBox(height: 12.h),
                                  CustomText(
                                    text: "Invoice: #1024",
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.textBody,
                                  ),
                                  SizedBox(height: 4.h),
                                  CustomText(
                                    text: "Garden Maintenance",
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.textBody.withValues(alpha: 0.6),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 32.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "Total Price", fontWeight: FontWeight.w400,fontSize: 14.sp,color: AppColor.textBody,),
                                CustomText(text: "€ 120.00", fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColor.socialLogoColor,)

                              ],
                            ),

                            SizedBox(height: 18.h,),
                            /// list generate to create dash border
                            SizedBox(height: 10.h),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 5.w),
                              child: DottedDivider(
                                color: AppColor.primary,
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "Due Date", fontWeight: FontWeight.w400,fontSize: 14.sp,color: AppColor.textBody,),
                                CustomText(text: "Jan 15, 2026", fontSize: 16.sp,fontWeight: FontWeight.w600,color: AppColor.black,)

                              ],
                            ),

                            SizedBox(height: 18.h,),
                            /// list generate to create dash border
                            SizedBox(height: 10.h),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              child: DottedDivider(
                                color: AppColor.primary,
                              ),
                            ),
                            SizedBox(height: 18.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: "Status", fontWeight: FontWeight.w400,fontSize: 14.sp,color: AppColor.textBody,),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                  decoration: BoxDecoration(
                                    color: AppColor.primary.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8.r)
                                  ),
                                  margin: EdgeInsets.symmetric(
                                    
                                  ),
                                    child: CustomText(text: "paid", fontSize: 12.sp,fontWeight: FontWeight.w400,color: AppColor.socialLogoColor,))

                              ],
                            ),

                            SizedBox(height: 18.h,),
                            /// list generate to create dash border
                            SizedBox(height: 10.h),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20.w),
                              child: DottedDivider(
                                color: AppColor.primary,
                              ),
                            ),
                            SizedBox(height: 18.h),





                            SizedBox(height: 40.h),

                            /// ================= Job Complete Button =================
                            SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: ElevatedButton(
                                onPressed: (){
                                  context.push("/paymentScreen");
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: "Pay Now",
                                      color: Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(width: 8.w),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DottedDivider extends StatelessWidget {
  final double height;
  final Color color;

  const DottedDivider({
    super.key,
    this.height = 1,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final dashWidth = 4.w;
        final dashSpace = 4.w;
        final dashCount =
        (constraints.maxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (index) {
            return Container(
              width: dashWidth,
              height: height,
              color: color,
            );
          }),
        );
      },
    );
  }
}

