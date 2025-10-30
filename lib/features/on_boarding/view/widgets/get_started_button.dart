
import 'package:flutter/material.dart';
import 'package:river_pod/core/utils/constants/app_sizer.dart';

import '../../../../core/common/widgets/custom_text.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({super.key, required this.onTap});

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //   width: context.width * 0.3,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Color(0xFFEDEEF5),
        ),
        child: CustomText(
          text: "Get Started",
          color: Color(0xFF17225F),
          fontWeight: FontWeight.normal,
          fontSize: 16.sp,

        ),
      ),
    );
  }
}