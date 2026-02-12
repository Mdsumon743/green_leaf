import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:saunders/features/customer_flow/invoice/presentation/widget/status_chip.dart';

import '../../../../../core/global/custom_text.dart';
import '../../../../../core/utils/app_color.dart';

class InvoiceCard extends StatelessWidget {
  final String amount;
  final String status;
  final String date;

  const InvoiceCard({
    required this.amount,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = status == "Paid";

    return GestureDetector(
      onTap: (){
        context.push("/invoiceDetails");
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Invoice: #2345",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
                CustomText(
                  text: amount,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.primary,
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: date,
                  fontSize: 13.sp,
                  color: AppColor.textBody.withValues(alpha: 0.7),
                ),
                StatusChip(status: status, isPaid: isPaid),
              ],
            ),
          ],
        ),
      ),
    );
  }
}