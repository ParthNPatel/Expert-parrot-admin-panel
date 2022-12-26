import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/get_post_categories_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_post_categories_res_model.dart';
import 'package:get/get.dart';

class GetPostCategoriesViewModel extends GetxController {
  bool catchError = false;

  updateError(val) {
    catchError = val;
    update();
  }

  ApiResponse _getPostCategoriesApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getPostCategoriesApiResponse => _getPostCategoriesApiResponse;

  Future<void> getPostCategoriesViewModel(
      {bool isLoading = true, String? query}) async {
    if (isLoading) {
      _getPostCategoriesApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetPostCategoriesResponseModel response =
          await GetPostCategoriesRepo.getPostCategoriesRepo();
      updateError(false);

      print("GetCategoriesResponseModel=response==>$response");

      _getPostCategoriesApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetCategoriesResponseModel=e==>$e");
      updateError(true);
      _getPostCategoriesApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
