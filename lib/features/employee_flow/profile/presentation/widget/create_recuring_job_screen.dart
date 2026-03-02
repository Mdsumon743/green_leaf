import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/utils/app_color.dart';

// ─────────────────────────────────────────────────────────────────────────────
// STATE
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
    bool clearNextOccurrence = false,
    bool clearStopDate = false,
    bool clearStartTime = false,
    bool clearFinishTime = false,
  }) {
    return CreateRecurringJobState(
      jobType: jobType ?? this.jobType,
      frequency: frequency ?? this.frequency,
      nextOccurrence:
      clearNextOccurrence ? null : nextOccurrence ?? this.nextOccurrence,
      stopDate: clearStopDate ? null : stopDate ?? this.stopDate,
      startTime: clearStartTime ? null : startTime ?? this.startTime,
      finishTime: clearFinishTime ? null : finishTime ?? this.finishTime,
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

class CreateRecurringJobNotifier
    extends StateNotifier<CreateRecurringJobState> {
  CreateRecurringJobNotifier() : super(const CreateRecurringJobState());

  void setJobType(String? v) => state = state.copyWith(jobType: v);
  void setFrequency(String? v) => state = state.copyWith(frequency: v);
  void setNextOccurrence(DateTime? v) =>
      state = state.copyWith(nextOccurrence: v);
  void setStopDate(DateTime? v) => state = state.copyWith(stopDate: v);
  void setStartTime(TimeOfDay? v) => state = state.copyWith(startTime: v);
  void setFinishTime(TimeOfDay? v) => state = state.copyWith(finishTime: v);
  void setDayOfWeekInMonth(String? v) =>
      state = state.copyWith(dayOfWeekInMonth: v);
  void setJobName(String v) => state = state.copyWith(jobName: v);
  void setCustomer(String? v) => state = state.copyWith(customer: v);
  void setDescription(String v) => state = state.copyWith(description: v);
  void setTaskName(String v) => state = state.copyWith(taskName: v);
  void setTaskDescription(String v) =>
      state = state.copyWith(taskDescription: v);
  void setStaff(String? v) => state = state.copyWith(staff: v);
}

final createRecurringJobProvider = StateNotifierProvider.autoDispose<
    CreateRecurringJobNotifier, CreateRecurringJobState>(
      (ref) => CreateRecurringJobNotifier(),
);

// ─────────────────────────────────────────────────────────────────────────────
// DATA
// ─────────────────────────────────────────────────────────────────────────────

const List<String> _jobTypes = [
  'Create & Schedule',
  'Create & Assign',
  'Create Only',
];

const List<String> _frequencies = [
  'Daily',
  'Monthly',
  'Yearly',
];

const List<String> _customers = [
  'Oliver Leo',
  'Emma Watson',
  'James Brown',
  'Sophia Miller',
  'Liam Johnson',
];



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
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImagePath.homeBackground,
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xDD1B5E20),
                    Color(0xAA2E7D32),
                    Color(0x551B5E20),
                  ],
                  stops: [0.0, 0.3, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // ── App Bar ─────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 38.r,
                          height: 38.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.7),
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: 'Recurring Jobs',
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

                // ── White sheet ─────────────────────────────────────────
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F7F3),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30.r),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: EdgeInsets.fromLTRB(
                                  16.w, 24.h, 16.w, 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ── Job Type ─────────────────────────
                                  _FieldLabel('Job Type'),
                                  SizedBox(height: 8.h),
                                  CustomDropdown(
                                    hint: 'Job Type',
                                    items: _jobTypes,
                                    value: state.jobType,
                                    onChanged: notifier.setJobType,
                                  ),

                                  SizedBox(height: 16.h),

                                  // ── Frequency ────────────────────────
                                  _FieldLabel('Frequency'),
                                  SizedBox(height: 8.h),
                                  CustomDropdown(
                                    hint: 'Frequency',
                                    items: _frequencies,
                                    value: state.frequency,
                                    onChanged: notifier.setFrequency,
                                  ),

                                  SizedBox(height: 16.h),

                                  // ── Next Occurrence ───────────────────
                                  _FieldLabel('Next Occurrence'),
                                  SizedBox(height: 8.h),
                                  _DateField(
                                    hint: '19 March 2026',
                                    value: state.nextOccurrence,
                                    onTap: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: state.nextOccurrence ??
                                            DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                        builder: _calendarTheme,
                                      );
                                      if (picked != null) {
                                        notifier.setNextOccurrence(picked);
                                      }
                                    },
                                  ),

                                  SizedBox(height: 16.h),

                                  // ── Stop Date ─────────────────────────
                                  _FieldLabel('Stop Date'),
                                  SizedBox(height: 8.h),
                                  _DateField(
                                    hint: 'Optional',
                                    value: state.stopDate,
                                    onTap: () async {
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: state.stopDate ??
                                            DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100),
                                        builder: _calendarTheme,
                                      );
                                      if (picked != null) {
                                        notifier.setStopDate(picked);
                                      }
                                    },
                                  ),

                                  SizedBox(height: 16.h),

                                  // ── Start Time + Finish Time ──────────
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            _FieldLabel('Start Time'),
                                            SizedBox(height: 8.h),
                                            _TimeField(
                                              hint: 'Start Time',
                                              value: state.startTime,
                                              onTap: () async {
                                                final picked =
                                                await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                  state.startTime ??
                                                      TimeOfDay.now(),
                                                  builder: _timeTheme,
                                                );
                                                if (picked != null) {
                                                  notifier
                                                      .setStartTime(picked);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            _FieldLabel('Finish Time'),
                                            SizedBox(height: 8.h),
                                            _TimeField(
                                              hint: 'Finish Time',
                                              value: state.finishTime,
                                              onTap: () async {
                                                final picked =
                                                await showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                  state.finishTime ??
                                                      TimeOfDay.now(),
                                                  builder: _timeTheme,
                                                );
                                                if (picked != null) {
                                                  notifier
                                                      .setFinishTime(picked);
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 16.h),

                                  // ── Day of week in month ──────────────
                                  _FieldLabel('Day of week in month'),
                                  SizedBox(height: 8.h),
                                  _InputField(
                                    hint: 'Day of week in month',
                                    onChanged: notifier.setDayOfWeekInMonth,
                                  ),

                                  SizedBox(height: 24.h),

                                  // ── Job Information section ───────────
                                  _SectionHeader('Job Information'),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Job Name'),
                                  SizedBox(height: 8.h),
                                  _InputField(
                                    hint: 'Job Name',
                                    onChanged: notifier.setJobName,
                                  ),

                                  SizedBox(height: 16.h),

                                  _FieldLabel('Customer'),
                                  SizedBox(height: 8.h),
                                  CustomDropdown(
                                    hint: 'Search Customer',
                                    items: _customers,
                                    value: state.customer,
                                    onChanged: notifier.setCustomer,
                                  ),

                                  SizedBox(height: 16.h),

                                  _FieldLabel('Description'),
                                  SizedBox(height: 8.h),
                                  _InputField(
                                    hint: 'Description',
                                    maxLines: 4,
                                    onChanged: notifier.setDescription,
                                  ),

                                  SizedBox(height: 24.h),

                                  // ── New Task section ──────────────────
                                  _SectionHeader('New Task'),
                                  SizedBox(height: 16.h),

                                  _FieldLabel('Task Name'),
                                  SizedBox(height: 8.h),
                                  _InputField(
                                    hint: 'Task Name',
                                    onChanged: notifier.setTaskName,
                                  ),

                                  SizedBox(height: 16.h),

                                  _FieldLabel('Description'),
                                  SizedBox(height: 8.h),
                                  _InputField(
                                    hint: 'Description',
                                    maxLines: 4,
                                    onChanged: notifier.setTaskDescription,
                                  ),

                                 /* SizedBox(height: 16.h),

                                  _FieldLabel('Staff'),
                                  SizedBox(height: 8.h),
                                  CustomDropdown(
                                    hint: 'Search Staff Name',
                                    items: _staffList,
                                    value: state.staff,
                                    onChanged: notifier.setStaff,
                                  ),*/

                                  SizedBox(height: 24.h),
                                ],
                              ),
                            ),
                          ),

                          // ── Submit button ───────────────────────────
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                20.w, 12.h, 20.w, 30.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F7F3),
                              border: Border(
                                top: BorderSide(
                                  color: const Color(0xFFDDE8DD),
                                  width: 1.h,
                                ),
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: ElevatedButton(
                                onPressed: () {
                                  // handle submit
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(12.r),
                                  ),
                                  elevation: 0,
                                ),
                                child: CustomText(
                                  text: 'Submit & Continue',
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
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

  // Calendar theme helper
  Widget _calendarTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF1A1A1A),
        ),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
      ),
      child: child!,
    );
  }

  // Time picker theme helper
  Widget _timeTheme(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          onPrimary: Colors.white,
          surface: Colors.white,
          onSurface: Color(0xFF1A1A1A),
        ),
        dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
      ),
      child: child!,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REUSABLE WIDGETS
