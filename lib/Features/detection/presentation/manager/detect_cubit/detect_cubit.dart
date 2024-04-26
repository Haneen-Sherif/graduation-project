import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/detection/data/models/disease_result_model.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';

import 'package:http/http.dart' as http;

part 'detect_state.dart';

class DetectCubit extends Cubit<DetectState> {
  DetectCubit() : super(DetectInitial());

  Future<List<DetectResultModel>> detectDisease(
    String id,
    File ImageForDetection,
  ) async {
    emit(DetectLoading());

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$baseUrlApi/api/$id/Detects"));

      var photoStream =
          http.ByteStream(Stream.castFrom(ImageForDetection.openRead()));
      var length = await ImageForDetection.length();
      var multipartFile = http.MultipartFile(
          'ImageForDetection', photoStream, length,
          filename: ImageForDetection.path);
      request.files.add(multipartFile);

      var response = await request.send();

      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        print("Disease loaded successfully");
        final jsonData = json.decode(responseData);
        final detect = DetectResultModel.detectFromSnapShot(jsonData);
        print(detect);

        emit(DetectSuccess());
        return detect;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(responseData);
        print("Client Error: ${errorData['message']}");
        emit(DetectFailure(message: errorData['message']));
        throw Exception("Failed to load disease");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(DetectFailure(message: "Server Error"));
        throw Exception("Failed to load disease");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(DetectFailure(message: "Unexpected Error"));
        throw Exception("Failed to load disease");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(DetectFailure(message: "Network Error"));
      throw Exception("Network Error: $e");
    }
  }
}
