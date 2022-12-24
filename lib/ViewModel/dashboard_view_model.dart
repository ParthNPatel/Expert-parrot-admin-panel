import 'package:expert_parrot_admin/ViewModel/get_search_user_view_model.dart';
import 'package:expert_parrot_admin/ViewModel/get_video_view_model.dart';
import 'package:get/get.dart';

class DashboardViewModel extends GetxController {
  GetSearchUserViewModel getSearchUserViewModel =
      Get.put(GetSearchUserViewModel());
  GetVideoViewModel getVideoViewModel = Get.put(GetVideoViewModel());

  int videoTotal = 0;
  int userTotal = 0;
  int faqTotal = 8;
  bool catchError = false;

  updateError(val) {
    catchError = val;
    update();
  }

  bool loading = false;

  updateLoading(bool val) {
    loading = val;
    update();
  }

  @override
  void onInit() {
    fetchDashboardData();
    super.onInit();
  }

  fetchDashboardData() async {
    updateLoading(false);
    await getSearchUserViewModel.getSearchUserViewModel();
    await getVideoViewModel.getVideoViewModel();
    Future.delayed(const Duration(seconds: 1), () {
      videoTotal = getVideoViewModel.totalData;
      userTotal = getSearchUserViewModel.totalData;
      // faqTotal = getFAQViewModel.totalData;
      // companyTotal = getCompanyViewModel.totalData;
      // connectUsTotal = connectUsViewModel.totalData;
      // newsTotal = getNewsViewModel.totalData;
      updateLoading(true);
    });
  }
}
