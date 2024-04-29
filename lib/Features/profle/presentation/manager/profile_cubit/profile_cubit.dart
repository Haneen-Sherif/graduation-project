import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/profle/data/models/farm_owner_model.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  Future<void> updatePersonalPhoto(String id, File? photoPath) async {
    emit(ProfileLoading());

    try {
      var request = http.MultipartRequest(
          'PUT', Uri.parse('$baseUrlApi/api/Accounts/updatePersonalPhoto/$id'));

      if (photoPath != null) {
        var photoStream = http.ByteStream(photoPath.openRead());
        var length = await photoPath.length();
        var multipartFile = http.MultipartFile('photoPath', photoStream, length,
            filename: photoPath.path.split('/').last);
        request.files.add(multipartFile);
      }

      var response = await request.send();
      final responseData = await response.stream.bytesToString();

      if (response.statusCode == 202) {
        print('Photo updated successfully');
        emit(UpdateSuccess(message: 'Photo updated successfully'));
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(responseData);
        print('Client Error: ${errorData['message']}');
        emit(ProfileFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print('Server Error: Something went wrong on the server');
        emit(ProfileFailure(message: 'Server Error'));
      } else {
        print('Unexpected Error: ${response.statusCode}');
        emit(ProfileFailure(message: 'Unexpected Error'));
      }
    } catch (e) {
      print('Network Error: $e');
      emit(ProfileFailure(message: 'Network Error'));
    }
  }

  Future<void> updateUserPassword(
    String id,
    String? oldPassword,
    String? newPassword,
    String? confirmPass,
  ) async {
    emit(ProfileLoading());
    try {
      final Map<String, dynamic> requestBody = {
        'id': id,
        'oldPassword': oldPassword,
        'newPassword': newPassword,
        'confirmPass': confirmPass,
      };
      final response = await http.put(
        Uri.parse("$baseUrlApi/api/Accounts/UpdateUserPassword"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 202) {
        print("password updated successfully");

        emit(UpdateSuccess(message: "Password updated successfully"));
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print(errorData);
        emit(ProfileFailure(message: errorData['PasswordMismatch'][0]));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(ProfileFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(ProfileFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ProfileFailure(message: "Network Error"));
    }
  }

  Future<void> updateFarmOwner(
      String id,
      String? birthDate,
      String? email,
      String? userName,
      String? phoneNumber,
      String? farmAddress,
      String? address) async {
    emit(ProfileLoading());
    try {
      final Map<String, dynamic> requestBody = {
        'id': id,
        'birthDate': birthDate,
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'farmAddress': farmAddress,
        'address': address,
      };
      final response = await http.put(
        Uri.parse("$baseUrlApi/api/Accounts/farmOwner"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 202) {
        print("farm owner updated successfully");

        emit(UpdateSuccess(message: response.body));
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print(errorData);
        emit(ProfileFailure(message: errorData['InvalidEmail'][0]));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(ProfileFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(ProfileFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ProfileFailure(message: "Network Error"));
    }
  }

  Future<void> updateExpert(
      String id,
      String? birthDate,
      String? email,
      String? userName,
      String? phoneNumber,
      String? moreInfo,
      String? address) async {
    emit(ProfileLoading());
    try {
      final Map<String, dynamic> requestBody = {
        'id': id,
        'birthDate': birthDate,
        'email': email,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'moreInfo': moreInfo,
        'address': address,
      };
      final response = await http.put(
        Uri.parse("$baseUrlApi/api/Accounts/doctor"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 202) {
        print("farm owner updated successfully");

        emit(UpdateSuccess(message: response.body));
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print(errorData);
        emit(ProfileFailure(message: errorData['InvalidEmail'][0]));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(ProfileFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(ProfileFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ProfileFailure(message: "Network Error"));
    }
  }

  Future<FarmOwnerModel> getFarmOwner(String ownerId) async {
    try {
      print('Fetching ownerId: $ownerId');
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/farmOwner?id=$ownerId"),
      );

      if (response.statusCode == 200) {
        print("Farm owner get successfully");
        final jsonData = json.decode(response.body);

        final farmOwner = FarmOwnerModel.fromJson(jsonData);

        return farmOwner;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(ProfileFailure(message: errorData['message']));
        throw ("Eroor");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(ProfileFailure(message: "Server Error"));
        throw ("Eroor");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(ProfileFailure(message: "Unexpected Error"));
        throw ("Eroor");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ProfileFailure(message: "Network Error"));
      throw ("Eroor");
    }
  }

  Future<ExpertsModel> getExpert(String id) async {
    emit(ProfileLoading());

    try {
      print('Fetching expert for Id: $id');
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/doctor/$id"),
      );

      if (response.statusCode == 200) {
        print("Expert loaded successfully");
        final jsonData = json.decode(response.body);

        final expert = ExpertsModel.fromJson(jsonData);
        emit(ProfileSuccess());
        return expert;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(ProfileFailure(message: errorData['message']));
        throw ("Eroor");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(ProfileFailure(message: "Server Error"));
        throw ("Eroor");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(ProfileFailure(message: "Unexpected Error"));
        throw ("Eroor");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ProfileFailure(message: "Network Error"));
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

  @override
  void onChange(Change<ProfileState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