// ─────────────────────────────────────────────────────────────────────────────

// Section header (e.g. "Job Information", "New Task")
class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: title,
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
      color: AppColor.textBody,
    );
  }
}

// Field label above inputs
class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: label,
      fontSize: 13.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.textBody.withValues(alpha: 0.75),
    );
  }
}

// Plain text input
class _InputField extends StatelessWidget {
  const _InputField({
    required this.hint,
    this.maxLines = 1,
    required this.onChanged,
  });

  final String hint;
  final int maxLines;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _fieldDecoration(),
      child: TextField(
        onChanged: onChanged,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColor.textBody,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 14.sp,
            color: AppColor.textBody.withValues(alpha: 0.4),
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        ),
      ),
    );
  }
}

// Date picker field
class _DateField extends StatelessWidget {
  const _DateField({
    required this.hint,
    required this.value,
    required this.onTap,
  });

  final String hint;
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final formatted = value != null
        ? DateFormat('dd MMMM yyyy').format(value!)
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _fieldDecoration(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: formatted ?? hint,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: formatted != null
                    ? AppColor.textBody
                    : AppColor.textBody.withValues(alpha: 0.4),
              ),
            ),
            Icon(
              Icons.calendar_today_outlined,
              size: 18.sp,
              color: AppColor.textBody.withValues(alpha: 0.45),
            ),
          ],
        ),
      ),
    );
  }
}

// Time picker field
class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.hint,
    required this.value,
    required this.onTap,
  });

  final String hint;
  final TimeOfDay? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final formatted = value?.format(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: _fieldDecoration(),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: formatted ?? hint,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: formatted != null
                    ? AppColor.textBody
                    : AppColor.textBody.withValues(alpha: 0.4),
              ),
            ),
            Icon(
              Icons.access_time_rounded,
              size: 18.sp,
              color: AppColor.textBody.withValues(alpha: 0.45),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom dropdown
class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final String hint;
  final List<String> items;
  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _fieldDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.textBody.withValues(alpha: 0.4),
              fontWeight: FontWeight.w400,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColor.textBody.withValues(alpha: 0.5),
            size: 22.sp,
          ),
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColor.textBody,
            fontWeight: FontWeight.w400,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// Shared field decoration
BoxDecoration _fieldDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.r),
    border: Border.all(
      color: const Color(0xFFDDE8DD),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.04),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  );
}