import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/farm_equipments/data/models/equipments_model.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'equipments_state.dart';

class EquipmentsCubit extends Cubit<EquipmentsState> {
  EquipmentsCubit() : super(EquipmentsInitial());

  List<EquipmentsModel> equipmentsList = [];

  Future<void> getAllEquipments(String ownerId, String id) async {
    emit(EquipmentsLoading());

    try {
      print('Fetching equipments for ownerId: $ownerId');
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/$ownerId/Equipment/Owner?id=$id"),
      );

      if (response.statusCode == 200) {
        print("Equipments loaded successfully");
        final jsonData = json.decode(response.body);
        equipmentsList = EquipmentsModel.equipmentsFromSnapShot(jsonData);
        emit(EquipmentsSuccess());
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['errors']}");
        emit(EquipmentsFailure(message: errorData['errors']));
      }
      //  else if (response.statusCode >= 500) {
      //   print("Server Error: Something went wrong on the server");
      //   emit(EquipmentsFailure(message: "Server Error"));
      // } else {
      //   print("Unexpected Error: ${response.statusCode}");
      //   emit(EquipmentsFailure(message: "Unexpected Error"));
      // }
    } catch (e) {
      print("Network Error: $e");
      emit(EquipmentsFailure(message: "Network Error"));
    }
  }

  Future<void> deleteEquipment(String ownerId, int eId) async {
    emit(EquipmentsLoading());

    try {
      final response = await http.delete(
        Uri.parse("$baseUrlApi/api/$ownerId/Equipment/$eId"),
      );

      if (response.statusCode == 200) {
        print("Equipment deleted successfully");
        equipmentsList.removeWhere((equipment) => equipment.id == eId);
        emit(EquipmentsSuccess());
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(EquipmentsFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(EquipmentsFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(EquipmentsFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(EquipmentsFailure(message: "Network Error"));
    }
  }

  Future<void> addEquipment(String ownerId, String name, String description,
      int count, File photoPath) async {
    emit(EquipmentsLoading());

    var request = http.MultipartRequest(
        'POST', Uri.parse("$baseUrlApi/api/$ownerId/Equipment"));

    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['count'] = count.toString();
    request.fields['ownerId'] = ownerId;

    var photoStream = http.ByteStream(Stream.castFrom(photoPath.openRead()));
    var length = await photoPath.length();
    var multipartFile = http.MultipartFile('photoPath', photoStream, length,
        filename: photoPath.path);
    request.files.add(multipartFile);

    var response = await request.send();

    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Equipment added successfully");
      final jsonData = json.decode(responseData);
      if (jsonData != null) {
        equipmentsList.add(EquipmentsModel.fromJson(jsonData));
      }
      emit(EquipmentsSuccess());
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      final errorData = jsonDecode(responseData);
      String errorMessage = errorData['message'] ?? "Unknown error";
      print("Client Error: $errorMessage");
      emit(EquipmentsFailure(message: errorMessage));
    } else if (response.statusCode >= 500) {
      print("Server Error: Something went wrong on the server");
      emit(EquipmentsFailure(message: "Server Error"));
    } else {
      print("Unexpected Error: ${response.statusCode}");
      emit(EquipmentsFailure(message: "Unexpected Error"));
    }
  }

  Future<void> editEquipment(String ownerId, String? name, String? description,
      int? count, File? photoPath, int eId) async {
    print("Editing equipment with ID: $eId");

    var request = http.MultipartRequest(
        'PUT', Uri.parse("$baseUrlApi/api/$ownerId/Equipment"));

    if (name != null) {
      request.fields['name'] = name;
    }
    if (description != null) {
      request.fields['description'] = description;
    }
    if (count != null) {
      request.fields['count'] = count.toString();
    }

    request.fields['ownerId'] = ownerId;
    request.fields['id'] = eId.toString();
    if (photoPath != null) {
      if (photoPath.path.startsWith('http') ||
          photoPath.path.startsWith('https')) {
        File? downloadedImage = await downloadImage(photoPath.path);
        if (downloadedImage != null) {
          var photoStream = http.ByteStream(downloadedImage.openRead());
          var length = await downloadedImage.length();
          var multipartFile = http.MultipartFile(
              'photoPath', photoStream, length,
              filename: downloadedImage.path.split('/').last);
          request.files.add(multipartFile);
        } else {
          print('Failed to download image from URL: ${photoPath.path}');
        }
      } else {
        var photoStream = http.ByteStream(photoPath.openRead());
        var length = await photoPath.length();
        var multipartFile = http.MultipartFile('photoPath', photoStream, length,
            filename: photoPath.path.split('/').last);
        request.files.add(multipartFile);
      }
    }

    var response = await request.send();

    final responseData = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      print("Equipment updated successfully");
      final jsonData = json.decode(responseData);
      int index = equipmentsList.indexWhere((equipment) => equipment.id == eId);
      if (index != -1) {
        equipmentsList[index] = EquipmentsModel.fromJson(jsonData);
      }
      emit(EquipmentsSuccess());
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      final errorData = jsonDecode(responseData);
      String errorMessage = errorData['message'] ?? "Unknown error";
      print("Client Error: $errorMessage");
      emit(EquipmentsFailure(message: errorMessage));
    } else if (response.statusCode >= 500) {
      print("Server Error: Something went wrong on the server");
      emit(EquipmentsFailure(message: "Server Error"));
    } else {
      print("Unexpected Error: ${response.statusCode}");
      emit(EquipmentsFailure(message: "Unexpected Error"));
    }
  }

  Future<EquipmentsModel> getEquipment(String ownerId, int id) async {
    try {
      print('Fetching equipment for ownerId: $ownerId and equipmentId: $id');
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/$ownerId/Equipment/$id"),
      );

      if (response.statusCode == 200) {
        print("Equipment loaded successfully");
        final jsonData = json.decode(response.body);

        final equipment = EquipmentsModel.fromJson(jsonData);

        return equipment;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(EquipmentsFailure(message: errorData['message']));
        throw ("Eroor");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(EquipmentsFailure(message: "Server Error"));
        throw ("Eroor");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(EquipmentsFailure(message: "Unexpected Error"));
        throw ("Eroor");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(EquipmentsFailure(message: "Network Error"));
      throw ("Eroor");
    }
  }

  Future<File?> downloadImage(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var file = File(
            '${Directory.systemTemp.path}/${DateTime.now().millisecondsSinceEpoch}.png');

        await file.writeAsBytes(response.bodyBytes);

        return file;
      } else {
        print('Failed to download image: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  Future<String> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final accessToken = prefs.getString('accessToken');
      // final refreshToken = prefs.getString('refreshToken');

      List<String> parts = accessToken!.split('.');

      String encodedPayload = parts[1];

      String decodedPayload = utf8.decode(base64Url.decode(encodedPayload));

      print(decodedPayload);
      return decodedPayload;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

// final List<EquipmentsModel> equipmentsList = [
//   const EquipmentsModel(
//     image: Assets.imagesEqui1,
//     name: "Optical Dissolved Oxygen Meter",
//     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//     count: 4,
//   ),
//   const EquipmentsModel(
//     image: Assets.imagesEqui2,
//     name: "Dissolved Oxygen Meter",
//     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//     count: 5,
//   ),
//   const EquipmentsModel(
//     image: Assets.imagesEqui1,
//     name: "Optical Dissolved Oxygen Meter",
//     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//     count: 8,
//   ),
//   const EquipmentsModel(
//     image: Assets.imagesEqui2,
//     name: "Dissolved Oxygen Meter",
//     description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
//     count: 0,
//   ),
// ];
}
