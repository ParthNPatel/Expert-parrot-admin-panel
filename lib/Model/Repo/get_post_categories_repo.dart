import 'package:expert_parrot_admin/Model/Response_model/get_post_categories_res_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class GetPostCategoriesRepo {
  static Future<GetPostCategoriesResponseModel> getPostCategoriesRepo() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjM5NDFiMzUwOGRlNDVkY2Y0ODRmMTZh.Fq8YAOcUK9rNZ7j0DaW-k9k5NPjd8DXajOhFcCwRm4U'
    };
    var response = await APIService().getResponse(
        url: 'http://3.109.139.48:5000/post/category',
        apitype: APIType.aGet,
        header: headers);
    print('GetPostCategoriesResponseModel===>>>  $response');
    GetPostCategoriesResponseModel getPostCategoriesResponseModel =
        GetPostCategoriesResponseModel.fromJson(response);
    return getPostCategoriesResponseModel;
  }
}
