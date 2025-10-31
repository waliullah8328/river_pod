import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:river_pod/core/common/widgets/new_custon_widgets/custom_text_form_field.dart';
import 'package:river_pod/core/utils/constants/icon_path.dart';
import 'package:river_pod/core/utils/constants/image_path.dart';
import '../../authentication/sign_up/view/map/view/map_screen.dart';
import '../../authentication/sign_up/view/map/view_model/location_helper.dart';
import '../view_model/update_profile_view_model.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _aboutController = TextEditingController();
  final _locationController = TextEditingController();
  File? _pickedImage;
  bool _initialized = false;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
      ref.read(updateProfileProvider.notifier).setImage(picked.path);
    }
  }

  void _initializeFields(profile) {
    if (!_initialized && profile != null) {
      // Run after build completes
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _nameController.text = profile.name ?? "";
        _aboutController.text = profile.about ?? "";
        _locationController.text = profile.location ?? "";

        final notifier = ref.read(updateProfileProvider.notifier);
        notifier.setName(profile.name ?? "");
        notifier.setAbout(profile.about ?? "");
        notifier.setLocation(profile.location ?? "");
        notifier.setImage(profile.image ?? "");
        notifier.setLat(profile.latitude ?? 0.0);
        notifier.setLng(profile.longitude ?? 0.0);

        setState(() => _initialized = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileProvider);
    final updateState = ref.watch(updateProfileProvider);
    final notifier = ref.read(updateProfileProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Edit Profile"), centerTitle: true),
      body: profileState.when(
        data: (profileData) {
          final profile = profileData.data;
          _initializeFields(profile);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Profile Image
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: _pickedImage != null
                              ? FileImage(_pickedImage!)
                              : (updateState.image.isNotEmpty
                              ? NetworkImage(updateState.image)
                              : const AssetImage(ImagePath.onBoardingImage))
                          as ImageProvider,
                        ),
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.edit, color: Colors.white, size: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Name
                  CustomTextField(
                    controller: _nameController,
                    onChanged: notifier.setName,
                    hintText: "Full Name",
                  ),
                  const SizedBox(height: 16),

                  // About
                  CustomTextField(
                    controller: _aboutController,
                    onChanged: notifier.setAbout,
                    maxLine: 3,
                    hintText: "About",
                  ),
                  const SizedBox(height: 16),

                  // Location
                  CustomTextField(
                    controller: _locationController,
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

                          notifier.setLocation(address);
                          _locationController.text = address;
                          notifier.setLat(selectedLocation.latitude);
                          notifier.setLng(selectedLocation.longitude);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(IconPath.locationIcon, height: 20, width: 20),
                      ),
                    ),
                    validator: (value) => (value?.isEmpty ?? true) ? "Enter your location" : null,
                  ),
                  const SizedBox(height: 30),

                  // Save Button
                  // Save Button
                  updateState.isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text("Save Changes"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await notifier.updateProfile();

                        if (mounted && updateState.error == null) {
                          // Refresh profileProvider
                          ref.invalidate(profileProvider);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Profile updated successfully!")),
                          );

                          Navigator.pop(context); // Go back to Profile screen
                        } else if (updateState.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Update failed: ${updateState.error}")),
                          );
                        }
                      }
                    },

                  ),

                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Error: $err")),
      ),
    );
  }
}
