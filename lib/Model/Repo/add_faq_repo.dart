import 'package:expert_parrot_admin/Model/Response_model/add_faq_response_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class AddFaqRepo {
  Future<AddFaqResponseModel> addFaqRepo({Map<String, String>? body}) async {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    var response = await APIService().getResponse(
        url: 'http://52.66.209.219:5000/admin/faq',
        body: body,
        header: header,
        apitype: APIType.aPost);
    print('--response--${response}');
    AddFaqResponseModel addFaqResponseModel =
        await AddFaqResponseModel.fromJson(response);
    print('AddFaqResponseModel $response');
    return addFaqResponseModel;
  }
}
