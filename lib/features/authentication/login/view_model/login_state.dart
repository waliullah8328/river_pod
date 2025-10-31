import '../data/model/login_model.dart';

class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final LoginModel? user;
  final String? error;

  const LoginState({
    this.isLoading = false,
    this.user,
    this.error,
    this.email = '',
    this.password = '',
  });

  LoginState copyWith({
    bool? isLoading,
    LoginModel? user,
    String? error,
    String? email,
    String? password,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error?? this.error,
      email: email?? this.email,
      password: password?? this.password
    );
  }
}