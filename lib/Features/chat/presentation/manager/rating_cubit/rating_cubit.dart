import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  int rateCount = 0;
  String isSubscriped = "false";

  Future<void> subscribe(String id) async {
    // emit(HomeLoading());

    try {
      final response = await http.put(
        Uri.parse("$baseUrlApi/api/Accounts/farmOwner/subscribe?id=/$id"),
      );

      if (response.statusCode == 200) {
        print("this farm owner now marked as Subscripted user account");
        final jsonData = json.decode(response.body);

        print(jsonData);

        emit(RatingSuccess(message: jsonData));
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(RatingFailure(message: errorData['message']));
        throw Exception("Failed to load disease");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(RatingFailure(message: "Server Error"));
        throw Exception("Failed to load disease");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(RatingFailure(message: "Unexpected Error"));
        throw Exception("Failed to load disease");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(RatingFailure(message: "Network Error"));
      throw Exception("Network Error: $e");
    }
  }

  Future<void> isSubscripted(String id) async {
    // emit(HomeLoading());

    try {
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/farmOwner/IsSubscripted?id=/$id"),
      );

      if (response.statusCode == 200) {
        print("Success");
        final jsonData = json.decode(response.body);
        print(jsonData);
        isSubscriped = jsonData;

        emit(RatingSuccess(message: jsonData));
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(RatingFailure(message: errorData['message']));
        throw Exception("Failed to load disease");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(RatingFailure(message: "Server Error"));
        throw Exception("Failed to load disease");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(RatingFailure(message: "Unexpected Error"));
        throw Exception("Failed to load disease");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(RatingFailure(message: "Network Error"));
      throw Exception("Network Error: $e");
    }
  }

  Future<int> calcRating(String id) async {
    try {
      print('Fetching expert for Id: $id');
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/doctor/CalcRating/$id"),
      );

      if (response.statusCode == 200) {
        print("Success Rate Count");
        final jsonData = json.decode(response.body);
        print(jsonData);
        rateCount = jsonData;
        emit(RatingCalcSuccess(rateCount: rateCount));

        return rateCount;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(RatingFailure(message: errorData['message']));
        throw ("Eroor");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(RatingFailure(message: "Server Error"));
        throw ("Eroor");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(RatingFailure(message: "Unexpected Error"));
        throw ("Eroor");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(RatingFailure(message: "Network Error"));
      throw ("Eroor");
    }
  }

  Future<void> setRating(double rate, String ownerId, String doctorId) async {
    try {
      final Map<String, dynamic> requestBody = {
        'rate': rate,
        'ownerId': ownerId,
        'doctorId': doctorId,
      };
      final response = await http.post(
        Uri.parse("$baseUrlApi/api/Accounts/farmOwner/setDoctorRating"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print("rating is set to that doctor thanks..");
        // final jsonData = json.decode(response.body);

        emit(RatingSuccess(message: response.body));
      } else if (response.statusCode == 404) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(RatingFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(RatingFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(RatingFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(RatingFailure(message: "Network Error"));
    }
  }
}
