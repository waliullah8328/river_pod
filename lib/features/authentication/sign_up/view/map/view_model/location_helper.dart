import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

class LocationHelper {
  /// Converts latitude and longitude into a human-readable address
  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;

        // Build a proper address string
        String street = place.street ?? '';
        String locality = place.locality ?? '';
        String administrativeArea = place.administrativeArea ?? '';
        String postalCode = place.postalCode ?? '';
        String country = place.country ?? '';

        // Only include non-empty parts, separated by commas
        final addressParts = [
          street,
          locality,
          administrativeArea,
          postalCode,
          country
        ].where((part) => part.isNotEmpty);

        return addressParts.join(", ");
      }
    } catch (e) {

      if(kDebugMode){
        print("Error getting address: $e");

      }

    }

    return "Unknown location";
  }
}
