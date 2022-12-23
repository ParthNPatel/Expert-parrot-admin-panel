import 'package:expert_parrot_admin/Model/Response_model/get_video_response_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class GetVideoRepo {
  static Future<GetVideoResponseModel> getVideoRepo() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjM5MmM2ZTViODU1YmE4MzIxMzQyODJm.uE2uzq0YV1nGkNS3g2a3EUZv85in1lwHHO7I_hr6ZNM'
    };
    var response = await APIService().getResponse(
        url: 'http://3.109.139.48:5000/video',
        apitype: APIType.aGet,
        header: headers);
    print('GetVideo response===>>>  $response');
    GetVideoResponseModel getVideoResponseModel =
        GetVideoResponseModel.fromJson(response);
    return getVideoResponseModel;
  }
}
