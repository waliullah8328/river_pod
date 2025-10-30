// lib/features/auth/signup/view_model/sign_up_state.dart
import 'dart:io';
import '../data/model/sign_up_model.dart';

class SignUpState {
  final String name;
  final String email;
  final String password;
  final bool notifications;
  final bool acceptTerms;
  final List<File> images;
  final bool isLoading;
  final SignupModel? user;
  final String? error;
  final String address;
  final double lat;
  final double lng; // <- added

  const SignUpState( {
    this.name = '',
    this.email = '',
    this.password = '',
    this.notifications = true,
    this.acceptTerms = false,
    this.images = const [],
    this.isLoading = false,
    this.user,
    this.error,
    this.address= '',
    this.lat = 0.0,
    this.lng = 0.0,// <- added
  });

  SignUpState copyWith({
    String? name,
    String? email,
    String? password,
    bool? notifications,
    bool? acceptTerms,
    List<File>? images,
    bool? isLoading,
    SignupModel? user,
    String? error,
    String? address,
    double? lat,
    double? lng// <- added
  }) {
    return SignUpState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      notifications: notifications ?? this.notifications,
      acceptTerms: acceptTerms ?? this.acceptTerms,
      images: images ?? this.images,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error,
      address: address ?? this.address,
      lat: lat??this.lat,
      lng: lng?? this.lng// <- added
    );
  }
}
