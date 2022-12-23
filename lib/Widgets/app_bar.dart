import 'package:expert_parrot_admin/Widgets/app_color.dart';
import 'package:expert_parrot_admin/Widgets/images_path.dart';
import 'package:expert_parrot_admin/Widgets/responsive.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget customAppBar({BuildContext? context, onPress}) {
  return AppBar(
    toolbarHeight: 70,
    elevation: 0,
    backgroundColor: AppColor.whiteColor,
    title: Row(
      children: [
        Image.asset(
          AppImages.parrotLogo,
          height: 50,
          width: 100,
        ),
        Text(
          'PANNEL',
          style: TextStyle(
            color: AppColor.blackColor,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    ),
    leading: Responsive.isMobile(context!)
        ? IconButton(
            onPressed: onPress,
            icon: Icon(
              Icons.menu,
              color: AppColor.blackColor,
            ),
          )
        : SizedBox(),
    actions: [
      Center(
        child: Text(
          'Hello, Admin',
          style: TextStyle(
            wordSpacing: 2,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w300,
            fontSize: 21,
          ),
        ),
      ),
      SizedBox(
        width: 100,
      )
    ],
  );
}
