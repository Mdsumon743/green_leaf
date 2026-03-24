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
  final EdgeInsetsGeometry? prefixIconPadding;
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
  final Color? textColor;
  final double? hintTextSize;
  final String? suffixText;
  final TextStyle? suffixTextStyle;
  final String? Function(String?)? validator;
  final double? borderRadius;

  // --- New Shadow Properties ---
  final Color? shadowColor;
  final double? blurRadius;
  final Offset? shadowOffset;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIconPath,
    this.prefixIcon,
    this.prefixIconSize,
    this.prefixIconPadding,
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
    this.textColor,
    this.hintTextSize = 15,
    this.suffixText,
    this.suffixTextStyle,
    this.validator,
    this.borderRadius,
    // --- New shadow defaults ---
    this.shadowColor,
    this.blurRadius,
    this.shadowOffset,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final Color effectiveFillColor = containerColor ??
        (isDarkMode ? const Color(0xff282828) : Colors.white);

    final Color effectiveTextColor = textColor ??
        (isDarkMode ? AppColor.white : AppColor.headerColor);

    final EdgeInsetsGeometry effectivePrefixPadding =
        prefixIconPadding ?? EdgeInsets.symmetric(horizontal: 12.w);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius?.r ?? 8.r),
        boxShadow: [
          BoxShadow(
            // Use provided color or a soft subtle black by default
            color: shadowColor ?? Colors.black.withOpacity(0.06),
            blurRadius: blurRadius ?? 10.r,
            spreadRadius: 0,
            offset: shadowOffset ?? const Offset(0, 4),
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
          color: effectiveTextColor,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: effectiveFillColor,

          // Prefix and Suffix icon logic stays same...
          prefixIcon: prefixIcon != null
              ? Padding(padding: effectivePrefixPadding, child: prefixIcon)
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
          prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 0),
          suffixIcon: suffixIcon,

          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: hintTextSize?.sp ?? 15.sp,
            fontWeight: FontWeight.w400,
            color: hintTextColor,
          ),

          contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),

          // --- Updated Border Logic ---
          // Using transparent for border/enabled border makes the shadow pop
          border: border ?? _buildBorder(borderRadius, Colors.transparent),
          enabledBorder: enabledBorder ?? _buildBorder(borderRadius, Colors.transparent),
          focusedBorder: focusedBorder ?? _buildBorder(borderRadius, AppColor.primary.withOpacity(0.5)),
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