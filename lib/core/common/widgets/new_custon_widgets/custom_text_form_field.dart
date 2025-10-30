
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:river_pod/core/utils/constants/app_sizer.dart';
import '../../../utils/constants/app_colors.dart';
// ⬅ import provider

final passwordVisibilityProvider = StateProvider<bool>((ref) => false);

class CustomTextField extends ConsumerWidget {
  const CustomTextField(  {
    super.key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.fillColor,
    this.maxLine,
    this.radius = 8,
    this.onFieldSubmitted,
    this.onChanged,
    this.value,
  this.prefixIcon
  });

  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final dynamic fillColor;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool readOnly;
  final int? maxLine;
  final double radius;
  final String? value;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;

  final  Function(String)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(passwordVisibilityProvider);

    return TextFormField(
      initialValue: value,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      maxLines: maxLine ?? 1,
      readOnly: readOnly,
      keyboardType: keyboardType,
      obscureText: obscureText ? !isVisible : false, // only hide when it's password
      controller: controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: obscureText
            ? IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.textGrey,
          ),
          onPressed: () {
            ref.read(passwordVisibilityProvider.notifier).state =
            !isVisible;
          },
        )
            : null,
        prefixIcon: prefixIcon,
        hintStyle: GoogleFonts.dmSans(
          color: AppColors.textGrey,
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          height: 20 / 14,
        ),
        fillColor: fillColor ?? Colors.transparent,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFormFieldBorder, width: 0.5),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.textFormFieldBorder, width: 0.5),
          borderRadius: BorderRadius.circular(radius),
        ),
        contentPadding: EdgeInsets.only(
          left: 12.w,
          right: 10.w,
          top: 12.h,
          bottom: 12.h,
        ),
      ),
      validator: validator,
    );
  }
}
