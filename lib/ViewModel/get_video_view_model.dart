import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/get_video_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_video_response_model.dart';
import 'package:get/get.dart';

class GetVideoViewModel extends GetxController {
  int totalData = 0;
  bool catchError = false;

  updateError(val) {
    catchError = val;
    update();
  }

  ApiResponse _getVideoApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get getVideoApiResponse => _getVideoApiResponse;

  Future<void> getVideoViewModel({bool isLoading = true}) async {
    if (isLoading) {
      _getVideoApiResponse = ApiResponse.loading(message: 'Loading');
    }

    update();
    try {
      GetVideoResponseModel response = await GetVideoRepo.getVideoRepo();
      print("GetVideoResponseModel=response==>$response");
      totalData = response.data!.length;
      update();
      _getVideoApiResponse = ApiResponse.complete(response);
      updateError(false);
    } catch (e) {
      updateError(true);
      print("GetVideoResponseModel=e==>$e");
      _getVideoApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  @override
  void onInit() {
    getVideoViewModel();
    super.onInit();
  }
}
