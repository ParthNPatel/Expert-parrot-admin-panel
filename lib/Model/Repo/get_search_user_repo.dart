import 'package:expert_parrot_admin/Model/Response_model/gte_search_user_res_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class GetSearchUserRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjNjN2FlOGMzNTM2NDJmODRmMWVmMzYz.NXf15WaNpWMn9Yycep_24V2FdQ-k9f8wfJKrpB-xINM'
  };
  Future<GetSearchUserResponseModel> getSearchUserRepo() async {
    var response = await APIService().getResponse(
        url: 'http://52.66.209.219:5000/user/search',
        apitype: APIType.aGet,
        header: headers);
    print('GetSearchUserResponseModel response===>>>  $response');
    GetSearchUserResponseModel getSearchUserResponseModel =
        GetSearchUserResponseModel.fromJson(response);
    return getSearchUserResponseModel;
  }
}
