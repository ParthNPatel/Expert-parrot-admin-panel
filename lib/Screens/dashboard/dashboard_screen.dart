import 'package:expert_parrot_admin/Widgets/app_color.dart';
import 'package:expert_parrot_admin/Widgets/responsive.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(50, 25, 0, 25),
        child: Responsive.isMobile(context)
            ? Column(
                children: [
                  homeContainer(color: AppColor.parrotColor, height: 500),
                  homeContainer(color: AppColor.purple300, height: 500),
                  homeContainer(color: AppColor.orange300, height: 500),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  homeContainer(color: AppColor.parrotColor, height: 500),
                  homeContainer(color: AppColor.purple300, height: 500),
                  homeContainer(color: AppColor.orange300, height: 500),
                ],
              ),
      ),
      // backgroundColor: Colors.grey,
    );
  }

  Expanded homeContainer({height, color}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 50, bottom: 50),
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
      ),
    );
  }
}
