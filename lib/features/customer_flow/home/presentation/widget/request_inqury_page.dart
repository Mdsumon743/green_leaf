import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/constants/image_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';
import '../../../../../core/global/custom_dropdown.dart';
import '../../provider/request_inquiry_provider.dart';
import 'dart:ui';

class RequestInquiryPage extends ConsumerWidget {
  const RequestInquiryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(requestInquiryProvider);
    final notifier = ref.read(requestInquiryProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          /// ===== Background Image =====
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.homeBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// ===== Blur + Dark Overlay =====
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(
              color: Colors.black.withOpacity(0.35),
            ),
          ),

          /// ===== Main Content =====
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),

                /// ===== Header =====
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: CustomText(
                            text: "Send Enquiry",
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 24.w),
                    ],
                  ),
                ),

                SizedBox(height: 120.h),

                /// ===== Form Container =====
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3FFF0),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.r),
                      topRight: Radius.circular(50.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      _label("Service Required"),
                      CustomDropdownField(
                        hint: "Please Choose...",
                        value: state.service,
                        onTap: () => _showServiceSheet(context, ref),
                      ),

                      SizedBox(height: 20.h),

                      _label("Preferred Date"),
                      CustomDropdownField(
                        hint: "Select Date...",
                        value: state.dateTime == null
                            ? null
                            : DateFormat('dd MMM yyyy • hh:mm a')
                            .format(state.dateTime!),
                        onTap: () => _pickDateTime(context, ref),
                      ),

                      SizedBox(height: 20.h),

                      _label("Your Message"),
                      CustomTextFormField(
                        controller: notifier.descriptionController,
                        maxLines: 4,
                        hintText: "Describe what you need help with...",
                        onChanged: notifier.updateMessage,
                      ),

                      SizedBox(height: 30.h),

                      CustomButton(
                        text: "Submit Enquiry",
                        suffixIcon: Icons.arrow_forward_ios,
                        textColor: AppColor.white,
                        onPressed: () {
                          showCustomDialog(
                            context,
                            imagePath: IconPath.success,
                            title: "Quote Submitted Confirmation",
                            buttonText: "Done",
                            onPressed: () {
                              context.pop();
                            },
                          );
                        },
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: CustomText(
      text: text,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
    ),
  );

  /// ===== Service Picker =====
  void _showServiceSheet(BuildContext context, WidgetRef ref) {
    final services = [
      'Lawn Mowing',
      'Garden Cleaning',
      'Tree Trimming',
      'Landscaping',
    ];

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => ListView(
        children: services
            .map(
              (e) => ListTile(
            title: Text(e),
            onTap: () {
              ref
                  .read(requestInquiryProvider.notifier)
                  .selectService(e);
              Navigator.pop(context);
            },
          ),
        )
            .toList(),
      ),
    );
  }

  /// ===== Date & Time Picker =====
  Future<void> _pickDateTime(
      BuildContext context, WidgetRef ref) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    ref.read(requestInquiryProvider.notifier).selectDateTime(
      DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      ),
    );
  }
}


