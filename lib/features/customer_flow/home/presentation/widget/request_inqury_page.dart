import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'package:saunders/core/constants/icon_path.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_dropdown.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';
import 'package:saunders/features/customer_flow/home/presentation/widget/section_header.dart';

import '../../provider/request_inquiry_provider.dart';
import 'attach_photo_button.dart';



// ── Screen ────────────────────────────────────────────────────────────────────

class RequestQuotePage extends ConsumerStatefulWidget {
  const RequestQuotePage({super.key});

  @override
  ConsumerState<RequestQuotePage> createState() => _RequestQuotePageState();
}

class _RequestQuotePageState extends ConsumerState<RequestQuotePage> {
  static const _services = [
    'Lawn Mowing',
    'Garden Maintenance',
    'Hedge Trimming',
    'Tree Pruning',
    'Landscaping',
    'Weed Removal',
    'Seasonal Planting',
  ];

  final ImagePicker _picker = ImagePicker();

  // ── Photo Picker ───────────────────────────────────────────────────────────
  Future<void> _pickImages() async {
    final notifier = ref.read(requestQuoteProvider.notifier);
    final currentCount = notifier.state.attachedPhotos.length;

    if (currentCount >= 5) return;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take Photo'),
              onTap: () async {
                Navigator.pop(context);
                await _pickFromSource(ImageSource.camera, notifier);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _pickFromSource(ImageSource.gallery, notifier);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickFromSource(
      ImageSource source,
      RequestQuoteNotifier notifier,
      ) async {
    final currentCount = notifier.state.attachedPhotos.length;
    final remaining = 5 - currentCount;
    if (remaining <= 0) return;

    try {
      List<XFile>? pickedFiles;

      if (source == ImageSource.gallery && remaining > 1) {
        pickedFiles = await _picker.pickMultiImage(
          limit: remaining,
          imageQuality: 85,
        );
      } else {
        final file = await _picker.pickImage(
          source: source,
          imageQuality: 85,
        );
        pickedFiles = file != null ? [file] : null;
      }

      if (pickedFiles != null && pickedFiles.isNotEmpty) {
        final newPaths = pickedFiles.map((f) => f.path).toList();
        notifier.addPhotos(newPaths);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: $e')),
      );
    }
  }

  void _removePhoto(int index) {
    ref.read(requestQuoteProvider.notifier).removePhotoAt(index);
  }

  // ── Existing methods ───────────────────────────────────────────────────────
  void _showServiceSheet() {
    final notifier = ref.read(requestQuoteProvider.notifier);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 10.h, bottom: 16.h),
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4E8CE),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            Text(
              'Select a Service',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColor.labelText),
            ),
            SizedBox(height: 12.h),
            ..._services.map((s) {
              final isSelected =
                  ref.watch(requestQuoteProvider).service == s;
              return InkWell(
                onTap: () {
                  notifier.selectService(s);
                  Navigator.pop(context);
                },
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  margin: EdgeInsets.only(bottom: 6.h),
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColor.primary.withValues(alpha: 0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected ?AppColor.primary : Colors.transparent,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          s,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isSelected ? AppColor.scaffoldBg : AppColor.bodyText,
                            fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle_rounded,
                            color: AppColor. primary, size: 18.sp),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final notifier = ref.read(requestQuoteProvider.notifier);
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.primary,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: AppColor.labelText,
          ),
        ),
        child: child!,
      ),
    );
    if (date != null) notifier.selectDate(date);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(requestQuoteProvider);
    final notifier = ref.read(requestQuoteProvider.notifier);

    return Scaffold(
      backgroundColor: AppColor. scaffoldBg,
      body: Stack(
        children: [
          // Background
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 220.h,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF2A5A26),
                        Color(0xFF5A9E3A),
                        Color(0xFF3A7A35),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -10,
                  right: -10,
                  child: Opacity(
                    opacity: 0.25,
                    child: Icon(Icons.eco_rounded,
                        color: Colors.white, size: 120.r),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: -20,
                  child: Opacity(
                    opacity: 0.12,
                    child: Icon(Icons.eco_rounded,
                        color: Colors.white, size: 80.r),
                  ),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                  child: Container(color: Colors.black.withValues(alpha: 0.10)),
                ),
              ],
            ),
          ),

          SafeArea(
            bottom: false,
            child: Column(
              children: [
                // AppBar
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Container(
                          width: 34.w,
                          height: 34.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(Icons.arrow_back_ios_new_rounded,
                              color: Colors.white, size: 15.sp),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Request a Quote',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 34.w),
                    ],
                  ),
                ),

                SizedBox(height: 20.h),

                // White form sheet
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.scaffoldBg,
                      borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.r)),
                    ),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 120.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 22.w),
                            child: CustomText(
                              text:
                              "Fill out the form below and we'll get back to you shortly.",
                              textAlign: TextAlign.center,
                              fontSize: 10.sp,
                              color: AppColor.primary,
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: 32.h),

                          // Job Details
                          SectionHeader(title: 'Job Details'),
                          SizedBox(height: 16.h),

                          CustomText(
                            text: 'Service Needed',
                            fontWeight: FontWeight.w500,
                            fontSize: 13.sp,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 6.h),
                          CustomDropdownField(
                            hint: 'Select a service',
                            value: state.service,
                            onTap: _showServiceSheet,
                          ),
                          SizedBox(height: 16.h),

                          CustomText(
                            text: 'Describe the Job',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColor.textBody,
                          ),
                          SizedBox(height: 6.h),
                          CustomTextFormField(
                            controller: notifier.descController,
                            maxLines: 5,
                            onChanged: notifier.updateDescription,
                            hintText: 'describe',
                          ),
                          SizedBox(height: 12.h),

                          // Attach Photos Button (now tappable)
                          GestureDetector(
                            onTap: state.attachedPhotos.length >= 5
                                ? null
                                : _pickImages,
                            child: AttachPhotosButton(
                              count: state.attachedPhotos.length,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Text(
                              state.attachedPhotos.length >= 5
                                  ? 'Maximum 5 photos reached'
                                  : '+ Add up to 5 photos',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: state.attachedPhotos.length >= 5
                                    ? Colors.red.shade700
                                    : AppColor.subtitleText,
                              ),
                            ),
                          ),

                          // ── Photo Previews ─────────────────────────────────
                          if (state.attachedPhotos.isNotEmpty) ...[
                            SizedBox(height: 16.h),
                            SizedBox(
                              height: 90.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: state.attachedPhotos.length,
                                itemBuilder: (context, index) {
                                  final path = state.attachedPhotos[index];
                                  return Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(12.r),
                                          child: Image.file(
                                            File(path),
                                            width: 100.w,
                                            height: 90.h,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) =>
                                                Container(
                                                  color: Colors.grey.shade300,
                                                  child: const Icon(
                                                      Icons.broken_image),
                                                ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -4.h,
                                          right: -4.w,
                                          child: GestureDetector(
                                            onTap: () => _removePhoto(index),
                                            child: Container(
                                              padding: EdgeInsets.all(4.r),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 2),
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.white,
                                                size: 16.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 8.h),
                          ],

                          SizedBox(height: 24.h),

                          // Contact Information
                          SectionHeader(title: 'Contact Information'),
                          SizedBox(height: 16.h),

                          CustomTextFormField(
                            controller: notifier.nameController,
                            hintText: 'Full Name',
                            prefixIcon: const Icon(Icons.person),
                            onChanged: notifier.updateName,
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 10.h),

                          CustomTextFormField(
                            controller: notifier.emailController,
                            hintText: 'shanel@email.com',
                            prefixIcon: const Icon(Icons.email),
                            onChanged: notifier.updateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 10.h),

                          CustomTextFormField(
                            controller: notifier.phoneController,
                            hintText: '(123) 456-7890',
                            prefixIcon: const Icon(Icons.call),
                            onChanged: notifier.updatePhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          SizedBox(height: 10.h),

                          CustomDropdownField(
                            hint: 'Select a date',
                            value: state.preferredDate == null
                                ? null
                                : DateFormat('dd MMM yyyy')
                                .format(state.preferredDate!),
                            onTap: _pickDate,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sticky Submit button
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  16.w,
                  12.h,
                  16.w,
                  MediaQuery.of(context).padding.bottom + 12.h),
              decoration: BoxDecoration(
                color: AppColor.scaffoldBg,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: CustomButton(
                  text: "Submit Request",
                  onPressed: () {
                    showCustomDialog(
                      context,
                      imagePath: IconPath.confirmation,
                      title: "Success",
                      buttonText: "Done",
                      message:
                      "your request is successfully created and send employee",
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



