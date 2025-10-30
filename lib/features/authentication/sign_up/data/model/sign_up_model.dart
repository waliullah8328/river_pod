import 'dart:io';

class SignupModel {
  final String name;
  final String email;
  final String password;
  final bool notifications;
  final bool acceptTerms;
  final List<File> images;

  SignupModel({
    required this.name,
    required this.email,
    required this.password,
    required this.notifications,
    required this.acceptTerms,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "notifications": notifications,
      "acceptTerms": acceptTerms,
      "images": images.map((e) => e.path).toList(),
    };
  }
}
