import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/add_categories_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/add_categories_res_model.dart';
import 'package:get/get.dart';

class AddCategoriesViewModel extends GetxController {
  ApiResponse _addCategoriesApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addCategoriesApiResponse => _addCategoriesApiResponse;
  bool catchError = false;
  updateError(val) {
    catchError = val;
    update();
  }

  Future<void> addCategoriesViewModel({model}) async {
    _addCategoriesApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddCategoriesResponseModel response =
          await AddCategoriesRepo().addCategoriesRepo(body: model);
      print("AddCategoriesResponseModel=response==>$response");
      updateError(false);

      _addCategoriesApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("AddCategoriesResponseModel=e==>$e");
      _addCategoriesApiResponse = ApiResponse.error(message: 'error');
      updateError(true);
    }
    update();
  }
}
