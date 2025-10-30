class SplashState {
  final double latitude;
  final double longitude;
  final String address;
  final bool isLoading;
  final String? error;

  const SplashState({
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.address = '',
    this.isLoading = false,
    this.error,
  });

  SplashState copyWith({
    double? latitude,
    double? longitude,
    String? address,
    bool? isLoading,
    String? error,
  }) {
    return SplashState(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
