import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/features/authentication/forget_password/data/repository/forget_repository.dart';
import 'package:river_pod/features/authentication/forget_password/view_model/forget_state.dart';

import '../../../../core/common/widgets/new_custon_widgets/app_snackbar.dart';
import '../../../../core/language/app_local.dart';
import '../../../../core/utils/logging/logger.dart';
import '../../../../route/routes_name.dart';

final forgetRepositoryProvider = Provider<ForgetRepository>((ref) {
  return ForgetRepository();
});

/// StateNotifier provider
final forgetNotifierProvider =
StateNotifierProvider<ForgetNotifier, ForgetState>((ref) {
  final repo = ref.read(forgetRepositoryProvider);
  return ForgetNotifier(repo);
});

class ForgetNotifier extends StateNotifier<ForgetState> {
  final ForgetRepository forgetRepository;

  ForgetNotifier(this.forgetRepository) : super(const ForgetState());



  void setEmail(String value) => state = state.copyWith(email: value);




  Future<bool> forgetEmail({required BuildContext context}) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // ✅ Perform login (async gap)
      final result = await forgetRepository.forgetEmail(
        email: state.email
      );
      if(result.isSuccess){
        Navigator.pushNamed(
          context,
          RouteNames.verifyOtpScreen,
          arguments: {'email': state.email},
        );


          //AppSnackBar.showSuccess(context, "Login Successfully");
          AppLoggerHelper.info("Success fully submitted");

      }

      // ✅ Avoid using BuildContext if the widget is unmounted
      if (!context.mounted) return false;

      state = state.copyWith(isLoading: false, error: null);
      return true;


    } catch (e, st) {
      AppLoggerHelper.error('❌ Login error', '$e\n$st');
      state = state.copyWith(isLoading: false, error: e.toString());
      AppSnackBar.showError(context, 'Something went wrong');
      return false;
    }
  }

  String getText(String key, String langCode) {
    switch (langCode) {
      case 'km':
        return AppLocale.kn[key] ?? key;
      case 'bn':
        return AppLocale.bn[key] ?? key;
      case 'en':
      default:
        return AppLocale.en[key] ?? key;
    }
  }



}