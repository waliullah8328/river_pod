import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/features/authentication/verify_otp/data/repository/verify_otp_repository.dart';
import 'package:river_pod/features/authentication/verify_otp/view_model/verify_otp_state.dart';

import '../../../../core/utils/logging/logger.dart';
import '../../../../route/routes_name.dart';

final verifyOtpRepositoryProvider = Provider<VerifyOtpRepository>((ref) {
  return VerifyOtpRepository();
});

final otpNotifierProvider = StateNotifierProvider<OtpNotifier, OtpState>((ref) {
  final repo = ref.read(verifyOtpRepositoryProvider);
  return OtpNotifier(repo);
});
class OtpNotifier extends StateNotifier<OtpState> {

  final VerifyOtpRepository verifyOtpRepository;
  OtpNotifier(this.verifyOtpRepository)
      : super(OtpState(
    otp: "",
    isLoading: false,
    enableResend: false,
    remainingTime: 60,
  )) {
    _startResendCodeTimer();
  }

  void setOtp(String value) => state = state.copyWith(otp: value);

  Timer? _timer;

  void _startResendCodeTimer() {
    _timer?.cancel();
    state = state.copyWith(enableResend: false, remainingTime: 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (state.remainingTime == 0) {
        t.cancel();
        state = state.copyWith(enableResend: true);
      } else {
        state = state.copyWith(remainingTime: state.remainingTime - 1);
      }
    });
  }

  Future<void> resendEmail(String email) async {
    _startResendCodeTimer();
    // TODO: Implement resend email API call
    debugPrint("Resend OTP to: $email");
  }

  Future<void> verifyOtp(BuildContext context, String email) async {
    state = state.copyWith(isLoading: true);
    try {
      final otp = state.otp;
      if (otp.isEmpty || otp.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid OTP")),
        );
        state = state.copyWith(isLoading: false);
        return;
      }

      // TODO: call verify API here

      final result = await verifyOtpRepository.verifyOtp(

          email: email, otp: state.otp
      );
      final data = result.responseData;
      debugPrint("--------------------------------------------------------");
      debugPrint(data);
      debugPrint("--------------------------------------------------------");
      if(result.isSuccess){
        final token = data["data"];


        Navigator.pushNamed(
          context,
          RouteNames.resetPasswordScreen,
          arguments: {'token': token },
        );
        //AppSnackBar.showSuccess(context, "Login Successfully");
        AppLoggerHelper.info("Success fully submitted");

      }
      await Future.delayed(const Duration(seconds: 2));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("OTP Verified Successfully")),
      );

      // Navigate to next screen or home
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    state.otp;
    super.dispose();
  }
}


