
import '../../../../../core/models/response_data.dart';
import '../../../../../core/services/network_caller.dart';
import '../../../../../core/utils/constants/app_urls.dart';

class ForgetRepository{

  Future<ResponseData> forgetEmail({required String email}) async {


    final Map<String, dynamic> requestBody = {
      'email': email,

    };


      final response = await NetworkCaller().postRequest(AppUrls.forgetEmail, body: requestBody);


      return response;

  }
}