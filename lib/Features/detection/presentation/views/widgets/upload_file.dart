import 'dart:convert';
import 'dart:io';

import 'package:go_router/go_router.dart';

import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class UploadFile extends StatefulWidget {
  const UploadFile({
    super.key,
    required this.size,
    required this.id,
  });

  final Size size;

  final String id;

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  final picker = ImagePicker();
  File? img;

  var resJson;
  String? diseaseName;
  double? diseasePer;
  String? diseaseType;
  List<dynamic>? recommendationAction;
  // var url = "https://detect-disease-api.onrender.com/detectApi";

  Future pickImage() async {
    XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      img = File(pickedFile!.path);
    });
  }

  upload(String id, File ImageForDetection) async {
    try {
      final request = http.MultipartRequest(
          "POST", Uri.parse("$baseUrlApi/api/$id/Detects"));
      final header = {
        "Content_type":
            "multipart/form-data; boundary=<calculated when request is sent>"
      };
      request.files.add(http.MultipartFile(
          "ImageForDetection", img!.readAsBytes().asStream(), img!.lengthSync(),
          filename: img!.path.split('/').last));
      request.headers.addAll(header);
      final myRequest = await request.send();
      http.Response res = await http.Response.fromStream(myRequest);
      if (myRequest.statusCode == 200) {
        resJson = jsonDecode(res.body);
        diseaseName = resJson['nameOfDisFromAIModel'];
        diseasePer = resJson["score"];
        diseaseType = resJson["disease"]["type"];
        recommendationAction = resJson["disease"]["recommandationActions"];
        print("response here: $resJson");
        print(diseaseName);
        print(diseasePer);
        print(diseaseType);
        print(recommendationAction);
        print(img!.path.split('/').last);
        context.push(
          AppRoutes.kShowResultView,
          extra: {
            'name': diseaseName,
            'per': diseasePer.toString(),
            'img': img!.path,
            'type': diseaseType,
            'action': recommendationAction
          },
        );
      } else {
        print("error: ${myRequest.statusCode}");
      }
      // var request = http.MultipartRequest(
      //     'POST', Uri.parse("$baseUrlApi/api/$id/Detects"));
      // // final response = await http.post(
      // //   Uri.parse("$baseUrlApi/api/$id/Detects"),
      // //      body: {
      // //     'ImageForDetection': ImageForDetection,

      // //   },
      // // );

      // var photoStream =
      //     http.ByteStream(Stream.castFrom(ImageForDetection.openRead()));
      // var length = await ImageForDetection.length();
      // var multipartFile = http.MultipartFile(
      //     'ImageForDetection', photoStream, length,
      //     filename: ImageForDetection.path);
      // request.files.add(multipartFile);

      // var response = await request.send();

      // final responseData = await response.stream.bytesToString();

      // if (response.statusCode == 200) {
      //   diseaseName = resJson['Detection'];
      //   diseasePer = resJson["Value"];
      //   print("response here: $resJson");
      //   print(diseaseName);
      //   print(diseasePer);
      //   print("Disease loaded successfully");
      //   resJson = json.decode(responseData);
      //   diseaseName = resJson['Detection'];
      //   diseasePer = resJson["Value"];
      //   print("response here: $resJson");
      //   print(diseaseName);
      //   print(diseasePer);
      // final detect = DetectResultModel.detectFromSnapShot(jsonData);
      // print(detect);

      // return detect;
      // context.push(
      //   AppRoutes.kShowResultView,
      //   extra: {
      //     'name': diseaseName,
      //     'per': diseasePer.toString(),
      //     'img': img!.path
      //   },
      // );
      // } else if (response.statusCode >= 400 && response.statusCode < 500) {
      //   final errorData = jsonDecode(responseData);
      //   print("Client Error: ${errorData['message']}");

      //   throw Exception("Failed to load disease");
      // } else if (response.statusCode >= 500) {
      //   print("Server Error: Something went wrong on the server");

      //   throw Exception("Failed to load disease");
      // } else {
      //   print("Unexpected Error: ${response.statusCode}");

      //   throw Exception("Failed to load disease");
      // }
    } catch (e) {
      print("Network Error: $e");

      throw Exception("Network Error: $e");
    }
    // final request = http.MultipartRequest("POST", Uri.parse(url));
    // final header = {
    //   "Content_type":
    //       "multipart/form-data; boundary=<calculated when request is sent>"
    // };
    // request.files.add(http.MultipartFile(
    //     "image", img!.readAsBytes().asStream(), img!.lengthSync(),
    //     filename: img!.path.split('/').last));
    // request.headers.addAll(header);
    // final myRequest = await request.send();
    // http.Response res = await http.Response.fromStream(myRequest);
    // if (myRequest.statusCode == 200) {
    //   resJson = jsonDecode(res.body);
    //   diseaseName = resJson['Detection'];
    //   diseasePer = resJson["Value"];
    //   print("response here: $resJson");
    //   print(diseaseName);
    //   print(diseasePer);
    //   print(img!.path.split('/').last);
    //   context.push(
    //     AppRoutes.kShowResultView,
    //     extra: {
    //       'name': diseaseName,
    //       'per': diseasePer.toString(),
    //       'img': img!.path
    //     },
    //   );
    // } else {
    //   print("error: ${myRequest.statusCode}");
    // }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 38),
          padding: const EdgeInsets.all(38),
          decoration: BoxDecoration(
            // color: const Color(0xFFE5E5E5),
            border: const DashedBorder.fromBorderSide(
              dashLength: 8,
              side: BorderSide(color: Color(0xFF57ACB5), width: 3),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              img == null ? Image.asset(Assets.imagesUpload) : Image.file(img!),
              const SizedBox(
                height: 61,
              ),
              CustomButton(
                width: widget.size.width * 0.6,
                text: "Import Image",
                onPressed: () {
                  pickImage();
                },
              )
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        img == null
            ? SizedBox()
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 38),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: kPrimaryColor.withOpacity(0.16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(img!.path.split('/').last)),
                    ),
                    // Image.asset(Assets.imagesGallery),
                    // Expanded(
                    //   child: Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 16),
                    //     height: 1,
                    //     decoration: BoxDecoration(
                    //       color: const Color(0xff5A5D95),
                    //       borderRadius: BorderRadius.circular(3),
                    //     ),
                    //   ),
                    // ),
                    Image.asset(Assets.imagesCheckmark)
                  ],
                ),
              ),
        const SizedBox(
          height: 56,
        ),
        CustomButton(
          color: img == null ? Color(0xff59595E) : kPrimaryColor,
          width: size.width * 0.6,
          text: "Show Result",
          onPressed: () {
            // img == null ? null : context.push(AppRoutes.kShowResultView);
            img == null ? null : upload(widget.id, img!);
            ;
          },
        ),
      ],
    );
  }
}
