import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:river_pod/core/common/widgets/new_custon_widgets/custom_text_form_field.dart';

import 'package:river_pod/core/utils/constants/icon_path.dart';


import '../view_model/sign_up_view_model.dart';
import 'map/view_model/location_helper.dart';
import 'map/view/map_screen.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  Widget buildImagePreview(List<File> images) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: images
          .map((img) => ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(img, height: 60, width: 60, fit: BoxFit.cover),
      ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpNotifierProvider);
    final notifier = ref.read(signUpNotifierProvider.notifier);
    final locationController = TextEditingController(text: state.address);

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Name
            CustomTextField(
              hintText: "Name",
              onChanged: notifier.setName,
              value: state.name,
            ),
            const SizedBox(height: 12),

            /// Email
            CustomTextField(
              hintText: "Email",
              onChanged: notifier.setEmail,
              value: state.email,
            ),
            const SizedBox(height: 12),

            /// Password with eye toggle
            CustomTextField(
              hintText: "Password",
              onChanged: notifier.setPassword,
              value: state.password,
              obscureText: true,
            ),
            const SizedBox(height: 12),

            /// Location picker (with reverse geocoding)
            CustomTextField(
              controller: locationController,
              hintText: "Select your location",
              readOnly: true,
              prefixIcon: GestureDetector(
                onTap: () async {
                  final selectedLocation = await Navigator.push<LatLng>(
                    context,
                    MaterialPageRoute(builder: (_) => const MapScreenProfile()),
                  );

                  if (selectedLocation != null) {
                    final address = await LocationHelper.getAddressFromLatLng(
                      selectedLocation.latitude,
                      selectedLocation.longitude,
                    );

                    notifier.setAddress(address);
                    locationController.text = address;
                    notifier.setLat(selectedLocation.longitude);
                    notifier.setLng(selectedLocation.longitude);

                    debugPrint(selectedLocation.latitude.toString());
                    debugPrint(selectedLocation.longitude.toString());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(IconPath.locationIcon, height: 20, width: 20),
                ),
              ),
              validator: (value) {
                if (value?.isEmpty ?? false) return "Enter your location";
                return null;
              },
              maxLine: 1,
            ),

            const SizedBox(height: 8),

            /// Accept Terms
            Row(
              children: [
                Checkbox(
                  value: state.acceptTerms,
                  onChanged: (val) {
                    if (val != null) notifier.setAcceptTerms(val);
                  },
                ),
                const Expanded(
                  child: Text("Accept Terms & Conditions"),
                ),
              ],
            ),
            const SizedBox(height: 8),

            /// Pick image
            ElevatedButton(
              onPressed: () => notifier.pickSingleImage(),
              child: const Text("Pick Image"),
            ),
            const SizedBox(height: 8),

            if (state.images.isNotEmpty) buildImagePreview(state.images),
            const SizedBox(height: 20),

            /// Register button
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () => notifier.register(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: state.isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
                  : const Text("Sign Up"),
            ),

            /// Feedback/Error messages
            const SizedBox(height: 10),
            if (state.error != null)
              Text(
                state.error!,
                style: const TextStyle(color: Colors.red),
              ),
            if (state.user != null)
              const Text(
                "Sign Up Successful",
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
