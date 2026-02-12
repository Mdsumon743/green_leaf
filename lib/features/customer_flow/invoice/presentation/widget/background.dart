import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/constants/image_path.dart';


class Background extends StatelessWidget {
  const Background();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Main background
        Positioned.fill(
          child: Opacity(
            opacity: 0.2,
            child: Image.asset(
              ImagePath.visitBackground,
              fit: BoxFit.cover,
            ),
          ),
        ),

        /// Bottom-left decoration
        Positioned(
          bottom: 0,
          left: 0,
          child: Opacity(
            opacity: 0.3,
            child: Image.asset(
              ImagePath.homeBackground,
              width: 180.w,
            ),
          ),
        ),

        /// Bottom-right decoration
        Positioned(
          bottom: 0,
          right: 0,
          child: Opacity(
            opacity: 0.3,
            child: Image.asset(
              ImagePath.visitTwo,
              width: 220.w,
            ),
          ),
        ),
      ],
    );
  }
}