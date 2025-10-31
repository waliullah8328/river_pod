import 'package:flutter/material.dart';
import 'package:river_pod/core/common/widgets/new_custon_widgets/app_snackbar.dart';
import 'package:river_pod/core/services/network_caller.dart';
import 'package:river_pod/core/utils/constants/app_urls.dart';
import '../model/login_model.dart';

class LoginRepository {
  Future<LoginModel> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final body = {
      "email": email,
      "password": password
    };

   final response = await NetworkCaller().postRequest(AppUrls.login,body: body);
    debugPrint(response.statusCode.toString());
    final jsonData = response.responseData;
    final user = LoginModel.fromJson(jsonData);
    if(response.statusCode == 404){

    debugPrint(user.message.toString());
    AppSnackBar.showError(context, user.message.toString());
    return user;
    }

    if (response.statusCode == 200) {

      debugPrint("--------------------------------------------------");
      debugPrint(jsonData.toString());
      debugPrint("--------------------------------------------------");



      debugPrint("----------------------User----------------------------");
      debugPrint(user.toString());
      debugPrint("--------------------------------------------------");


      return user;
    }
    else {

      throw Exception("Login failed: ${response.responseData}");
    }
  }
}
