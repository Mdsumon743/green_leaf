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
import 'package:saunders/core/global/curve_clipper.dart';
import 'package:saunders/core/global/custom_button.dart';
import 'package:saunders/core/global/custom_dropdown.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';
import 'package:saunders/core/global/show_custom_dialog.dart';
import 'package:saunders/core/utils/app_color.dart';
import 'package:saunders/features/customer_flow/home/presentation/widget/section_header.dart';

import '../../../../../core/constants/image_path.dart';
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
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              ImagePath.quoteBackground,
              width: double.infinity,
              fit: BoxFit.fitWidth, // Spans the full width at the top
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              ImagePath.myQuotesDetailsBottumBG,
              width: double.infinity,
              fit: BoxFit.fitWidth, // Pinned strictly to the bottom
            ),
          ),

          // Overlay (slightly adjusted opacity for better readability)
          Container(
            color: Colors.black.withOpacity(0.42),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset(
               ImagePath.visitBackground,
              width: 152.w,
              fit: BoxFit.fitWidth, // Spans the full width at the top
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
                          child: Image.asset(IconPath.arrowLeft, height: 24.h,width: 24.w,)
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
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child:ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white,
                            Colors.transparent,
                          ],
                          stops: const [0.0, 0.85, 1.0],
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
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
                              SizedBox(height: 48.h,),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 22.w),
                                child: CustomText(
                                  text:
                                  "Fill out the form below and we'll get back to you shortly.",
                                  textAlign: TextAlign.center,
                                  fontSize: 12.sp,
                                  color: Color(0xFF5B616E),
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(height: 32.h),


                              //Container 1 Start
                              // Job Details
                              Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                  color: Color(0xFF11A41C).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(16.r)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionHeader(title: 'Job Details'),
                                    SizedBox(height: 16.h),

                                    CustomText(
                                        text: 'Service Needed',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        color: Colors.black
                                    ),
                                    SizedBox(height: 6.h),
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF055726).withValues(alpha: 0.4),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                            )
                                          ]
                                      ),
                                      child: CustomDropdownField(
                                        hint: 'Select a service',
                                        value: state.service,
                                        onTap: _showServiceSheet,
                                      ),
                                    ),
                                    SizedBox(height: 16.h),

                                    CustomText(
                                      text: 'Describe the Job',
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.textBody,
                                    ),
                                    SizedBox(height: 6.h),
                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF055726).withValues(alpha: 0.4),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                            )
                                          ]
                                      ),
                                      child: CustomTextFormField(
                                        controller: notifier.descController,
                                        maxLines: 5,
                                        onChanged: notifier.updateDescription,
                                        hintText: 'Please provide details of the work needed...',
                                      ),
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
                                  ],
                                ),
                              ),

                              //Container 1 End

                              SizedBox(height: 32.h),

                              //Container 2 Start
                              // Contact Information
                              Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: BoxDecoration(
                                    color: Color(0xFF11A41C).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(16.r)
                                ),
                                child: Column(
                                  children: [
                                    SectionHeader(title: 'Contact Information'),
                                    SizedBox(height: 16.h),

                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF055726).withValues(alpha: 0.4),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                            )
                                          ]
                                      ),
                                      child: CustomTextFormField(
                                        controller: notifier.nameController,
                                        hintText: 'Full Name',
                                        prefixIcon: Image.asset(IconPath.user,height: 24.h,width: 24.w,),
                                        onChanged: notifier.updateName,
                                        keyboardType: TextInputType.name,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),

                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF055726).withValues(alpha: 0.4),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                            )
                                          ]
                                      ),
                                      child: CustomTextFormField(
                                        controller: notifier.emailController,
                                        hintText: 'shanel@email.com',
                                        prefixIcon: Image.asset(IconPath.user,height: 24.h,width: 24.w,),
                                        onChanged: notifier.updateEmail,
                                        keyboardType: TextInputType.emailAddress,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),

                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF055726).withValues(alpha: 0.4),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                            )
                                          ]
                                      ),
                                      child: CustomTextFormField(
                                        controller: notifier.phoneController,
                                        hintText: '(123) 456-7890',
                                        prefixIcon: Image.asset(IconPath.user,height: 24.h,width: 24.w,),
                                        onChanged: notifier.updatePhone,
                                        keyboardType: TextInputType.phone,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),

                                    Container(
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xFF055726).withValues(alpha: 0.4),
                                              spreadRadius: 1,
                                              blurRadius: 6,
                                            )
                                          ]
                                      ),
                                      child: CustomDropdownField(
                                        hint: 'Select a date',
                                        value: state.preferredDate == null
                                            ? null
                                            : DateFormat('dd MMM yyyy')
                                            .format(state.preferredDate!),
                                        onTap: _pickDate,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Container 2 End
                              SizedBox(height: 32.h,),
                              SizedBox(
                                width: double.infinity,
                                height: 52.h,
                                child: CustomButton(
                                  borderRadius: 8.r,
                                  backgroundGradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF8CC40F),
                                        Color(0xFF126A19),
                                      ]
                                  ),
                                  text: "Submit Request",
                                  onPressed: () {
                                    showCustomDialog(
                                      context,
                                      imagePath: IconPath.success2,
                                      title: "Success",
                                      buttonText: "Done",
                                      message:
                                      "your request is successfully created and send employee",
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sticky Submit button

        ],
      ),
    );
  }
}



