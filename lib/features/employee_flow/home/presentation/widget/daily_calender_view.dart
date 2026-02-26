import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saunders/features/employee_flow/home/presentation/widget/time_slot_row.dart';

import '../../model/service_data_model.dart';

class DailyCalendarView extends StatelessWidget {
  final DateTime date;
  final List<CustomerServiceModel> services;

  const DailyCalendarView({super.key, required this.date, required this.services});

  @override
  Widget build(BuildContext context) {
    // Filter services for the selected date (mock: show all pending for demo)
    final dayServices = services
        .where((s) => s.status == ServiceStatus.pending)
        .toList();

    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 40.h),
      itemCount: 12, // 8am to 8pm
      itemBuilder: (context, index) {
        final hour = 8 + index;
        final label = hour < 12
            ? '$hour:00 AM'
            : hour == 12
            ? '12:00 PM'
            : '${hour - 12}:00 PM';

        // Assign first service to 9am slot for demo
        final hasEvent = index == 1 && dayServices.isNotEmpty;
        final service = hasEvent ? dayServices.first : null;

        return TimeSlotRow(
          timeLabel: label,
          service: service,
        );
      },
    );
  }
}