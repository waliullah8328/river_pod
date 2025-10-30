import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../../login/data/model/login_model.dart';



class SignupRepository {
  Future<void> signup({required String name,email,password,required bool notification,required bool acceptTerms,required List<File> images,required String address}) async {
    final body = jsonEncode({"email": email, "password": password});

    final response = await http.post(
      Uri.parse("https://api.mrphrenfix.com/api/v1/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    debugPrint(response.statusCode.toString());

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      final user = LoginModel.fromJson(jsonData);

      // Navigate after successful login
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));

      //return user;
    } else {
      throw Exception("Login failed: ${response.body}");
    }
  }
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse('https://api.mrphrenfix.com/api/v1/user/create'),
  //   );
  //
  //   if(kDebugMode){
  //     print(name);
  //     print(email);
  //     print(password);
  //     print(notification);
  //     print(images);
  //     print(acceptTerms);
  //   }
  //
  //   final body = <String, dynamic>{
  //     "email": email,
  //     "name": name,
  //     "password": password,
  //     "role": "ENGINEER",
  //     "location": "Dhaka",
  //     "longitude":  0.0,
  //     "latitude":  0.0,
  //
  //     "about": "",
  //     // if(role)"availability" : formattedSchedule,
  //     // if(role)"profession" : selectedCategories
  //
  //
  //     // Optional: include selected categories for backend
  //
  //   };
  //
  //   request.fields['body'] =jsonEncode(body);
  //
  //
  //   // for (var file in images) {
  //   //   request.files.add(await http.MultipartFile.fromPath('tradeImage', file.path));
  //   // }
  //
  //   final response = await request.send();
  //   final resBody = await response.stream.bytesToString();
  //
  //   if(kDebugMode){
  //     // ✅ Get response body correctly
  //
  //
  //     if (kDebugMode) {
  //       print("STATUS CODE: ${response.statusCode}");
  //       print("STATUS CODE: $body");
  //       print("RESPONSE BODY: $resBody");
  //     }
  //   }
  //
  //   if (response.statusCode == 200 ) {
  //     final data = jsonDecode(resBody);
  //     print("✅ Signup Successful: $data");
  //     //return model; // returning back same model for success
  //   } else {
  //     throw Exception("Signup Failed: ${response.statusCode}");
  //   }
  // }
}
