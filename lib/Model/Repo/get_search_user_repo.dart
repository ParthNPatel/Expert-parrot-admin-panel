import 'package:expert_parrot_admin/Model/Response_model/gte_search_user_res_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class GetSearchUserRepo {
  var headers = {
    'Authorization':
        'Bearer eyJhbGciOiJIUzI1NiJ9.NjM5MmM2ZTViODU1YmE4MzIxMzQyODJm.uE2uzq0YV1nGkNS3g2a3EUZv85in1lwHHO7I_hr6ZNM'
  };
  Future<GetSearchUserResponseModel> getSearchUserRepo() async {
    var response = await APIService().getResponse(
        url: 'http://3.109.139.48:5000/user/search',
        apitype: APIType.aGet,
        header: headers);
    print('GetSearchUserResponseModel response===>>>  $response');
    GetSearchUserResponseModel getSearchUserResponseModel =
        GetSearchUserResponseModel.fromJson(response);
    return getSearchUserResponseModel;
  }
}
