import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:river_pod/core/services/auth_service.dart';
import '../../../../core/common/widgets/new_custon_widgets/app_snackbar.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../route/routes_name.dart';
import '../data/repository/login_repository.dart';
import 'login_state.dart';

/// Repository provider
final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository();
});

/// StateNotifier provider
final loginNotifierProvider =
StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final repo = ref.read(loginRepositoryProvider);
  return LoginNotifier(repo);
});

class LoginNotifier extends StateNotifier<LoginState> {
  final LoginRepository loginRepository;

  LoginNotifier(this.loginRepository) : super(const LoginState());




  Future<bool> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // ✅ Perform login (async gap)
      final user = await loginRepository.login(
        email: email,
        password: password,
        context: context,
      );

      // ✅ Avoid using BuildContext if the widget is unmounted
      if (!context.mounted) return false;

      state = state.copyWith(isLoading: false, user: user, error: null);

      if (user.success == true) {
        final token = user.data?.accessToken;
        await AuthService.saveToken(token ?? '', '');

        AppLoggerHelper.info('✅ Token saved: $token');


        // ✅ Return true (success)
        return true;
      } else {
        AppSnackBar.showError(context, user.message ?? 'Login failed');
        return false;
      }
    } catch (e, st) {
      AppLoggerHelper.error('❌ Login error', '$e\n$st');
      state = state.copyWith(isLoading: false, error: e.toString());
      AppSnackBar.showError(context, 'Something went wrong');
      return false;
    }
  }


  void clearError() => state = state.copyWith(error: null);
  void logout() => state = const LoginState();
}
