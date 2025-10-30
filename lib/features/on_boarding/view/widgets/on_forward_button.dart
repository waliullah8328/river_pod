
import 'package:flutter/material.dart';
import 'package:river_pod/core/utils/constants/app_sizer.dart';

class OnbForwardButton extends StatelessWidget {
  const OnbForwardButton({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFFFFFFF),
          boxShadow: [BoxShadow(color: Color(0xFFF2EEED), blurRadius: 7)],
        ),
        child: Icon(Icons.arrow_forward, color: Color(0xFF17225F), size: 25.w),
      ),
    );
  }
}