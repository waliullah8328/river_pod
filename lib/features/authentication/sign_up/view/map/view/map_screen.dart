import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../../core/common/widgets/custom_text.dart';
import '../../../../../../../core/utils/constants/app_sizer.dart';
import '../../../../../../../core/utils/constants/app_sizes.dart';
import '../view_model/map_state.dart';

class MapScreenProfile extends ConsumerWidget {
  const MapScreenProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mapControllerProvider);
    final mapController = ref.read(mapControllerProvider.notifier);

    return Scaffold(
      body: Stack(
        children: [
          /// Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: mapState.initialLocation,
              zoom: mapState.currentZoom,
            ),
            onMapCreated: mapController.setMapController,
            onTap: mapController.selectLocation,
            markers: mapState.selectedLocation != null
                ? {
              Marker(
                markerId: const MarkerId("selected"),
                position: mapState.selectedLocation!,
              )
            }
                : {},
          ),

          /// Header Bar
          Positioned(
            top: getHeight(60),
            left: getWidth(16),
            right: getWidth(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back_ios_new_outlined,
                      color: Colors.black),
                ),
                SizedBox(width: 80.w),
                CustomText(
                  text: "Select Location",
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),

          /// Zoom Controls
          Positioned(
            bottom: 100,
            right: 16,
            child: Column(
              children: [
                FloatingActionButton.small(
                  heroTag: "zoom_in",
                  backgroundColor: Colors.white,
                  onPressed: () => mapController.zoomIn(),
                  child: const Icon(Icons.add, color: Colors.black),
                ),
                const SizedBox(height: 10),
                FloatingActionButton.small(
                  heroTag: "zoom_out",
                  backgroundColor: Colors.white,
                  onPressed: () => mapController.zoomOut(),
                  child: const Icon(Icons.remove, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),

      /// Confirm Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (mapState.selectedLocation != null) {
            Navigator.pop(context, mapState.selectedLocation);
          }
        },
        child: const Icon(Icons.check, size: 30, weight: 6),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
