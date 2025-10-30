import '../data/model/login_model.dart';

class LoginState {
  final bool isLoading;
  final LoginModel? user;
  final String? error;

  const LoginState({this.isLoading = false, this.user, this.error});

  LoginState copyWith({
    bool? isLoading,
    LoginModel? user,
    String? error,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
    );
  }
}