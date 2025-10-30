// lib/features/auth/signup/view_model/sign_up_view_model.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../data/repository/sign_up_repository.dart';
import 'sign_up_state.dart';

final signUpRepositoryProvider = Provider<SignupRepository>((ref) {
  return SignupRepository();
});

final signUpNotifierProvider =
StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final repo = ref.read(signUpRepositoryProvider);
  return SignUpNotifier(repo);
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  final SignupRepository signUpRepository;
  final ImagePicker _picker = ImagePicker();

  SignUpNotifier(this.signUpRepository) : super(const SignUpState());

  void setName(String value) => state = state.copyWith(name: value);
  void setEmail(String value) => state = state.copyWith(email: value);
  void setPassword(String value) => state = state.copyWith(password: value);
  void setNotifications(bool value) =>
      state = state.copyWith(notifications: value);
  void setAcceptTerms(bool value) => state = state.copyWith(acceptTerms: value);
  void setImages(List<File> images) => state = state.copyWith(images: images);

  /// NEW: address setter
  void setAddress(String address) => state = state.copyWith(address: address);
  void setLat(double lat) => state = state.copyWith(lat: lat);
  void setLng(double lng) => state = state.copyWith(lng: lng);

  Future<void> register(BuildContext context) async {
    if (state.name.isEmpty || state.email.isEmpty || state.password.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (!state.acceptTerms) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Accept terms first")));
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      // adjust repository signup signature as needed
      final user = await signUpRepository.signup(
        name: state.name,
        email: state.email,
        notification: state.notifications,
        acceptTerms: state.acceptTerms,
        images: state.images,
        password: state.password,
        address: state.address,
      );

      state = state.copyWith(isLoading: false, user: null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Signup Successful")),
      );
    } catch (e) {
      debugPrint(e.toString());
      state = state.copyWith(isLoading: false, error: e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup Failed: $e")),
      );
    }
  }

  /// Pick single image
  Future<void> pickSingleImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setImages([File(pickedFile.path)]);
    }
  }

  /// Pick multiple images
  Future<void> pickMultipleImages() async {
    final pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setImages(pickedFiles.map((e) => File(e.path)).toList());
    }
  }
}
