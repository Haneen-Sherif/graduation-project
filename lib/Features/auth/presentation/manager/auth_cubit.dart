import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(
    String name,
    String email,
    String phone,
    String password,
    String confirmPass,
    String address,
  ) async {
    emit(AuthLoading());

    try {
      final response = await http.post(
        Uri.parse("$baseUrlApi/api/Accounts/farmOwner"),
        body: {
          'email': email,
          'userName': name,
          'password': password,
          'confirmPass': confirmPass,
          'phoneNumber': phone,
          'farmAddress': address,
        },
      );

      String errorMessage = '';

      if (response.statusCode == 201) {
        print("Success: User registered successfully");

        emit(AuthSuccess(message: "Registered successfully"));
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);

        if (errorData['DuplicateEmail'] != null &&
            errorData['DuplicateUserName'] != null) {
          errorMessage =
              "${errorData['DuplicateEmail'].join(', ')} or ${errorData['DuplicateUserName'].join(', ')}";
        } else if (errorData['DuplicateEmail'] != null) {
          errorMessage = errorData['DuplicateEmail'].join(', ');
        } else if (errorData['DuplicateUserName'] != null) {
          errorMessage = errorData['DuplicateUserName'].join(', ');
        }
        print(errorMessage);

        emit(AuthFailure(message: errorMessage));
        // } else if (response.statusCode >= 500) {
        //   print("Server Error: Something went wrong on the server");
        //   emit(AuthFailure(message: "Server Error"));
        // } else {
        //   print("Unexpected Error: ${response.statusCode}");
        //   emit(AuthFailure(message: "Unexpected Error"));
        //
      }
    } catch (e) {
      print("Network Error: $e");
      emit(AuthFailure(message: "Network Error"));
    }
  }

  Future<void> resetPassword(
    String email,
    String code,
    String pass,
    String confirmPass,
  ) async {
    emit(AuthLoading());

    try {
      final Map<String, String> requestBody = {
        "email": email,
        "code": code,
        "pass": pass,
        "confirmPass": confirmPass
      };
      final response = await http.post(
        Uri.parse("$baseUrlApi/api/Accounts/reset-password"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Success: Password reset email sent successfully.");
        emit(AuthSuccess(message: "Email sent successfully"));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(AuthFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(AuthFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(AuthFailure(message: "Network Error"));
    }
  }

  Future<void> forgot(
    String email,
  ) async {
    emit(AuthLoading());

    try {
      final Map<String, String> requestBody = {
        'email': email,
      };
      final response = await http.post(
        Uri.parse("$baseUrlApi/api/Accounts/forgot"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Success: Password reset email sent successfully.");
        emit(AuthSuccess(message: "Email sent successfully"));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(AuthFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(AuthFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(AuthFailure(message: "Network Error"));
    }
  }

  Future<void> signIn(String name, String password) async {
    emit(AuthLoading());
    try {
      http.Response response = await http.post(
        Uri.parse("$baseUrlApi/api/Accounts/login"),
        body: {
          'username': name,
          'password': password,
        },
      );
      print(response.body);

      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final accessToken = result['accessToken'];
        final refreshToken = result['refreshToken'];

        // print(accessToken);
        // print(refreshToken);
        prefs.setString('accessToken', accessToken);
        prefs.setString('refreshToken', refreshToken);
        prefs.setString('username', name);
        try {
          await _firestore
              .collection('users')
              .doc(name)
              .set({'name': name, 'status': 'Online'});
        } catch (e) {
          print(e);
        }
        emit(LoginSuccess());
      } else if (response.statusCode == 401) {
        emit(AuthFailure(message: 'Incorrect username or password'));
      } else {
        emit(AuthFailure(message: 'Incorrect username or password'));
      }
    } catch (e) {
      emit(AuthFailure(message: 'Incorrect username or password'));
    }
  }

  Future<void> expertSignUp(
    String userName,
    String email,
    String phoneNumber,
    String password,
    String confirmPass,
    String address,
    String birthDate,
    File personalPhoto,
    String moreInfo,
  ) async {
    emit(AuthLoading());

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("$baseUrlApi/api/Accounts/doctor"));

      request.fields['email'] = email;
      request.fields['userName'] = userName;
      request.fields['password'] = password;
      request.fields['confirmPass'] = confirmPass;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['address'] = address;
      request.fields['birthDate'] = birthDate;
      request.fields['moreInfo'] = moreInfo;

      // if (personalPhoto.path.startsWith('http') ||
      //     personalPhoto.path.startsWith('https')) {
      //   File? downloadedImage = await downloadImage(personalPhoto.path);
      //   if (downloadedImage != null) {
      //     var photoStream = http.ByteStream(downloadedImage.openRead());
      //     var length = await downloadedImage.length();
      //     var multipartFile = http.MultipartFile(
      //         'personalPhoto', photoStream, length,
      //         filename: downloadedImage.path.split('/').last);
      //     request.files.add(multipartFile);
      //   } else {
      //     print('Failed to download image from URL: ${personalPhoto.path}');
      //   }
      // } else {
      //   var photoStream = http.ByteStream(personalPhoto.openRead());
      //   var length = await personalPhoto.length();
      //   var multipartFile = http.MultipartFile('photoPath', photoStream, length,
      //       filename: personalPhoto.path.split('/').last);
      //   request.files.add(multipartFile);
      // }

      var photoStream =
          http.ByteStream(Stream.castFrom(personalPhoto.openRead()));
      var length = await personalPhoto.length();
      var multipartFile = http.MultipartFile(
          'personalPhoto', photoStream, length,
          filename: personalPhoto.path);
      request.files.add(multipartFile);

      var response = await request.send();

      final responseData = await response.stream.bytesToString();
      // final response = await http.post(
      //   Uri.parse("$baseUrlApi/api/Accounts/doctor"),
      //   body: {
      //     'email': email,
      //     'userName': name,
      //     'password': password,
      //     'confirmPass': confirmPass,
      //     'phoneNumber': phone,
      //     'address': address,
      //     'birthDate': birthDate,
      //     'personalPhoto': personalPhoto,
      //     'moreInfo': moreInfo
      //   },
      // );

      String errorMessage = '';
      print(response.statusCode);

      if (response.statusCode == 201) {
        print("Success: User registered successfully");
        emit(AuthSuccess(message: "Registered successfully"));
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(responseData);

        if (errorData['DuplicateEmail'] != null &&
            errorData['DuplicateUserName'] != null) {
          errorMessage =
              "${errorData['DuplicateEmail'].join(', ')} or ${errorData['DuplicateUserName'].join(', ')}";
        } else if (errorData['DuplicateEmail'] != null) {
          errorMessage = errorData['DuplicateEmail'].join(', ');
        } else if (errorData['DuplicateUserName'] != null) {
          errorMessage = errorData['DuplicateUserName'].join(', ');
        }
        print(errorMessage);

        emit(AuthFailure(message: errorMessage));
        // } else if (response.statusCode >= 500) {
        //   print("Server Error: Something went wrong on the server");
        //   emit(AuthFailure(message: "Server Error"));
        // } else {
        //   print("Unexpected Error: ${response.statusCode}");
        //   emit(AuthFailure(message: "Unexpected Error"));
        //
      } else if (response.statusCode == 500) {
        final errorData = jsonDecode(responseData);

        // if (errorData['message'] != null &&
        //     errorData['DuplicateUserName'] != null) {
        //   errorMessage =
        //       "${errorData['DuplicateEmail'].join(', ')} or ${errorData['DuplicateUserName'].join(', ')}";
        // } else if (errorData['DuplicateEmail'] != null) {
        //   errorMessage = errorData['DuplicateEmail'].join(', ');
        // } else if (errorData['DuplicateUserName'] != null) {
        //   errorMessage = errorData['DuplicateUserName'].join(', ');
        // }
        print(errorData['message']);

        emit(AuthFailure(message: errorData['message']));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(AuthFailure(message: "Network Error"));
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
}