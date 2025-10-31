class OtpState {
  final String otp;
  final bool isLoading;
  final bool enableResend;
  final int remainingTime;

  OtpState({
    required this.otp,
    required this.isLoading,
    required this.enableResend,
    required this.remainingTime,
  });

  OtpState copyWith({
    String? otp,
    bool? isLoading,
    bool? enableResend,
    int? remainingTime,
  }) {
    return OtpState(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      enableResend: enableResend ?? this.enableResend,
      remainingTime: remainingTime ?? this.remainingTime,
    );
  }
}