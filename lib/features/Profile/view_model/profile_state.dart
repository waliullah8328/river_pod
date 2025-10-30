import '../../authentication/sign_up/data/model/sign_up_model.dart';

class ProfileState{
  final bool notifications;
  final bool isLoading;
  final SignupModel? user;
  final String? error;
  final String images;

  ProfileState({
    this.notifications = true,
    this.isLoading = false,
    this.user,
    this.error,
    this.images = '',
  });

  ProfileState copyWith({
    bool? notifications,
    bool? isLoading,
    SignupModel? user,
    String? error,
    String? images

  }){
    return ProfileState(
      notifications: notifications?? this.notifications,
      isLoading: isLoading?? this.isLoading,
      user: user?? this.user,
      error: error?? this.error,
      images: images?? this.images
    );

}
}