import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/constants.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'experts_state.dart';

class ExpertsCubit extends Cubit<ExpertsState> {
  ExpertsCubit() : super(ExpertsInitial());
  List<ExpertsModel> experts = [];

  Future<void> getAllExperts() async {
    emit(ExpertsLoading());

    try {
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/doctor"),
      );

      if (response.statusCode == 200) {
        print("Experts loaded successfully");
        final jsonData = json.decode(response.body);
        experts = ExpertsModel.expertsFromSnapShot(jsonData);
        experts.forEach((expert) {
          print("Expert: ${expert.userName}, ${expert.email}");
        });
        print("%%%%%%%%%%%%%%$experts");
        emit(ExpertsSuccess());
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(ExpertsFailure(message: errorData['message']));
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(ExpertsFailure(message: "Server Error"));
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(ExpertsFailure(message: "Unexpected Error"));
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ExpertsFailure(message: "Network Error"));
    }
  }

  Future<ExpertsModel> getExpert(String id) async {
    emit(ExpertsLoading());

    try {
      print('Fetching expert for Id: $id');
      final response = await http.get(
        Uri.parse("$baseUrlApi/api/Accounts/doctor/$id"),
      );

      if (response.statusCode == 200) {
        print("Expert loaded successfully");
        final jsonData = json.decode(response.body);

        final expert = ExpertsModel.fromJson(jsonData);
        emit(ExpertsSuccess());
        return expert;
      } else if (response.statusCode >= 400 && response.statusCode < 500) {
        final errorData = jsonDecode(response.body);
        print("Client Error: ${errorData['message']}");
        emit(ExpertsFailure(message: errorData['message']));
        throw ("Eroor");
      } else if (response.statusCode >= 500) {
        print("Server Error: Something went wrong on the server");
        emit(ExpertsFailure(message: "Server Error"));
        throw ("Eroor");
      } else {
        print("Unexpected Error: ${response.statusCode}");
        emit(ExpertsFailure(message: "Unexpected Error"));
        throw ("Eroor");
      }
    } catch (e) {
      print("Network Error: $e");
      emit(ExpertsFailure(message: "Network Error"));
      throw ("Eroor");
    }
  }

  @override
  void onChange(Change<ExpertsState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
