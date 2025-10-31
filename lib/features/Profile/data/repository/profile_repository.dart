import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import 'package:river_pod/core/services/auth_service.dart';
import 'package:river_pod/core/services/network_caller.dart';
import 'package:river_pod/core/utils/constants/app_urls.dart';
import 'package:river_pod/features/Profile/data/model/profile_model.dart';



class ProfileRepository {
  Future<GetMyProfileModel> fetchUser() async {
    final response = await NetworkCaller().getRequest(
      AppUrls.getMyProfile,
      token: AuthService.token,
    );

    debugPrint('Status: ${response.statusCode}');
    debugPrint('Response: ${response.responseData}');

    if (response.isSuccess) {
      return GetMyProfileModel.fromJson(response.responseData);
    } else {
      throw Exception("Failed to load profile");
    }
  }

  Future<void> updateProfile({
    required String name,
    required String about,
    required String location,
    required double lat,
    required double lng,
    required String image

  }) async {


    final Map<String, dynamic> requestBody = {
      "name":name,

      //"availability": selectedAvailability.value,
      "location":location,
      "latitude":lat,
      "longitude":lng,
      "about":about

    };

    await _sendPutRequestWithHeadersAndImagesOnly(
      AppUrls.getMyProfile,
      requestBody,
      image,
      AuthService.token,
    );

  }

  Future<void> _sendPutRequestWithHeadersAndImagesOnly(
      String url,
      Map<String, dynamic> body,
      String? imagePath,
      String? token,
      ) async {
    debugPrint("------------------------${AuthService.token}----------------------------------");
    if (token == null || token.isEmpty) {
      debugPrint(token.toString());

      return;
    }

    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      request.headers.addAll({
        'Authorization': "Bearer $token",
      });

      request.fields['bodyData'] = jsonEncode(body);

      if (imagePath != null && imagePath.isNotEmpty) {
        final mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
        final splitMime = mimeType.split('/');

        log('Attaching image: $imagePath');
        request.files.add(await http.MultipartFile.fromPath(
          'profileImage',
          imagePath,
          contentType: MediaType(splitMime[0], splitMime[1]),
        ));
      }

      log('Request Headers: ${request.headers}');
      log('Request Fields: ${request.fields}');

      var response = await request.send();
      debugPrint("----------------------------------------------------------");

      debugPrint(response.statusCode.toString());
      var responseBody = await response.stream.bytesToString();
      debugPrint(responseBody.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {

        debugPrint('Update Profile successfully!');

      } else {
        var errorResponse = await response.stream.bytesToString();
        log('Response error: $errorResponse');
        debugPrint('Failed to upload profile.');

      }
    } catch (e) {
      log('Request error: $e');
      debugPrint('Failed to upload profile. Please try again.');

    }
  }





}
