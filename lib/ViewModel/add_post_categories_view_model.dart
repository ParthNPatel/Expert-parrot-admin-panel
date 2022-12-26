import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/add_post_categories.dart';
import 'package:expert_parrot_admin/Model/Response_model/add_post_categories_res_model.dart';
import 'package:get/get.dart';

class AddPostCategoriesViewModel extends GetxController {
  ApiResponse _addPostCategoriesApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addPostCategoriesApiResponse => _addPostCategoriesApiResponse;
  bool catchError = false;
  updateError(val) {
    catchError = val;
    update();
  }

  Future<void> addPostCategoriesViewModel({model}) async {
    _addPostCategoriesApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddPostCategoriesResponseModel response =
          await AddPostCategoriesRepo().addPostCategoriesRepo(body: model);
      print("AddPostCategoriesResponseModel=response==>$response");
      updateError(false);

      _addPostCategoriesApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("AddPostCategoriesResponseModel=e==>$e");
      _addPostCategoriesApiResponse = ApiResponse.error(message: 'error');
      updateError(true);
    }
    update();
  }
}
