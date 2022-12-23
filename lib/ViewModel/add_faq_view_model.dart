import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/add_faq_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/add_faq_response_model.dart';
import 'package:get/get.dart';

class AddFaqViewModel extends GetxController {
  ApiResponse _addFaqApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addFaqApiResponse => _addFaqApiResponse;
  bool catchError = false;
  updateError(val) {
    catchError = val;
    update();
  }

  Future<void> addFaqViewModel({model}) async {
    _addFaqApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddFaqResponseModel response = await AddFaqRepo().addFaqRepo(body: model);
      print("AddFaqResponseModel=response==>$response");
      updateError(false);

      _addFaqApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("AddFaqResponseModel=e==>$e");
      _addFaqApiResponse = ApiResponse.error(message: 'error');
      updateError(true);
    }
    update();
  }
}
