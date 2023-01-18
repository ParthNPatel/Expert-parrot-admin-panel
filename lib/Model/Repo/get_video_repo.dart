import 'package:expert_parrot_admin/Model/Response_model/get_video_response_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class GetVideoRepo {
  static Future<GetVideoResponseModel> getVideoRepo() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjNjN2FlOGMzNTM2NDJmODRmMWVmMzYz.NXf15WaNpWMn9Yycep_24V2FdQ-k9f8wfJKrpB-xINM'
    };
    var response = await APIService().getResponse(
        url: 'http://52.66.209.219:5000/video',
        apitype: APIType.aGet,
        header: headers);
    print('GetVideo response===>>>  $response');
    GetVideoResponseModel getVideoResponseModel =
        GetVideoResponseModel.fromJson(response);
    return getVideoResponseModel;
  }
}
