import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/constants.dart';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<DiseasesModel> diseases = [];
  Future<void> addFeedback(String email, String name, String message) async {
    try {
      final Map<String, String> requestBody = {
        'name': name,
        'email': email,
        'message': message,
      };
      final response = await http.post(
        Uri.parse("$baseUrlApi/api/Feedbacks"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("Success: Feedback sent successfully.");
        emit(HomeMessageSuccess(message: "Feedback sent successfully"));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(HomeFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(HomeFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(HomeFailure(message: "Network Error"));
    }
  }

  Future<DiseasesModel> getDisease(int id) async {
    emit(HomeLoading());

    try {
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Disease/$id"),
      );

      if (response.statusCode == 200) {
        print("Disease loaded successfully");
        final jsonData = json.decode(response.body);
        final disease = DiseasesModel.fromJson(jsonData);
        print(disease);

        emit(HomeSuccess());
        return disease;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(HomeFailure(message: errorData['message']));
        throw Exception("Failed to load disease");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(HomeFailure(message: "Server Error"));
        throw Exception("Failed to load disease");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(HomeFailure(message: "Unexpected Error"));
        throw Exception("Failed to load disease");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(HomeFailure(message: "Network Error"));
      throw Exception("Network Error: $e");
    }
  }

  Future<void> getAllDisease() async {
    emit(HomeLoading());

    try {
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Disease"),
      );

      if (response.statusCode == 200) {
        print("Disease loaded successfully");
        final jsonData = json.decode(response.body);
        diseases = DiseasesModel.diseasesFromSnapShot(jsonData);
        print("%%%%%%%%%%%%%%$diseases");
        emit(HomeSuccess());
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(HomeFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(HomeFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(HomeFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(HomeFailure(message: "Network Error"));
    }
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
}
