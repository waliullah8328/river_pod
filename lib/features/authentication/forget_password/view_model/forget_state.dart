

class ForgetState {
  final String email;

  final bool isLoading;
  final String? error;

  const ForgetState({
    this.isLoading = false,

    this.error,
    this.email = '',

  });

  ForgetState copyWith({
    bool? isLoading,

    String? error,
    String? email,

  }) {
    return ForgetState(
        isLoading: isLoading ?? this.isLoading,

        error: error?? this.error,
        email: email?? this.email,

    );
  }
}