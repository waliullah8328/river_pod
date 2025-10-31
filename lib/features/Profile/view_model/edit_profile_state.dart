class EditProfileState {
  final String name;
  final String about;
  final String location;
  final String image;
  final double lat;
  final double lng;
  final bool isLoading;
  final String? error;
  final bool isInitialized; // new

  EditProfileState({
    this.name = "",
    this.about = "",
    this.location = "",
    this.image = "",
    this.lat = 0.0,
    this.lng = 0.0,
    this.isLoading = false,
    this.error,
    this.isInitialized = false, // default
  });

  EditProfileState copyWith({
    String? name,
    String? about,
    String? location,
    String? image,
    double? lat,
    double? lng,
    bool? isLoading,
    String? error,
    bool? isInitialized, // new
  }) {
    return EditProfileState(
      name: name ?? this.name,
      about: about ?? this.about,
      location: location ?? this.location,
      image: image ?? this.image,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}
