import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/model/profile_model.dart';
import '../data/repository/profile_repository.dart';

import 'edit_profile_state.dart';

/// Repository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

/// Fetch Profile Data
final profileProvider = FutureProvider<GetMyProfileModel>((ref) async {
  return ref.watch(profileRepositoryProvider).fetchUser();
});

/// Update Profile State Notifier
final updateProfileProvider =
StateNotifierProvider<UpdateProfileNotifier, EditProfileState>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return UpdateProfileNotifier(repo);
});

class UpdateProfileNotifier extends StateNotifier<EditProfileState> {
  final ProfileRepository repo;

  UpdateProfileNotifier(this.repo) : super(EditProfileState());

  // 🔹 Update methods for text fields
  void setName(String value) => state = state.copyWith(name: value);
  void setAbout(String value) => state = state.copyWith(about: value);
  void setLocation(String value) => state = state.copyWith(location: value);
  void setImage(String image) => state = state.copyWith(image: image);
  void setLat(double lat) => state = state.copyWith(lat: lat);
  void setLng(double lng) => state = state.copyWith(lng: lng);
  void setInitialized() => state = state.copyWith(isInitialized: true);


  // 🔹 Perform Update Request
  Future<void> updateProfile() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await repo.updateProfile(
        name: state.name,
        about: state.about,
        location: state.location,
        lat: state.lat,
        lng: state.lng,
        image: state.image,
      );

      state = state.copyWith(isLoading: false, error: null);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
