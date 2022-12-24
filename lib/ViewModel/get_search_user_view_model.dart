import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/get_search_user_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/gte_search_user_res_model.dart';
import 'package:get/get.dart';

class GetSearchUserViewModel extends GetxController {
  int totalData = 0;
  ApiResponse _getUserResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get getUserResponse => _getUserResponse;

  Future<void> getSearchUserViewModel() async {
    _getUserResponse = ApiResponse.loading(message: 'Loading');

    update();
    try {
      GetSearchUserResponseModel response =
          await GetSearchUserRepo().getSearchUserRepo();
      print("GetSearchUserResponseModel=response==>$response");
      totalData = response.data!.length;
      update();

      _getUserResponse = ApiResponse.complete(response);
    } catch (e) {
      print("GetSearchUserResponseModel=e==>$e");
      _getUserResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
