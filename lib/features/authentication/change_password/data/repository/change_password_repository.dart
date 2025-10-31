import '../../../../../core/models/response_data.dart';
import '../../../../../core/services/network_caller.dart';
import '../../../../../core/utils/constants/app_urls.dart';

class ChangePasswordRepository{
  Future<ResponseData> verifyOtp({required String token,required String password}) async {


    final Map<String, dynamic> requestBody = {
      "token": token,
      "password" : password

    };


    final response = await NetworkCaller().postRequest(AppUrls.resetPassword, body: requestBody);


    return response;

  }

}