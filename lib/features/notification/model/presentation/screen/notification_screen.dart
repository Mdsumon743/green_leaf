import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';

import '../../../provider/notification_provider.dart';
import '../../app_notification.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider);

    return Scaffold(
      body: Stack(
        children: [
          /// ===== Background Image =====
          /// ===== Background Images =====
          Stack(
            children: [
              // Top Background Image
              Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  ImagePath.notificationTopBG,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),

              // Bottom Background Image
              Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  ImagePath.homeBackground,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),

          /// ===== Content =====
          SafeArea(
            child: Column(
              children: [
                /// ===== Header =====
                Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap:(){
                          context.pop();

          },
                          child: const Icon(Icons.arrow_back, color: Colors.white)),
                      const Spacer(),
                      const Text(
                        "Notification",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// ===== Notification Container =====
                Expanded(
                  child: ShaderMask(
                    blendMode: BlendMode.dstIn,
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black, Colors.transparent],
                        stops: [0.75, 1.0],
                      ).createShader(bounds);
                    },
                    child: ClipPath(
                      clipper: CurveClipper(),
                      child: Container(
                        padding: const EdgeInsets.only(top: 60),
                        decoration: const BoxDecoration(
                          color: Color(0xFFF3FFF0),
                        ),
                        child: ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final item = notifications[index];
                            return GestureDetector(
                              onTap: () {
                                ref
                                    .read(notificationProvider.notifier)
                                    .markAsRead(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
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
                                    const SizedBox(width: 12),

                                    /// ===== Text =====
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "Appointment: ${DateFormat('dd-MM-yyyy, hh:mm a').format(item.dateTime)}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          RichText(
                                            text: TextSpan(
                                              text: "Status: ",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: item.status
                                                      .name
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: _statusColor(
                                                        item.status),
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
                                        margin: const EdgeInsets.only(top: 6),
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
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
