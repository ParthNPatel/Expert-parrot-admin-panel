import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/get_faq_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_faq_response_model.dart';
import 'package:get/get.dart';

class GetFAQViewModel extends GetxController {
  bool catchError = false;
  int selectedCategories = 0;
  int totalData = 0;

  dynamic selectedValue;

  updateError(val) {
    catchError = val;
    update();
  }

  updateSelectedIndex(int index) {
    selectedCategories = index;
    update();
  }

  updateValue(val) {
    selectedValue = val;
    update();
  }

  /// GET FAQ
  ApiResponse _getFAQApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getFAQApiResponse => _getFAQApiResponse;

  Future<void> getFAQViewModel({bool isLoading = true, String? query}) async {
    if (isLoading) {
      _getFAQApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetFaqResponseModel response = await GetFAQRepo.getFAQRepo(query: query);
      totalData = response.data!.length;
      update();
      updateError(false);
      print("GetFaqResponseModel=response==>$response");

      _getFAQApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetFaqResponseModel=e==>$e");
      updateError(true);
      _getFAQApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
