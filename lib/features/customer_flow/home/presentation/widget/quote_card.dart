import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuoteCard extends StatelessWidget {
  final String name;
  final String category;
  final String status;
  final String price;
  final VoidCallback onPressed;

  const QuoteCard({
    Key? key,
    required this.name,
    required this.category,
    required this.status,
    required this.price,
    required this.onPressed,
  }) : super(key: key);

  Color _getStatusBgColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFFF3E0); // Light orange background
      case 'approved':
        return const Color(0xFFE8F5E9); // Light green background
      case 'completed':
        return const Color(0xFFE3F2FD); // Light blue background
      case 'cancelled':
        return const Color(0xFFFFEBEE); // Light red background
      default:
        return const Color(0xFFFFF3E0);
    }
  }

  Color _getStatusTextColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFFFFA726); // Orange text
      case 'approved':
        return const Color(0xFF66BB6A); // Green text
      case 'completed':
        return const Color(0xFF42A5F5); // Blue text
      case 'cancelled':
        return const Color(0xFFEF5350); // Red text
      default:
        return const Color(0xFFFFA726);
    }
  }

  Color _getButtonColor() {
    switch (status.toLowerCase()) {
      case 'pending':
        return const Color(0xFF66BB6A); // Green button for pending
      case 'approved':
        return const Color(0xFF66BB6A); // Green button for approved
      case 'completed':
        return const Color(0xFF42A5F5); // Blue button for completed
      case 'cancelled':
        return const Color(0xFF9E9E9E); // Gray button for cancelled
      default:
        return const Color(0xFF66BB6A);
    }
  }

  String _getButtonText() {
    switch (status.toLowerCase()) {
      case 'approved':
        return 'View Details';
      default:
        return 'View Details';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Status Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: _getStatusBgColor(),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: _getStatusTextColor(),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Quote and Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                category,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF666666),
                ),
              ),
              Text(
                price,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF27AE60),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // View Details Button
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: _getButtonColor(),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.zero,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getButtonText(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.arrow_forward,
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}