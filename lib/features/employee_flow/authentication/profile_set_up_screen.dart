import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saunders/core/global/custom_text.dart';
import 'package:saunders/core/global/custom_text_form_field.dart';

import 'package:saunders/core/utils/app_color.dart';

import '../provider/profile_setup_provider.dart';

// ─── State ────────────────────────────────────────────────────────────────────



// ─── Screen  ──────────────────────────────────────────────────────────────────
// Pure ConsumerWidget — no StatefulWidget / State class needed.

class ProfileSetUpScreen extends ConsumerWidget {
  const ProfileSetUpScreen({super.key});

  // ── Avatar Bottom Sheet ────────────────────────────────────────────────────

  void _showAvatarPicker(BuildContext context, ProfileSetUpNotifier notifier) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _AvatarPickerSheet(
        onCamera: () {
          Navigator.pop(context);
          notifier.pickImageFromCamera();
        },
        onGallery: () {
          Navigator.pop(context);
          notifier.pickImageFromGallery();
        },
      ),
    );
  }

  // ── Date Picker ────────────────────────────────────────────────────────────

  Future<void> _pickDate(
      BuildContext context,
      ProfileSetUpState state,
      ProfileSetUpNotifier notifier,
      ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: state.dateOfBirth ?? DateTime(1998, 10, 24),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColor.primary,
            onPrimary: Colors.white,
            surface: AppColor.background,
            onSurface: AppColor.black,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) notifier.setDateOfBirth(picked);
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileSetUpProvider);
    final notifier = ref.read(profileSetUpProvider.notifier);

    const genderOptions = ['Male', 'Female', 'Non-binary', 'Prefer not to say'];
    const experienceOptions = [
      'Less than 1 Year',
      '1-2 Years',
      '3-4 Years',
      '5+ Years',
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),

              // ── Back ───────────────────────────────────────────────────────
              GestureDetector(
                onTap: () => context.pop(),
                child: Icon(Icons.arrow_back, size: 24.r, color: AppColor.black),
              ),

              SizedBox(height: 24.h),

              // ── Avatar ─────────────────────────────────────────────────────
              Center(
                child: GestureDetector(
                  onTap: () => _showAvatarPicker(context, notifier),
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 48.r,
                        backgroundColor: AppColor.primary.withOpacity(0.15),
                        backgroundImage: state.profileImage != null
                            ? FileImage(state.profileImage!)
                            : null,
                        child: state.profileImage == null
                            ? Icon(Icons.person,
                            size: 48.r, color: AppColor.primary)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 26.r,
                          height: 26.r,
                          decoration: BoxDecoration(
                            color: AppColor.primary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(Icons.edit,
                              color: Colors.white, size: 14.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              Center(
                child: CustomText(
                  text: 'Upload profile picture',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColor.grey,
                ),
              ),

              SizedBox(height: 24.h),

              // ── Gender ─────────────────────────────────────────────────────
              _Label(text: 'Gender'),
              SizedBox(height: 8.h),
              _CustomDropdown(
                value: state.gender,
                hint: 'Select Gender',
                items: genderOptions,
                onChanged: (val) {
                  if (val != null) notifier.setGender(val);
                },
              ),

              SizedBox(height: 20.h),

              // ── Date Of Birth ──────────────────────────────────────────────
              _Label(text: 'Date Of Birth'),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () => _pickDate(context, state, notifier),
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: TextEditingController(
                      text: state.dateOfBirth != null
                          ? '${state.dateOfBirth!.day.toString().padLeft(2, '0')}/'
                          '${state.dateOfBirth!.month.toString().padLeft(2, '0')}/'
                          '${state.dateOfBirth!.year}'
                          : '',
                    ),
                    hintText: 'DD/MM/YYYY',
                    suffixIcon: Icon(
                      Icons.calendar_month_outlined,
                      color: AppColor.grey,
                      size: 20.r,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),

              // ── Bio ────────────────────────────────────────────────────────
              _Label(text: 'Bio'),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: notifier.bioController,
                hintText: 'Bio',
                maxLines: 4,
                onChanged: notifier.setBio,
              ),

              SizedBox(height: 20.h),

              // ── Address ────────────────────────────────────────────────────
              _Label(text: 'Address'),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: notifier.addressController,
                hintText: 'Address',
                onChanged: notifier.setAddress,
              ),

              SizedBox(height: 20.h),

              // ── Skills ─────────────────────────────────────────────────────
              _Label(text: 'Skills'),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: notifier.skillController,
                      hintText: 'Add Skill',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () =>
                        notifier.addSkill(notifier.skillController.text),
                    child: Container(
                      width: 44.r,
                      height: 44.r,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child:
                      Icon(Icons.add, color: Colors.white, size: 22.r),
                    ),
                  ),
                ],
              ),

              if (state.skills.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: state.skills
                      .map((skill) => _SkillChip(
                    label: skill,
                    onRemove: () => notifier.removeSkill(skill),
                  ))
                      .toList(),
                ),
              ],

              SizedBox(height: 20.h),
              _Label(text: "Employee Code"),
              SizedBox(height: 8.h,),
              CustomTextFormField(
                controller: notifier.employeeCodeController,
                hintText: 'Employee Code',
                onChanged: notifier.setAddress,
              ),
              SizedBox(height: 20.h,),

              // ── Experience ─────────────────────────────────────────────────
              _Label(text: 'Experience'),
              SizedBox(height: 8.h),
              _CustomDropdown(
                value: state.experience,
                hint: 'Select Experience',
                items: experienceOptions,
                onChanged: (val) {
                  if (val != null) notifier.setExperience(val);
                },
              ),

              SizedBox(height: 20.h),

              // ── Experience Certifications ──────────────────────────────────
              _Label(text: 'Experience Certifications'),
              SizedBox(height: 8.h),
              _CertificationUploadBox(
                file: state.certificationFile,
                onUpload: notifier.pickCertification,
                onRemove: notifier.removeCertification,
              ),

              SizedBox(height: 32.h),

              // ── Done ───────────────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: (){
                    context.push('/employeeNavigation');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    disabledBackgroundColor: AppColor.primary.withValues(alpha: 0.6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: state.isLoading
                      ? SizedBox(
                    width: 22.r,
                    height: 22.r,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                      : CustomText(
                    text: 'Done',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Private Sub-Widgets ───────────────────────────────────────────────────────

// ── Section Label ──────────────────────────────────────────────────────────────

class _Label extends StatelessWidget {
  final String text;
  const _Label({required this.text});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: AppColor.black,
    );
  }
}

// ── Custom Dropdown ────────────────────────────────────────────────────────────

class _CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _CustomDropdown({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: CustomText(
            text: hint,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.grey,
          ),
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColor.grey, size: 22.r),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          items: items
              .map((item) =>
              DropdownMenuItem<String>(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// ── Skill Chip ─────────────────────────────────────────────────────────────────

class _SkillChip extends StatelessWidget {
  final String label;
  final VoidCallback onRemove;

  const _SkillChip({required this.label, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.primary.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.primary,
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 14.r, color: AppColor.primary),
          ),
        ],
      ),
    );
  }
}

