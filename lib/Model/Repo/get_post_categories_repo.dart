import 'package:expert_parrot_admin/Model/Response_model/get_post_categories_res_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class GetPostCategoriesRepo {
  static Future<GetPostCategoriesResponseModel> getPostCategoriesRepo() async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.NjNjN2FlOGMzNTM2NDJmODRmMWVmMzYz.NXf15WaNpWMn9Yycep_24V2FdQ-k9f8wfJKrpB-xINM'
    };
    var response = await APIService().getResponse(
        url: 'http://52.66.209.219:5000/post/category',
        apitype: APIType.aGet,
        header: headers);
    print('GetPostCategoriesResponseModel===>>>  $response');
    GetPostCategoriesResponseModel getPostCategoriesResponseModel =
        GetPostCategoriesResponseModel.fromJson(response);
    return getPostCategoriesResponseModel;
  }
}
