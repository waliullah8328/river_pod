import '../../../../../core/models/response_data.dart';
import '../../../../../core/services/network_caller.dart';
import '../../../../../core/utils/constants/app_urls.dart';

class VerifyOtpRepository{

  Future<ResponseData> verifyOtp({required String email,required String otp}) async {


    final Map<String, dynamic> requestBody = {
      'email': email,
      'otp': int.tryParse(otp) ?? 0,

    };


    final response = await NetworkCaller().postRequest(AppUrls.forgotVerifyOtp, body: requestBody);


    return response;

  }
}