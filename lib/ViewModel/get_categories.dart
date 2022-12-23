import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/get_faq_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_categories_response_model.dart';
import 'package:get/get.dart';

class GetCategoriesViewModel extends GetxController {
  bool catchError = false;
  int selectedCategories = 0;
  dynamic selectedValue;

  updateSelectedIndex(int index) {
    selectedCategories = index;
    update();
  }

  updateError(val) {
    catchError = val;
    update();
  }

  updateValue(val) {
    selectedValue = val;
    update();
  }

  ApiResponse _getCategoriesApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getCategoriesApiResponse => _getCategoriesApiResponse;

  Future<void> getCategoriesViewModel(
      {bool isLoading = true, String? query}) async {
    if (isLoading) {
      _getCategoriesApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetCategoriesResponseModel response =
          await GetFAQRepo.getCategoriesRepo();
      updateError(false);

      print("GetCategoriesResponseModel=response==>$response");

      _getCategoriesApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetCategoriesResponseModel=e==>$e");
      updateError(true);
      _getCategoriesApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
