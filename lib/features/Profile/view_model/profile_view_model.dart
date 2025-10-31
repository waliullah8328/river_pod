

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:river_pod/features/Profile/data/model/profile_model.dart';

import 'package:river_pod/features/Profile/view_model/profile_state.dart';

import '../../../core/services/theme_service.dart';
import '../data/repository/profile_repository.dart';

// For get me profile
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final profileProvider = FutureProvider<GetMyProfileModel>((ref) async {
  return ref.watch(profileRepositoryProvider).fetchUser();
});





final themeModeProvider =
StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final savedTheme = await ThemeService.getThemeMode();
    state = savedTheme;
  }

  void toggleTheme() async {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      await ThemeService.saveThemeMode(ThemeMode.dark);
    } else {
      state = ThemeMode.light;
      await ThemeService.saveThemeMode(ThemeMode.light);
    }
  }

  void setSystemTheme() async {
    state = ThemeMode.system;
    await ThemeService.saveThemeMode(ThemeMode.system);
  }
}


// For profile




final profileNotifierProvider =
StateNotifierProvider<ProfileRepositoryNotifier, ProfileState>((ref) {
  final repo = ref.read(profileRepositoryProvider);
  return ProfileRepositoryNotifier (repo);
});


class ProfileRepositoryNotifier extends StateNotifier<ProfileState> {

  final ProfileRepository profileRepository;
  ProfileRepositoryNotifier(this.profileRepository) : super(ProfileState());

  void setNotifications(bool value) => state = state.copyWith(notifications: value);
  void setImages(String images) => state = state.copyWith(images: images);


  // Future<void> updateProfile(BuildContext context){
  //
  //
  //
  //
  //   state = state.copyWith(isLoading: true, error: null);
  //
  //
  // }
  final ImagePicker _picker = ImagePicker();
  Future<void> pickSingleImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setImages(pickedFile.path);
    }
  }




}
