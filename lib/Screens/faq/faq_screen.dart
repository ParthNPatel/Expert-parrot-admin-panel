import 'dart:developer';

import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_categories_response_model.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_faq_response_model.dart';
import 'package:expert_parrot_admin/ViewModel/add_faq_view_model.dart';
import 'package:expert_parrot_admin/ViewModel/get_categories.dart';
import 'package:expert_parrot_admin/ViewModel/get_faq_view_model.dart';
import 'package:expert_parrot_admin/Widgets/app_color.dart';
import 'package:expert_parrot_admin/Widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  InputBorder outline =
      OutlineInputBorder(borderSide: BorderSide(color: AppColor.grey400));
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  GetFAQViewModel getFAQViewModel = Get.put(GetFAQViewModel());
  GetCategoriesViewModel getCategoriesViewModel =
      Get.put(GetCategoriesViewModel());
  AddFaqViewModel addFaqViewModel = Get.put(AddFaqViewModel());
  @override
  void initState() {
    getCategoriesViewModel.getCategoriesViewModel();
    super.initState();
  }

  GetCategoriesResponseModel? response;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1489;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColor.mainColor),
        ),
        child: GetBuilder<GetCategoriesViewModel>(
          builder: (controller) {
            if (controller.getCategoriesApiResponse.status == Status.LOADING) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (controller.getCategoriesApiResponse.status == Status.COMPLETE) {
              try {
                response = controller.getCategoriesApiResponse.data;
              } catch (e) {
                controller.updateError(true);
              }
              getFAQViewModel.getFAQViewModel(
                  query: response!.data![controller.selectedCategories].id);
              return controller.catchError == false
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'FAQ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const Spacer(),
                                  SizedBox(
                                    height: 40,
                                    width: 250,
                                    child: TextField(
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        border: outline,
                                        focusedBorder: outline,
                                        enabledBorder: outline,
                                        contentPadding: const EdgeInsets.only(
                                            top: 5, left: 10),
                                        suffixIcon: Icon(
                                          Icons.search,
                                          color: Colors.grey.shade400,
                                          size: 20,
                                        ),
                                        hintText: 'Search....',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 83,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.mainColor,
                                      ),
                                      onPressed: () {
                                        faqAddDialog(
                                            context, controller, response!);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'Add',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: AppColor.whiteColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.,

                                children: [
                                  ...List.generate(
                                    response!.data!.length,
                                    (index) => Row(
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () async {
                                            log('INDEX $index');
                                            controller
                                                .updateSelectedIndex(index);

                                            await getFAQViewModel
                                                .getFAQViewModel(
                                              query: response!
                                                  .data![controller
                                                      .selectedCategories]
                                                  .id,
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: AppColor.mainColor),
                                              color: controller
                                                          .selectedCategories ==
                                                      index
                                                  ? AppColor.mainColor
                                                  : AppColor.whiteColor,
                                            ),
                                            child: Text(
                                              response!.data![index].name!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: controller
                                                            .selectedCategories ==
                                                        index
                                                    ? AppColor.whiteColor
                                                    : AppColor.mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 30,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GetBuilder<GetFAQViewModel>(
                              builder: (controller) {
                                if (controller.getFAQApiResponse.status ==
                                    Status.LOADING) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (controller.getFAQApiResponse.status ==
                                    Status.COMPLETE) {
                                  GetFaqResponseModel getFaq =
                                      controller.getFAQApiResponse.data;
                                  return ListView.separated(
                                    reverse: true,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(
                                        height: 20,
                                      );
                                    },
                                    itemCount: getFaq.data!.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Theme(
                                          data: Theme.of(context).copyWith(
                                              dividerColor: Colors.transparent),
                                          child: ExpansionTile(
                                            textColor: AppColor.blackColor,
                                            collapsedTextColor:
                                                AppColor.blackColor,
                                            iconColor: Colors.white,
                                            onExpansionChanged: (val) {},
                                            trailing: const Icon(
                                              Icons.arrow_drop_down,
                                              color: Colors.grey,
                                            ),
                                            collapsedIconColor: Colors.white,
                                            childrenPadding:
                                                const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10),
                                            title: Text(
                                                '${getFaq.data![index].question}'),
                                            children: [
                                              Divider(
                                                  thickness: 1,
                                                  color: Colors.grey.shade200,
                                                  indent: 2,
                                                  endIndent: 2),
                                              Row(
                                                children: [
                                                  Text(
                                                      '${getFaq.data![index].answer}'),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                                return Center(
                                  child: Text('Something went wrong'),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('Something went wrong'),
                    );
            }
            return Center(
              child: Text('Something went wrong'),
            );
          },
        ),
      ),
    );
  }

  var x;
  faqAddDialog(BuildContext context, GetCategoriesViewModel controller,
      GetCategoriesResponseModel response) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black12,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStat) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Container(
                  height: 550,
                  width: 465,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: AppColor.whiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(17),
                          color: AppColor.mainColor,
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: AppColor.whiteColor,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.clear,
                                      color: AppColor.mainColor,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Add New FAQ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColor.whiteColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Categories',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 40,
                                width: 380,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    border: Border.all(color: AppColor.grey100),
                                    borderRadius: BorderRadius.circular(7)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    hint: Text('Select Categories'),
                                    value: controller.selectedValue,
                                    items: response.data!
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e.id,
                                            child: Text(
                                              '${e.name}',
                                              style: TextStyle(
                                                color: AppColor.blackColor,
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (val) {
                                      setStat(() {
                                        controller.updateValue(val!);
                                      });
                                      log('MESSAGE ;- ${controller.selectedValue}');
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              const Text(
                                'Question',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 40,
                                width: 380,
                                child: TextField(
                                  controller: questionController,
                                  decoration: InputDecoration(
                                    border: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                    fillColor: AppColor.grey100,
                                    filled: true,
                                    contentPadding:
                                        const EdgeInsets.only(top: 5, left: 10),
                                    hintText: 'Enter Question',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              const Text(
                                'Answer',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 150,
                                width: 380,
                                child: TextField(
                                  controller: answerController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                    fillColor: AppColor.grey100,
                                    filled: true,
                                    contentPadding: const EdgeInsets.only(
                                      top: 25,
                                      left: 10,
                                    ),
                                    hintText: 'Answer...',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 400,
                                  height: 45,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                    ),
                                    onPressed: () async {
                                      log('MESSAGE ;- ${controller.selectedValue}');
                                      await addFaqViewModel.addFaqViewModel(
                                        model: {
                                          "question":
                                              "${questionController.text.trim()}",
                                          "answer":
                                              "${answerController.text.trim()}",
                                          "categoryId":
                                              "${controller.selectedValue}"
                                        },
                                      );

                                      if (addFaqViewModel
                                              .addFaqApiResponse.status ==
                                          Status.COMPLETE) {
                                        Get.back();
                                        await getFAQViewModel.getFAQViewModel(
                                          isLoading: false,
                                          query: controller.selectedValue,
                                        );
                                        snackBarGet('FAQ Added',
                                            snackBarBackGroundColor:
                                                AppColor.greenColor);
                                      }
                                      if (addFaqViewModel
                                              .addFaqApiResponse.status ==
                                          Status.ERROR) {
                                        snackBarGet('Something went wrong',
                                            snackBarBackGroundColor:
                                                AppColor.redColor);
                                      }
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: AppColor.whiteColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
