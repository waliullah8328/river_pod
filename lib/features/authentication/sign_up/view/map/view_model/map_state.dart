import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mapControllerProvider =
StateNotifierProvider<MapControllerNotifier, MapState>(
      (ref) => MapControllerNotifier(),
);

class MapState {
  final LatLng initialLocation;
  final LatLng? selectedLocation;
  final GoogleMapController? controller;
  final double currentZoom;

  const MapState({
    this.initialLocation = const LatLng(23.8103, 90.4125), // Dhaka default
    this.selectedLocation,
    this.controller,
    this.currentZoom = 14.0,
  });

  MapState copyWith({
    LatLng? initialLocation,
    LatLng? selectedLocation,
    GoogleMapController? controller,
    double? currentZoom,
  }) {
    return MapState(
      initialLocation: initialLocation ?? this.initialLocation,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      controller: controller ?? this.controller,
      currentZoom: currentZoom ?? this.currentZoom,
    );
  }
}

class MapControllerNotifier extends StateNotifier<MapState> {
  MapControllerNotifier() : super(const MapState());

  void setMapController(GoogleMapController controller) {
    state = state.copyWith(controller: controller);
  }

  void selectLocation(LatLng location) {
    state = state.copyWith(selectedLocation: location);
  }

  Future<void> zoomIn() async {
    if (state.controller != null) {
      final newZoom = state.currentZoom + 1;
      await state.controller!.animateCamera(
        CameraUpdate.zoomTo(newZoom),
      );
      state = state.copyWith(currentZoom: newZoom);
    }
  }

  Future<void> zoomOut() async {
    if (state.controller != null) {
      final newZoom = state.currentZoom - 1;
      await state.controller!.animateCamera(
        CameraUpdate.zoomTo(newZoom),
      );
      state = state.copyWith(currentZoom: newZoom);
    }
  }
}
