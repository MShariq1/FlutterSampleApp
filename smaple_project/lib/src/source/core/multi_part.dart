import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class MultipartClient {
  static final Dio _dio = Dio();
  // static Future<dynamic> updateProfileImage(Uri uri, XFile file) async {
  //   final header = {
  //     'Content-Type': 'multipart/form-data',
  //     'accept': 'application/json',
  //   };
  //   final http.MultipartRequest request = http.MultipartRequest('POST', uri);
  //   request.headers.addAll(header);
  //   final String fileExtension = file.path.split('.').last;
  //   final files = await http.MultipartFile.fromPath('images', file.path,
  //       contentType: MediaType("image", fileExtension),
  //       filename: DateTime.now().millisecondsSinceEpoch.toString());
  //   request.files.addAll([files]);
  //   final response = await request.send();
  //   if (response.statusCode != 200) return null;
  //   final responseData = await response.stream.toBytes();
  //   final responseToString = String.fromCharCodes(responseData);
  //   final jsonBody = jsonDecode(responseToString);
  //   if(jsonBody['status']!=200)return null;
  //   return jsonBody["images"].first+".$fileExtension";
  // }
  static Future<String?> updateProfileImageDio(Uri uri, XFile file) async {
    FormData postData = FormData.fromMap({
      'images': [await MultipartFile.fromFile(file.path,
            filename: file.path.split('/').last,
            contentType: MediaType('image', file.path.split('.').last))]
    });
    try {
      final response = await _dio.post("http://209.126.81.76:30005/files/upload/image",
          data: postData,
          options: Options(
              contentType:  'multipart/form-data; boundary=2000',
              headers: <String, String>{
                "Accept": "application/json"}
          ));
      print(response.data);
      if(response.statusCode==200){
        return response.data['img'];
      }
      return null;

    } catch (e, stack) {
      return null;
    }
  }
}