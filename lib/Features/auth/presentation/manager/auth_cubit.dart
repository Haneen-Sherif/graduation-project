import 'dart:convert';
import 'dart:developer';
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
  String? role;

  Future<String> getRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');

    if (accessToken == null) {
      throw Exception('Access token not found in SharedPreferences');
    }

    List<String> parts = accessToken.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid access token format');
    }

    String payload = parts[1];
    String normalizedPayload = base64Url.normalize(payload);
    String decodedPayload = utf8.decode(base64Url.decode(normalizedPayload));

    Map<String, dynamic> payloadMap = json.decode(decodedPayload);

    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload format');
    }

    if (!payloadMap.containsKey(
        'http://schemas.microsoft.com/ws/2008/06/identity/claims/role')) {
      throw Exception('Role claim not found in payload');
    }

    role = payloadMap[
        'http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
    print('User role: $role');
    return role!;
  }

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
        emit(ChangedSuccess());
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
        emit(AuthSuccess(message: "Code sent successfully"));
      } else if (response.statusCode == 400) {
        print("Server Error: Something went wrong on the server");
        emit(AuthFailure(message: "Incorrect email address"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(AuthFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(AuthFailure(message: "Network Error"));
    }
  }

  Future<void> deleteAccount(
    String id,
  ) async {
    emit(AuthLoading());

    try {
      final requestBody = [id];
      final response = await http.delete(
        Uri.parse("$baseUrlApi/api/Accounts"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 204) {
        print("Success: Account deleted successfully.");
        emit(AuthSuccess(message: "Account deleted successfully"));
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

  Future<void> isCodeEnterTrue(
    String email,
    String code,
  ) async {
    emit(VerificationLoading());

    try {
      final Map<String, String> requestBody = {
        'email': email,
        'code': code,
      };
      final response = await http.post(
        Uri.parse("$baseUrlApi/api/Accounts/IsCodeEnterTrue"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Success");
        if (response.body == 'true') {
          emit(VerificationSuccess());
        } else {
          emit(VerificationFailure(message: "Please enter the correct code"));
        }
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(VerificationFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(VerificationFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(VerificationFailure(message: "Network Error"));
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
        String myRole = await getRole();
        if (myRole == "FarmOwner") {
          prefs.setString('role', "FarmOwner");
        } else {
          prefs.setString('role', "Doctor");
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

      var photoStream =
          http.ByteStream(Stream.castFrom(personalPhoto.openRead()));
      var length = await personalPhoto.length();
      var multipartFile = http.MultipartFile(
          'personalPhoto', photoStream, length,
          filename: personalPhoto.path);
      request.files.add(multipartFile);

      var response = await request.send();

      final responseData = await response.stream.bytesToString();

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
      } else if (response.statusCode == 500) {
        final errorData = jsonDecode(responseData);

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

  @override
  void onChange(Change<AuthState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
