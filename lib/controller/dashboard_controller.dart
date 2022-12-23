// ignore_for_file: library_prefixes
import 'package:expert_parrot_admin/Widgets/dashboard_view.dart';
import 'package:get/get.dart';

class DashBoardController extends GetxController {
  Rx<DashBoardPanelScreens> currentScreen = DashBoardPanelScreens.dashboard.obs;

  var hover = false.obs;
  var hover1 = false.obs;
  var hover2 = false.obs;

  updateHover(bool val) {
    hover.value = val;
    update();
  }

  updateHover1(bool val) {
    hover1.value = val;
    update();
  }

  updateHover2(bool val) {
    hover2.value = val;
    update();
  }
}
