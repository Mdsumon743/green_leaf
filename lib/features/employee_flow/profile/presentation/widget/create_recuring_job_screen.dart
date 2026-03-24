import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATE & NOTIFIER
// ─────────────────────────────────────────────────────────────────────────────

class CreateRecurringJobState {
  final String? jobType;
  final String? frequency;
  final DateTime? nextOccurrence;
  final DateTime? stopDate;
  final TimeOfDay? startTime;
  final TimeOfDay? finishTime;
  final String? dayOfWeekInMonth;
  final String jobName;
  final String? customer;
  final String description;
  final String taskName;
  final String taskDescription;
  final String? staff;

  const CreateRecurringJobState({
    this.jobType,
    this.frequency,
    this.nextOccurrence,
    this.stopDate,
    this.startTime,
    this.finishTime,
    this.dayOfWeekInMonth,
    this.jobName = '',
    this.customer,
    this.description = '',
    this.taskName = '',
    this.taskDescription = '',
    this.staff,
  });

  CreateRecurringJobState copyWith({
    String? jobType,
    String? frequency,
    DateTime? nextOccurrence,
    DateTime? stopDate,
    TimeOfDay? startTime,
    TimeOfDay? finishTime,
    String? dayOfWeekInMonth,
    String? jobName,
    String? customer,
    String? description,
    String? taskName,
    String? taskDescription,
    String? staff,
  }) {
    return CreateRecurringJobState(
      jobType: jobType ?? this.jobType,
      frequency: frequency ?? this.frequency,
      nextOccurrence: nextOccurrence ?? this.nextOccurrence,
      stopDate: stopDate ?? this.stopDate,
      startTime: startTime ?? this.startTime,
      finishTime: finishTime ?? this.finishTime,
      dayOfWeekInMonth: dayOfWeekInMonth ?? this.dayOfWeekInMonth,
      jobName: jobName ?? this.jobName,
      customer: customer ?? this.customer,
      description: description ?? this.description,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      staff: staff ?? this.staff,
    );
  }
}

class CreateRecurringJobNotifier extends StateNotifier<CreateRecurringJobState> {
  CreateRecurringJobNotifier() : super(const CreateRecurringJobState());

  void setJobType(String? v) => state = state.copyWith(jobType: v);
  void setFrequency(String? v) => state = state.copyWith(frequency: v);
  void setNextOccurrence(DateTime? v) => state = state.copyWith(nextOccurrence: v);
  void setStopDate(DateTime? v) => state = state.copyWith(stopDate: v);
  void setStartTime(TimeOfDay? v) => state = state.copyWith(startTime: v);
  void setFinishTime(TimeOfDay? v) => state = state.copyWith(finishTime: v);
  void setDayOfWeekInMonth(String? v) => state = state.copyWith(dayOfWeekInMonth: v);
  void setJobName(String v) => state = state.copyWith(jobName: v);
  void setCustomer(String? v) => state = state.copyWith(customer: v);
  void setDescription(String v) => state = state.copyWith(description: v);
  void setTaskName(String v) => state = state.copyWith(taskName: v);
  void setTaskDescription(String v) => state = state.copyWith(taskDescription: v);
}

final createRecurringJobProvider = StateNotifierProvider.autoDispose<CreateRecurringJobNotifier, CreateRecurringJobState>(
      (ref) => CreateRecurringJobNotifier(),
);

// ─────────────────────────────────────────────────────────────────────────────
// SCREEN
// ─────────────────────────────────────────────────────────────────────────────

