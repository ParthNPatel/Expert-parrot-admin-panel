import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../apis/app_exception.dart';

enum APIType {
  aPost,
  aGet,
}

class APIService {
  var response;

  @override
  Future getResponse(
      {required String url,
      required APIType apitype,
      Map<String, dynamic>? body,
      Map<String, String>? header,
      bool fileUpload = false}) async {
    try {
      if (apitype == APIType.aGet) {
        final result = await http.get(Uri.parse(url), headers: header);
        response = returnResponse(result.statusCode, result.body);
      } else if (fileUpload) {
        // dio.FormData formData = new dio.FormData.fromMap(body!);
        //
        // dio.Response result =
        //     await dio.Dio().post('http://3.109.139.48:5000/video',
        //         data: formData,
        //         options: dio.Options(
        //           contentType: "form-data",
        //           headers: header,
        //         ));
        // print('-esult.data-----${result.data}');
        // response = returnResponse(result.statusCode!, jsonEncode(result.data));
        // log("response...dio-api...$response");

      } else {
        print("REQUEST url ======>>>>> $url");
        print("REQUEST PARAMETER ======>>>>> ${jsonEncode(body)}");

        final result = await http.post(Uri.parse(url),
            body: jsonEncode(body), headers: header);
        log("resp${result.body}");
        response = returnResponse(result.statusCode, result.body);
        print(result.statusCode);
      }
    } on SocketException {
      throw FetchDataException('No Internet access');
    }

    return response;
  }

  returnResponse(int status, String result) {
    switch (status) {
      case 200:
        return jsonDecode(result);
      case 201:
        return jsonDecode(result);
      case 400:
        return jsonDecode(result);
      // throw BadRequestException('Bad Request');
      case 401:
        throw UnauthorisedException('Unauthorised user');
      case 404:
        throw ServerException('Server Error');
      case 500:
      default:
        throw FetchDataException('Internal Server Error');
    }
  }
}
