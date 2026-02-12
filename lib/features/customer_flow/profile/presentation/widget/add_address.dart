

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';
class AddAddress extends StatelessWidget {
  AddAddress({super.key});

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Opacity(
                  opacity: 0.7,
                  child: Image.asset(ImagePath.roleBackground, fit: BoxFit.cover,))),
          Column(
            children: [
              SizedBox(height: 52.h,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        context.pop();
                      },
                      child: Icon(Icons.arrow_back, color: AppColor.white,),
                    ),
                    SizedBox(width: 80.w,),
                    CustomText(text: "Add New Address",textAlign: TextAlign.center,fontSize: 20.sp,fontWeight: FontWeight.w600,color: AppColor.white,)
                  ],
                ),
              ),
              SizedBox(height: 54.h,),
              Container(
                height: 450.h,


                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.h),
                decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
    Colors.white,
    Colors.white.withValues(alpha: 0.95),
    Colors.white.withValues(alpha: 0.7),
    Colors.transparent,
    ],
    stops: [0.0, 0.5, 0.8, 1.0],
    ),

                    color: AppColor.containerBackground,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.r),
                      topLeft: Radius.circular(50.r),
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r),

                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(text: "Title", fontWeight: FontWeight.w500,fontSize: 16.sp,textAlign: TextAlign.center,color: AppColor.textBody,),
                    SizedBox(height: 12.h,),
                    CustomTextFormField(controller: nameController, hintText: "Home"),
                    SizedBox(height: 16.h,),
                    CustomText(text: "Street Address", fontWeight: FontWeight.w500,fontSize: 16.sp,textAlign: TextAlign.center,color: AppColor.textBody,),
                    SizedBox(height: 12.h,),
                    CustomTextFormField(controller: nameController, hintText: "Street Address"),
                    SizedBox(height: 16.h,),
                    CustomText(text: "City", fontWeight: FontWeight.w500,fontSize: 16.sp,textAlign: TextAlign.center,color: AppColor.textBody,),
                    SizedBox(height: 12.h,),
                    CustomTextFormField(controller: nameController, hintText: "city"),
                    SizedBox(height: 16.h,),
                    CustomText(text: "PostCode", fontWeight: FontWeight.w500,fontSize: 16.sp,textAlign: TextAlign.center,color: AppColor.textBody,),
                    SizedBox(height: 12.h,),
                    CustomTextFormField(controller: nameController, hintText: "postcode"),
                    SizedBox(height: 16.h,),

                  ],
                ),
              ),
              Spacer(),

              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomButton(
                          textColor: AppColor.primary,
                          isOutlined: true,
                          backgroundColor: AppColor.white,
                            text: "Cancel", onPressed: (){})),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomButton(text: "Add Address", onPressed: (){})),
                  ),
                ],
              ),
              SizedBox(height: 35.h,)
            ],
          )
        ],
      ),
    );
  }
}
