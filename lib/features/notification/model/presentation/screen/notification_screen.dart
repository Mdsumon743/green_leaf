import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/utils/app_color.dart'; // Ensure this is imported

import '../../../provider/notification_provider.dart';
import '../../app_notification.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// 1. TOP BACKGROUND IMAGE
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                ImagePath.roleBackground, // Standardized background
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// 2. BOTTOM BACKGROUND IMAGE (Garden)
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.myQuotesDetailsBottumBG, // Standardized bottom background
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),

          /// 3. MAIN UI
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.h),

              /// AppBar (Centered Title)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 34.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        child: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Notification",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 34.w), // Balance for back icon
                  ],
                ),
              ),

              SizedBox(height: 25.h),

              /// 4. Curved Notification Container
              Expanded(
                child: ClipPath(
                  clipper: CurveClipper(),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.containerBackground,
                          AppColor.containerBackground,
                          AppColor.containerBackground.withValues(alpha: 0.85),
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.65, 0.8, 1.0],
                      ),
                    ),
                    child: ListView.separated(
                      // Top padding (60.h) ensures items don't hide under the curve peak
                      padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 100.h),
                      itemCount: notifications.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.black.withValues(alpha: 0.05),
                        height: 24.h,
                      ),
                      itemBuilder: (context, index) {
                        final item = notifications[index];
                        return GestureDetector(
                          onTap: () => ref.read(notificationProvider.notifier).markAsRead(index),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// ===== Icon =====
                              Container(
                                height: 42.h,
                                width: 42.w,
                                padding: EdgeInsets.all(8.r),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF2E7D32),
                                ),
                                child: Image.asset(
                                  IconPath.notification1,
                                  height: 24.h,
                                  width: 24.w,
                                ),
                              ),
                              SizedBox(width: 12.w),

                              /// ===== Text =====
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "Appointment: ${DateFormat('dd-MM-yyyy, hh:mm a').format(item.dateTime)}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    RichText(
                                      text: TextSpan(
                                        text: "Status: ",
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black54,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: item.status.name.toUpperCase(),
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: _statusColor(item.status),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// ===== Unread Dot =====
                              if (!item.isRead)
                                Container(
                                  margin: EdgeInsets.only(top: 6.h),
                                  height: 8.r,
                                  width: 8.r,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Color _statusColor(NotificationStatus status) {
    switch (status) {
      case NotificationStatus.pending:
        return Colors.orange;
      case NotificationStatus.confirmed:
        return Colors.green;
      case NotificationStatus.declined:
        return Colors.red;
    }
  }
}