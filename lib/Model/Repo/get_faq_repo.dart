import 'package:expert_parrot_admin/Model/Response_model/get_categories_response_model.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_faq_response_model.dart';
import 'package:expert_parrot_admin/Model/Services/api_service.dart';

class GetFAQRepo {
  static Future<GetFaqResponseModel> getFAQRepo({String? query}) async {
    var response = await APIService().getResponse(
      url: 'http://52.66.209.219:5000/admin/faq/$query',
      apitype: APIType.aGet,
    );
    print('GetFaqResponseModel===>>>  $response');
    GetFaqResponseModel getFaqResponseModel =
        GetFaqResponseModel.fromJson(response);
    return getFaqResponseModel;
  }

  static Future<GetCategoriesResponseModel> getCategoriesRepo() async {
    var response = await APIService().getResponse(
      url: 'http://52.66.209.219:5000/admin/category',
      apitype: APIType.aGet,
    );
    print('GetCategoriesResponseModel===>>>  $response');
    GetCategoriesResponseModel getCategoriesResponseModel =
        GetCategoriesResponseModel.fromJson(response);
    return getCategoriesResponseModel;
  }
}
