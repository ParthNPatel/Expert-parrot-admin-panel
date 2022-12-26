import 'package:expert_parrot_admin/Model/Response_model/add_post_categories_res_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class AddPostCategoriesRepo {
  Future<AddPostCategoriesResponseModel> addPostCategoriesRepo(
      {Map<String, String>? body}) async {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    var response = await APIService().getResponse(
        url: 'http://3.109.139.48:5000/post/category',
        body: body,
        header: header,
        apitype: APIType.aPost);
    print('--response--${response}');
    AddPostCategoriesResponseModel addPostCategoriesResponseModel =
        await AddPostCategoriesResponseModel.fromJson(response);
    print('AddPostCategoriesResponseModel $response');
    return addPostCategoriesResponseModel;
  }
}
