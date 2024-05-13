import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  int rateCount = 0;
  bool isUserSubscriped = false;

  Future<void> subscribe(String id) async {
    emit(SubscribeLoading());

    try {
      final response = await http.put(
        Uri.parse("$baseUrlApi/api/Accounts/subscribe?id=$id"),
      );

      if (response.statusCode == 200) {
        print("this farm owner now marked as Subscripted user account");
        final jsonData = json.decode(response.body);

        print(jsonData);
        isUserSubscriped = true;
        emit(SubscribeSuccess(message: jsonData));
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(SubscribeFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(SubscribeFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(SubscribeFailure(message: "Unexpected Error"));
        throw Exception("Failed to load disease");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(SubscribeFailure(message: "Network Error"));
    }
  }

  Future<void> isSubscripted(String id) async {
    emit(IsSubscribedLoading());

    try {
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/IsSubscripted?id=$id"),
      );

      if (response.statusCode == 200) {
        // print("IsSubscripted Success");
        final jsonData = json.decode(response.body);
        // print(jsonData);
        isUserSubscriped = jsonData;
        if (isUserSubscriped == true) {
          emit(IsSubscibedSuccess());
        } else {
          emit(IsNotSubscibedSuccess());
        }
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(IsSubscribedFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(IsSubscribedFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(IsSubscribedFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(IsSubscribedFailure(message: "Network Error"));
    }
  }

  Future<int> calcRating(String id) async {
    emit(RatingCalcLoading());
    try {
      print('Fetching expert for Id: $id');
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/doctor/CalcRating/$id"),
      );

      if (response.statusCode == 200) {
        print("Success Rate Count");
        final jsonData = json.decode(response.body);
        print(jsonData.runtimeType);
        rateCount = jsonData;
        emit(RatingCalcSuccess());

        return rateCount;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(RatingCalcFailure(message: errorData['message']));
        throw ("Eroor");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(RatingCalcFailure(message: "Server Error"));
        throw ("Eroor");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(RatingCalcFailure(message: "Unexpected Error"));
        throw ("Eroor");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(RatingCalcFailure(message: "Network Error"));
      throw ("Eroor");
    }
  }

  Future<void> setRating(double rate, String ownerId, String doctorId) async {
    emit(RatingSetLoading());
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

        emit(RatingSetSuccess(message: response.body));
      } else if (response.statusCode == 404) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(RatingSetFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(RatingSetFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(RatingSetFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(RatingSetFailure(message: "Network Error"));
    }
  }

  @override
  void onChange(Change<RatingState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
