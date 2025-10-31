class ChangePasswordState{

  final String newPassword;
  final String confirmPassword;
  final bool isLoading;

  final String? error;

  ChangePasswordState({
    this.newPassword = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.error = ''
  });

  ChangePasswordState copyWith({ String? newPassword, String? confirmPassword, bool? isLoading,  String? error}){
    return  ChangePasswordState(
      newPassword: newPassword?? this.newPassword,
      confirmPassword: confirmPassword?? this.confirmPassword,
      isLoading: isLoading?? this.isLoading,
      error: error?? this.error,
    );
}




}