class CreateRecurringJobScreen extends ConsumerWidget {
  const CreateRecurringJobScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(createRecurringJobProvider.notifier);
    final state = ref.watch(createRecurringJobProvider);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Top Role Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 250.h,
            child: Image.asset(ImagePath.roleBackground, fit: BoxFit.cover),
          ),

          // 2. Bottom Garden Background
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              ImagePath.homeBackground,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // AppBar
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      _CircleBackButton(onTap: () => context.pop()),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: 'Create Recurring Job',
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(width: 38.r),
                    ],
                  ),
                ),

                // 3. Curved Form Sheet
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
                            AppColor.containerBackground.withOpacity(0.85),
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.6, 0.85, 1.0],
                        ),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(16.w, 60.h, 16.w, 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _FieldLabel('Job Type'),
                                  CustomDropdown(
                                    hint: 'Job Type',
                                    items: const ['Create & Schedule', 'Create & Assign', 'Create Only'],
                                    value: state.jobType,
                                    onChanged: notifier.setJobType,
                                  ),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Frequency'),
                                  CustomDropdown(
                                    hint: 'Frequency',
                                    items: const ['Daily', 'Monthly', 'Yearly'],
                                    value: state.frequency,
                                    onChanged: notifier.setFrequency,
                                  ),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Next Occurrence'),
                                  _DateField(
                                    hint: 'Select Date',
                                    value: state.nextOccurrence,
                                    onTap: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null) notifier.setNextOccurrence(picked);
                                    },
                                  ),
                                  SizedBox(height: 16.h),

                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _FieldLabel('Start Time'),
                                            _TimeField(
                                              hint: 'Start Time',
                                              value: state.startTime,
                                              onTap: () async {
                                                final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                                if (picked != null) notifier.setStartTime(picked);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _FieldLabel('Finish Time'),
                                            _TimeField(
                                              hint: 'Finish Time',
                                              value: state.finishTime,
                                              onTap: () async {
                                                final picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                                                if (picked != null) notifier.setFinishTime(picked);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 16.h),
                                  _FieldLabel("Day of week in month"),
                                  _InputField(hint: "Day of week in month",
                                      onChanged: notifier.setDayOfWeekInMonth,
                                  ),
                                  SizedBox(height: 24.h),
                                  
                                  _SectionHeader('Job Information'),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Job Name'),
                                  _InputField(hint: 'Job Name', onChanged: notifier.setJobName),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Customer'),
                                  CustomDropdown(hint: "Search Customer", items: ["1","2","3"], onChanged: notifier.setCustomer),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Description'),
                                  _InputField(hint: 'Description', maxLines: 3, onChanged: notifier.setDescription),
                                  SizedBox(height: 24.h),

                                  _SectionHeader('New Task'),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Task Name'),
                                  _InputField(hint: 'Task Name', maxLines: 1, onChanged: notifier.setTaskName),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Description'),
                                  _InputField(hint: 'Description', maxLines: 3, onChanged: notifier.setTaskDescription),
                                  SizedBox(height: 24.h),
                                ],
                              ),
                            ),
                          ),

                          // 4. Submit Button with Custom Gradient
                          Padding(
                            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 40.h),
                            child: CustomSubmitButton(
                              text: 'Submit & Continue',
                              onTap: () {
                                // Logic for submission
                              },
                            ),
                          ),
                        ],
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

// ─────────────────────────────────────────────────────────────────────────────
// REUSABLE SUB-WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

class CustomSubmitButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomSubmitButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 52.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF348317), Color(0xFF9DC167)],
          ),
        ),
        padding: EdgeInsets.all(1.w), // Border width
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.r),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF8CC40F), Color(0xFF126A19)],
            ),
          ),
          child: Center(
            child: CustomText(
              text: text,
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleBackButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CircleBackButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: CustomText(
        text: label,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final ValueChanged<String> onChanged;
  const _InputField({required this.hint, this.maxLines = 1, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _fieldDeco(),
      child: TextField(
        onChanged: onChanged,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(14.r),
          hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14.sp),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String hint;
  final DateTime? value;
  final VoidCallback onTap;
  const _DateField({required this.hint, this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _fieldDeco(),
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: value != null ? DateFormat('dd MMMM yyyy').format(value!) : hint,
                fontSize: 14.sp,
                color: value != null ? AppColor.textBody : Colors.grey.shade400,
              ),
            ),
            Icon(Icons.calendar_today_outlined, size: 18.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  final String hint;
  final TimeOfDay? value;
  final VoidCallback onTap;
  const _TimeField({required this.hint, this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _fieldDeco(),
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: value != null ? value!.format(context) : hint,
                fontSize: 14.sp,
                color: value != null ? AppColor.textBody : Colors.grey.shade400,
              ),
            ),
            Icon(Icons.access_time_rounded, size: 18.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;
  const CustomDropdown({super.key, required this.hint, required this.items, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _fieldDeco(),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: CustomText(text: hint, fontSize: 14.sp, color: Colors.grey.shade400),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);
  @override
  Widget build(BuildContext context) {
    return CustomText(text: title, fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.black);
  }
}

BoxDecoration _fieldDeco() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Color(0xFF055726).withValues(alpha: 0.4),
        blurRadius: 6
      )
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.r),
    border: Border.all(color: const Color(0xFFB6BAC3),width: 1),
  );
}