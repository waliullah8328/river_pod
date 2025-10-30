import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:river_pod/features/authentication/data/repository/authentication_repository.dart';

import '../data/model/subscription_model.dart';
import '../login/data/model/login_model.dart';

final apiServiceProvider = Provider<AuthenticationRepository>((ref) {
  return AuthenticationRepository();
});

final subscriptionListProvider =
FutureProvider<List<SubscriptionPlan>>((ref) async {
  return ref.watch(apiServiceProvider).fetchUser();
});

class LoginNotifier extends StateNotifier<LoginModel?> {
  final AuthenticationRepository apiService;

  LoginNotifier(this.apiService) : super(null);

  Future<void> login({
    required String email,
    required String password,
    required context
  }) async {
    try {
      // ✅ Ensure createAccount actually returns a LoginModel
      final loginValue = await apiService.createAccount(
        email: email,
        password: password,
        context: context
      );

      // If createAccount returns LoginModel, update state
      state = loginValue as LoginModel?;
    } catch (e) {
      // Handle any errors
      state = null;
    }
  }
}

// ✅ Provider for LoginNotifier
final loginNotifierProvider =
StateNotifierProvider<LoginNotifier, LoginModel?>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return LoginNotifier(apiService);
});
