import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final String? prefixIconPath;
  final Widget? prefixIcon;
  final double? prefixIconSize;
  final EdgeInsetsGeometry? prefixIconPadding; // New property
  final ValueChanged<String>? onChanged;
  final bool readonly;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final int maxLines;
  final Color? containerColor;
  final Color? hintTextColor;
  final double? hintTextSize;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final String? Function(String?)? validator;
  final double? borderRadius;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIconPath,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconPadding, // Added to constructor
    this.onChanged,
    this.readonly = false,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.maxLines = 1,
    this.containerColor,
    this.hintTextColor = AppColor.profileTextColor,
    this.hintTextSize = 15,
    this.suffixText,
    this.suffixTextStyle,
    this.validator,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color effectiveFillColor = containerColor ??
        (isDarkMode ? const Color(0xff282828) : Colors.white);

    // Standardize the padding for the prefix icon
    final EdgeInsetsGeometry effectivePrefixPadding =
        prefixIconPadding ?? EdgeInsets.symmetric(horizontal: 12.w);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius?.r ?? 8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readonly,
        obscureText: obscureText,
        maxLines: maxLines,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: GoogleFonts.poppins(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: isDarkMode ? AppColor.white : AppColor.headerColor,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: effectiveFillColor,

          // --- Prefix Icon Logic with Custom Padding ---
          prefixIcon: prefixIcon != null
              ? Padding(
            padding: effectivePrefixPadding,
            child: prefixIcon,
          )
              : (prefixIconPath != null
              ? Padding(
            padding: effectivePrefixPadding,
            child: Image.asset(
              prefixIconPath!,
              height: prefixIconSize?.h ?? 24.h,
              width: prefixIconSize?.w ?? 24.w,
            ),
          )
              : null),

          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 0,
          ),

          suffixIcon: suffixIcon,
          suffixText: suffixText,
          suffixStyle: suffixTextStyle ??
              GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColor.primary,
              ),

          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: hintTextSize?.sp ?? 15.sp,
            fontWeight: FontWeight.w400,
            color: hintTextColor,
          ),

          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 16.w,
          ),

          // Borders
          border: border ?? _buildBorder(borderRadius, const Color(0xFFE0E0E0)),
          enabledBorder: enabledBorder ?? _buildBorder(borderRadius, const Color(0xFFE0E0E0)),
          focusedBorder: focusedBorder ?? _buildBorder(borderRadius, AppColor.primary),
          errorBorder: _buildBorder(borderRadius, AppColor.error),
          focusedErrorBorder: _buildBorder(borderRadius, AppColor.error),
        ),
      ),
    );
  }

  InputBorder _buildBorder(double? radius, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius?.r ?? 8.r),
      borderSide: BorderSide(color: color, width: 1.w),
    );
  }
}