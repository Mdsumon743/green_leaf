import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class PhotoRow extends StatelessWidget {
  final List<File> photos;
  const PhotoRow({required this.photos});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: photos.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (_, i) => ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Image.file(
            photos[i],
            width: 64.w,
            height: 64.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}