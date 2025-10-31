import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:river_pod/core/utils/logging/logger.dart';
import '../../../../../core/common/widgets/custom_text.dart';
import '../../../../../core/common/widgets/new_custon_widgets/custom_app_bar.dart';
import '../../../../../core/common/widgets/new_custon_widgets/custom_button.dart';
import '../../../../../core/utils/constants/app_colors.dart';
import '../../../../../core/utils/constants/app_sizes.dart';
import '../../../../../core/utils/constants/icon_path.dart';
import '../view_model/verify_view_model.dart';


class VerifyOtpScreen extends ConsumerWidget {
  const VerifyOtpScreen({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final email = args?['email'] ?? '';
    final state = ref.watch(otpNotifierProvider);
    final notifier = ref.read(otpNotifierProvider.notifier);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: getHeight(24)),
              const CustomAppBar(
                firstText: 'Verification code',
                secondText:
                "Please check your phone. We have sent a verification code to your email.",
              ),
              SizedBox(height: getHeight(70)),

              /// OTP FIELD
              PinCodeTextField(
                backgroundColor: AppColors.textWhite,
                appContext: context,
                length: 6,

                onChanged: (value) {
                  notifier.setOtp(value);
                },

                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderWidth: 1.5,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                ),
                cursorColor: const Color(0xFF007AFF),
                keyboardType: TextInputType.number,
                enableActiveFill: false,
                textStyle: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: getWidth(20)),

              /// RESEND TIMER
              Align(
                alignment: Alignment.center,
                child: state.enableResend
                    ? TextButton(
                  onPressed: () => notifier.resendEmail(email),
                  child: const Text("Resend Code"),
                )
                    : RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Color(0xff374151)),
                    text: "Resend code in ",
                    children: [
                      TextSpan(
                        text:
                        "00:${state.remainingTime.toString().padLeft(2, '0')}s",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: getWidth(84)),

              /// VERIFY BUTTON
              state.isLoading
                  ? const Center(
                child: SpinKitWave(
                  color: AppColors.primary,
                  size: 30.0,
                ),
              )
                  : CustomButton(
                onPressed: () {
                  AppLoggerHelper.info("Otp : ${state.otp}");
                  AppLoggerHelper.info("email: $email");

                  notifier.verifyOtp(context, email);

                },// ✅
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Verify",
                      color: const Color(0xffFFFFFF),
                      fontSize: getWidth(16),
                    ),
                    SizedBox(width: getWidth(10)),
                    Image.asset(
                      IconPath.rightArrowIcon,
                      height: getHeight(20),
                      width: getWidth(20),
                    ),
                  ],
                ),
              ),

              SizedBox(height: getHeight(40)),
            ],
          ),
        ),
      ),
    );
  }
}
