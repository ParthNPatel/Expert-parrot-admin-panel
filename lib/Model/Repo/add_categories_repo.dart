import 'package:expert_parrot_admin/Model/Response_model/add_categories_res_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class AddCategoriesRepo {
  Future<AddCategoriesResponseModel> addCategoriesRepo(
      {Map<String, String>? body}) async {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    var response = await APIService().getResponse(
        url: 'http://3.109.139.48:5000/admin/category',
        body: body,
        header: header,
        apitype: APIType.aPost);
    print('--response--${response}');
    AddCategoriesResponseModel addCategoriesResponseModel =
        await AddCategoriesResponseModel.fromJson(response);
    print('AddFaqResponseModel $response');
    return addCategoriesResponseModel;
  }
}
