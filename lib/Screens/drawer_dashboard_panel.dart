import 'package:expert_parrot_admin/Screens/add_categories/add_categories_screen.dart';
import 'package:expert_parrot_admin/Screens/add_post_categories/add_post_categories_screen.dart';
import 'package:expert_parrot_admin/Screens/dashboard/dashboard_screen.dart';
import 'package:expert_parrot_admin/Screens/faq/faq_screen.dart';
import 'package:expert_parrot_admin/Screens/video/video_screen.dart';
import 'package:expert_parrot_admin/Widgets/app_bar.dart';
import 'package:expert_parrot_admin/Widgets/app_color.dart';
import 'package:expert_parrot_admin/Widgets/dashboard_pannel.dart';
import 'package:expert_parrot_admin/Widgets/dashboard_view.dart';
import 'package:expert_parrot_admin/Widgets/responsive.dart';
import 'package:expert_parrot_admin/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DashBoardController dashBoardController = Get.put(DashBoardController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.bgColor,
      appBar: customAppBar(
          context: context,
          onPress: () {
            _scaffoldKey.currentState!.openDrawer();
          }),
      drawer: Responsive.isMobile(context)
          ? DashBoardPanel(
              drawerKey: _scaffoldKey,
            )
          : SizedBox(),
      body: Row(
        children: [
          Responsive.isMobile(context)
              ? SizedBox()
              : DashBoardPanel(
                  drawerKey: _scaffoldKey,
                ),
          Obx(() {
            return Expanded(
              child: dashBoardController.currentScreen.value ==
                      DashBoardPanelScreens.dashboard
                  ? DashboardScreen()
                  : dashBoardController.currentScreen.value ==
                          DashBoardPanelScreens.video
                      ? VideoScreen()
                      : dashBoardController.currentScreen.value ==
                              DashBoardPanelScreens.postCategories
                          ? AddPostCategoriesScreen()
                          : dashBoardController.currentScreen.value ==
                                  DashBoardPanelScreens.FaqCategories
                              ? AddCategoriesScreen()
                              : FAQScreen(),
            );

            // Expanded(
            //   child: dashBoardController.currentScreen.value ==
            //           DashBoardPanelScreens.dashboard
            //       ? DashboardScreen()
            //       : dashBoardController.currentScreen.value ==
            //               DashBoardPanelScreens.video
            //           ? VideoScreen()
            //           : FAQScreen());
          })
        ],
      ),
    );
  }
}
