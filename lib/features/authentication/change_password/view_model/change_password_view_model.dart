import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod/features/authentication/change_password/data/repository/change_password_repository.dart';
import 'package:river_pod/features/authentication/change_password/view_model/change_password_state.dart';

final changePasswordRepositoryProvider = Provider<ChangePasswordRepository>((ref) {
  return ChangePasswordRepository();
});


/// StateNotifier provider
final changePasswordNotifierProvider =
StateNotifierProvider<ChangePasswordViewModelNotifier, ChangePasswordState>((ref) {
  final repo = ref.read(changePasswordRepositoryProvider);
  return ChangePasswordViewModelNotifier(repo);
});


class ChangePasswordViewModelNotifier extends StateNotifier<ChangePasswordState> {

  final ChangePasswordRepository changePasswordRepository;
  ChangePasswordViewModelNotifier(this.changePasswordRepository) : super(ChangePasswordState());

  void setPassword(String value) => state = state.copyWith(newPassword: state.newPassword);
  void setConfirmPassword(String value) => state = state.copyWith(confirmPassword: state.confirmPassword);





}