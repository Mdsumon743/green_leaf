import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipSection extends StatelessWidget {
  final String title;
  final List<String> tips;
  final bool isExpanded;
  final VoidCallback onToggle;

  const TipSection({
    super.key,
    required this.title,
    required this.tips,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    size: 20.sp,
                    color: Colors.black87,
                  ),
                ],
              ),
            ),
          ),

          // Expandable content
          if (isExpanded)
            Container(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tips.map((tip) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 8.h, right: 8.w),
                          width: 4.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.black87,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            tip,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black87,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}