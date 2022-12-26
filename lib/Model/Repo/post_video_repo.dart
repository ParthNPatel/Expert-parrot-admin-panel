import 'dart:developer';

import 'package:expert_parrot_admin/ViewModel/get_video_view_model.dart';
import 'package:expert_parrot_admin/Widgets/app_color.dart';
import 'package:expert_parrot_admin/Widgets/snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

void uploadSelectedFile(
    {title,
    description,
    PlatformFile? objFile,
    PlatformFile? objFile1,
    GetVideoViewModel? getVideoViewModel}) async {
  //---Create http package multipart request object
  final request = http.MultipartRequest(
    "POST",
    Uri.parse("http://3.109.139.48:5000/video"),
  );
  //-----add other fields if needed
  request.fields.addAll({
    'title': '${title}',
    'description': '${description}',
  });

  //-----add selected file with request
  request.files.add(new http.MultipartFile(
      'video', objFile!.readStream!, objFile.size,
      filename: objFile.name));
  request.files.add(new http.MultipartFile(
      'thumbnail', objFile1!.readStream!, objFile1.size,
      filename: objFile1.name));

  //-------Send request
  var resp = await request.send();

  if (resp.statusCode == 200) {
    //------Read response
    String result = await resp.stream.bytesToString();
    log('API RESPONSE :- $result');
    Get.back();
    snackBarGet('Video Added', snackBarBackGroundColor: AppColor.greenColor);

    await getVideoViewModel!.getVideoViewModel(isLoading: false);
  } else {
    snackBarGet('Something went wrong',
        snackBarBackGroundColor: AppColor.redColor);
    log('Something went wrong');
  }
}
