import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/utils/app_color.dart';
class EditProfile extends StatelessWidget {
   EditProfile({super.key});

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
                    SizedBox(width: 100.w,),
                    CustomText(text: "Edit Profile",textAlign: TextAlign.center,fontSize: 20.sp,fontWeight: FontWeight.w600,color: AppColor.white,)
                  ],
                ),
              ),
              SizedBox(height: 54.h,),
              Container(
                height: 450.h,


                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.h),
                decoration: BoxDecoration(

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
                    CustomText(text: "Full Name", fontWeight: FontWeight.w500,fontSize: 16.sp,textAlign: TextAlign.center,color: AppColor.textBody,),
                    SizedBox(height: 12.h,),
                    CustomTextFormField(controller: nameController, hintText: "Full Name"),
                    SizedBox(height: 16.h,),
                    CustomText(text: "Email", fontWeight: FontWeight.w500,fontSize: 16.sp,textAlign: TextAlign.center,color: AppColor.textBody,),
                    SizedBox(height: 12.h,),
                    CustomTextFormField(controller: nameController, hintText: "abc32@gmail.com"),
                    SizedBox(height: 16.h,),
                    CustomText(text: "Phone Number", fontWeight: FontWeight.w500,fontSize: 16.sp,textAlign: TextAlign.center,color: AppColor.textBody,),
                    SizedBox(height: 12.h,),
                    CustomTextFormField(controller: nameController, hintText: "+880 1517053529"),
                    SizedBox(height: 16.h,),

                  ],
                ),
              ),
              Spacer(),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomButton(text: "Save Changes", onPressed: (){})),
              SizedBox(height: 35.h,)
            ],
          )
        ],
      ),
    );
  }
}
