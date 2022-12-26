import 'dart:developer';
import 'dart:typed_data';

import 'package:expert_parrot_admin/Model/Apis/api_response.dart';
import 'package:expert_parrot_admin/Model/Repo/post_video_repo.dart';
import 'package:expert_parrot_admin/Model/Response_model/get_video_response_model.dart';
import 'package:expert_parrot_admin/ViewModel/get_video_view_model.dart';
import 'package:expert_parrot_admin/Widgets/app_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  InputBorder outline =
      OutlineInputBorder(borderSide: BorderSide(color: AppColor.grey400));
  InputBorder outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade200),
      borderRadius: BorderRadius.circular(7));

  GetVideoViewModel getVideoViewModel = Get.put(GetVideoViewModel());
  GetVideoResponseModel? getVideo;

  PlatformFile? objVideo;
  PlatformFile? ObjThumbnail;
  Uint8List? webImage;

  @override
  void initState() {
    getVideoViewModel.getVideoViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1489;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    log('width :- $width');
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Video',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        SizedBox(
                          height: 40,
                          width: 250,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: outline,
                              focusedBorder: outline,
                              enabledBorder: outline,
                              contentPadding:
                                  const EdgeInsets.only(top: 5, left: 10),
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
                              addVideoDialog(context);
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
                    )
                  ],
                ),
              ),
              Container(
                color: AppColor.mainColor,
                padding: const EdgeInsets.all(13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Thumbnail',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Title',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        color: AppColor.mainColor,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            color: AppColor.whiteColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              GetBuilder<GetVideoViewModel>(
                builder: (controller) {
                  if (controller.getVideoApiResponse.status == Status.LOADING) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (controller.getVideoApiResponse.status ==
                      Status.COMPLETE) {
                    try {
                      getVideo = controller.getVideoApiResponse.data;
                    } catch (e) {
                      controller.updateError(true);
                    }
                    return controller.catchError == false
                        ? ListView.separated(
                            // reverse: true,
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: getVideo!.data!.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 12, 10, 12),
                                height: 90,
                                color: AppColor.whiteColor,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        alignment: Alignment.centerLeft,
                                        child: Image.network(
                                          'https://health-app-test.s3.ap-south-1.amazonaws.com/video/${getVideo!.data![index].thumbnail}',
                                          fit: BoxFit.cover,
                                          width: 150,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          getVideo!.data![index].title ?? 'NA',
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: AppColor.blackColor,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          getVideo!.data![index].description ??
                                              'NA',
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: AppColor.blackColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text('Something went wrong'),
                          );
                  }
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  addVideoDialog(BuildContext context) {
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
                  height: 620,
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
                                  setStat(() {
                                    objVideo = null;
                                    ObjThumbnail = null;
                                  });
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
                                    'Add New Video',
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Thumbnail',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            var result = await FilePicker
                                                .platform
                                                .pickFiles(
                                              allowMultiple: false,
                                              type: FileType.image,
                                              withReadStream: true,
                                            );
                                            if (result != null) {
                                              setStat(() {
                                                ObjThumbnail =
                                                    result.files.single;
                                              });
                                              webImage =
                                                  result.files.first.bytes;
                                              log('WEB IMAGE 1:- $webImage');
                                              log('WEB IMAGE 2:- $result');
                                              log('WEB IMAGE 3:- $ObjThumbnail');
                                            }
                                          },
                                          child: Container(
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade50,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  7,
                                                ),
                                              ),
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    ObjThumbnail != null
                                                        ? Icons.done
                                                        : Icons.image,
                                                    color: AppColor.mainColor,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Add Thumbnail',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: AppColor.mainColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Video',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            var result = await FilePicker
                                                .platform
                                                .pickFiles(
                                              allowMultiple: false,
                                              type: FileType.video,
                                              withReadStream:
                                                  true, // this will return PlatformFile object with read stream
                                            );
                                            if (result != null) {
                                              setStat(() {
                                                objVideo = result.files.single;
                                              });
                                            }
                                            setStat(() {});
                                          },
                                          child: Container(
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.grey.shade50,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                7,
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  objVideo != null
                                                      ? Icons.done
                                                      : Icons.video_camera_back,
                                                  color: AppColor.mainColor,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Add Video',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: AppColor.mainColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text(
                                'Title',
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
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    border: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                    fillColor: Colors.grey.shade50,
                                    filled: true,
                                    contentPadding:
                                        const EdgeInsets.only(top: 5, left: 10),
                                    hintText: 'Enter Title',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              const Text(
                                'Description',
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
                                  controller: descriptionController,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    border: outlineBorder,
                                    focusedBorder: outlineBorder,
                                    enabledBorder: outlineBorder,
                                    fillColor: Colors.grey.shade50,
                                    filled: true,
                                    contentPadding: const EdgeInsets.only(
                                      top: 25,
                                      left: 10,
                                    ),
                                    hintText: 'Type',
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 400,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.mainColor,
                                    ),
                                    onPressed: () async {
                                      uploadSelectedFile(
                                          description: descriptionController
                                              .text
                                              .toString(),
                                          title:
                                              titleController.text.toString(),
                                          objFile1: ObjThumbnail,
                                          objFile: objVideo,
                                          getVideoViewModel: getVideoViewModel);

                                      Get.back();
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
