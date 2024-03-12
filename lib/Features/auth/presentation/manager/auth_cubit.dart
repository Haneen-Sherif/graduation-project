import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
        emit(LoginSuccess());
      } else if (response.statusCode == 401) {
        emit(AuthFailure(message: 'Incorrect username or password'));
      }
    } catch (e) {
      emit(AuthFailure(message: 'Incorrect username or password'));
    }
  }
}
