import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

class VisiteCard extends StatelessWidget {
  const VisiteCard({
    super.key,
    required this.image,
    required this.title,
    required this.address,
    required this.date,
    required this.worker,
    this.reminder,
    this.status,
  });

  final String image;
  final String title;
  final String address;
  final String date;
  final String worker;
  final String? reminder;
  final String? status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColor.containerBorder,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: date,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.textBody.withOpacity(0.6),
          ),
          SizedBox(height: 10.h,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Visit Image ───────────────────────────────────────────────
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  image,
                  width: 90.w,   // Adjusted slightly for better ratio
                  height: 110.h,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(width: 12.w),

              // ── Visit Details ─────────────────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                    SizedBox(height: 8.h),
                    CustomText(
                      text: address,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF4A4E5A),
                    ),
                  ],
                ),
              ),
              if (status != null && status!.isNotEmpty)
                _buildBadge(
                  text: status!,
                  bgColor: const Color(0xFFFAAD14),
                  textColor: const Color(0xFFE8F5E9),
                ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: ()=>context.push("/visitDetails"),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                width: MediaQuery.of(context).size.width * 0.60.w,
                decoration: BoxDecoration(
                    color: Color(0xFF11A41C).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(8.r),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withValues(alpha: 0.1),
                       offset: const Offset(0, 1),
                       blurRadius: 4
                     )
                   ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                      text: "View Details",
                      color: Color(0xFF0D5212),
                    ),
                    SizedBox(width: 8.w,),
                    Icon(Icons.keyboard_arrow_down_outlined,size: 18.r,color: Color(0xFF0D5212),),
                    SizedBox(width: 8.w,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build consistent tags/badges
  Widget _buildBadge({required String text, required Color bgColor, required Color textColor}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: CustomText(
        text: text,
        fontSize: 11.sp,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }
}