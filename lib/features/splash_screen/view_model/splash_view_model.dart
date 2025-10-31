
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import 'package:river_pod/features/splash_screen/view_model/splash_state.dart';

import '../../../core/services/auth_service.dart';
import '../../../core/services/location_service.dart';
import '../../../route/routes_name.dart';

/// PROVIDER — Used to access SplashNotifier
final splashControllerProvider =
StateNotifierProvider<SplashNotifier, SplashState>(
      (ref) => SplashNotifier(ref),
);

/// NOTIFIER — Handles logic (location + navigation)
class SplashNotifier extends StateNotifier<SplashState> {
  final Ref ref;
  final LocationService _locationService = LocationService();

  SplashNotifier(this.ref) : super(const SplashState());

  /// Called on splash screen start
  Future<void> init(BuildContext context) async {
    await _fetchLocation();
    await _navigateNext(context);
  }

  /// Fetch location (same for iOS/Android)
  Future<void> _fetchLocation() async {
    state = state.copyWith(isLoading: true);

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String address = '';
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        address = [
          placemark.administrativeArea,
          placemark.country,
        ].where((e) => e != null && e.isNotEmpty).join(', ');
      }

      _locationService.setLocation(position.latitude, position.longitude, address);

      state = state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        address: address,
        isLoading: false,
      );

      debugPrint('✅ Location fetched: $address');
    } catch (e) {
      debugPrint('❌ Location error: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Navigate after splash delay
  Future<void> _navigateNext(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    debugPrint("---------------------------------------");
    debugPrint(AuthService.token);
    debugPrint("---------------------------------------");

    if (AuthService.hasSeenOnboarding()) {
      if (AuthService.hasToken()) {
        // context.go(RouteNames.homeScreen);
        Navigator.pushReplacementNamed(context, RouteNames.homeScreen);
      } else {
        //context.go(RouteNames.loginScreen);
        Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
      }
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.onboardingScreen);
    }
  }
}