// ── Certification Upload Box ───────────────────────────────────────────────────

class _CertificationUploadBox extends StatelessWidget {
  final File? file;
  final VoidCallback onUpload;
  final VoidCallback onRemove;

  const _CertificationUploadBox({
    required this.file,
    required this.onUpload,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // ── AFTER upload: full-width image, no text, action buttons overlaid ──────
    if (file != null) {
      return Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.file(
              file!,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          // Top-right: Re-upload + Delete
          Positioned(
            top: 8.h,
            right: 8.w,
            child: Row(
              children: [
                _ImageActionButton(
                  icon: Icons.upload_rounded,
                  onTap: onUpload,
                ),
                SizedBox(width: 8.w),
                _ImageActionButton(
                  icon: Icons.delete_outline_rounded,
                  onTap: onRemove,
                ),
              ],
            ),
          ),
        ],
      );
    }

    // ── BEFORE upload: placeholder card ───────────────────────────────────────
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Column(
        children: [
          Icon(Icons.photo_library_outlined,
              size: 44.r, color: AppColor.grey),
          SizedBox(height: 12.h),
          CustomText(
            text: 'Upload Certifications Prof',
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: AppColor.black,
          ),
          SizedBox(height: 4.h),
          CustomText(
            text: 'Upload the front side of your document',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.grey,
          ),
          CustomText(
            text: 'Supports: JPG, PNG, PDF',
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.grey,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 44.h,
            width: 140.w,
            child: ElevatedButton(
              onPressed: onUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r)),
                elevation: 0,
              ),
              child: CustomText(
                text: 'Upload',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Semi-transparent circular icon button overlaid on the certification image.
class _ImageActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ImageActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34.r,
        height: 34.r,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.55),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 18.r),
      ),
    );
  }
}

// ── Avatar Picker Bottom Sheet ─────────────────────────────────────────────────

class _AvatarPickerSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const _AvatarPickerSheet({required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          CustomText(
            text: 'Select Photo',
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColor.black,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PickerOption(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera',
                  onTap: onCamera),
              _PickerOption(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  onTap: onGallery),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: AppColor.primary),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: CustomText(
                text: 'Cancel',
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColor.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerOption(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64.r,
            height: 64.r,
            decoration: BoxDecoration(
              color: AppColor.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.primary, size: 28.r),
          ),
          SizedBox(height: 8.h),
          CustomText(
            text: label,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColor.black,
          ),
        ],
      ),
    );
  }
}