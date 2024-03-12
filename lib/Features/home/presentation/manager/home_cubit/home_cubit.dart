import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  List<DiseasesModel> diseases = [];
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
  final List<ExpertsModel> expertsList = [
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD1,
      name: "John",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD4,
      name: "Smith",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD5,
      name: "Sam",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD6,
      name: "David",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD7,
      name: "John",
    ),
    ExpertsModel(
      age: 40,
      from: "California",
      mobile: "+12027953213",
      email: "john926@gmail.com",
      professionalInformation:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus. Sed vel justo hendrerit, aliquam justo et, facilisis lacus. Curabitur at justo vitae felis feugiat fringilla. Vivamus tempus tincidunt ex, non hendrerit lacus mattis ac. Sed euismod, eros in posuere facilisis, ex velit efficitur quam, vitae ullamcorper dolor mi in nisl. Quisque vel neque orci. Vivamus id pharetra libero, nec elementum sapien. Curabitur sed euismod ligula.",
      image: Assets.imagesD8,
      name: "John",
    ),
  ];
  final List<FishModel> fishList = [
    FishModel(
      impactOnAquaculture:
          "Aeromoniasis can have significant economic impacts on aquaculture by causing mortality, reduced growth rates, and decreased product quality.\nThe disease can spread rapidly in aquaculture facilities, leading to substantial losses if not properly managed.",
      preventionAndControl:
          "Prevention involves maintaining good water quality, avoiding overcrowding, and minimizing stressors.\nQuarantine new fish before introducing them to existing populations.\nVaccination strategies may be employed in aquaculture settings to reduce the risk of Aeromonas infections.",
      treatment:
          "Antibiotics are commonly used to treat Aeromoniasis. Common choices include florfenicol, oxytetracycline, and enrofloxacin.\nTreatment may be administered through medicated feed, bath treatments, or injections, depending on the severity of the infection.",
      diagnosis:
          "Diagnosis is often based on clinical signs, post-mortem examinations, and laboratory tests.\nBacterial cultures from affected tissues, such as skin, kidney, or liver, can confirm the presence of Aeromonas species.",
      clinicalSigns:
          "Clinical signs of Aeromoniasis vary depending on the species of fish, the infecting Aeromonas strain, and environmental factors.\nCommon symptoms include skin lesions, ulcers, fin rot, swollen abdomen, hemorrhages, and lethargy.\nFish may exhibit abnormal swimming behavior and loss of appetite.",
      transmission:
          "Aeromoniasis is highly contagious among fish and can be transmitted through direct contact, contaminated water, or ingestion of infected tissues.\nStressful conditions, poor water quality, and overcrowding can contribute to the spread of the disease.",
      causativeAgents:
          "Aeromonas hydrophila: This species is one of the most common causes of Aeromoniasis in fish, particularly in warm water species.\nAeromonas salmonicida: This bacterium is known to infect salmonids (such as salmon and trout) and is a major concern in aquaculture.",
      image: Assets.imagesAeromoniasis,
      title: "Aeromoniasis",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
    FishModel(
      impactOnAquaculture:
          "Aeromoniasis can have significant economic impacts on aquaculture by causing mortality, reduced growth rates, and decreased product quality.\nThe disease can spread rapidly in aquaculture facilities, leading to substantial losses if not properly managed.",
      preventionAndControl:
          "Prevention involves maintaining good water quality, avoiding overcrowding, and minimizing stressors.\nQuarantine new fish before introducing them to existing populations.\nVaccination strategies may be employed in aquaculture settings to reduce the risk of Aeromonas infections.",
      treatment:
          "Antibiotics are commonly used to treat Aeromoniasis. Common choices include florfenicol, oxytetracycline, and enrofloxacin.\nTreatment may be administered through medicated feed, bath treatments, or injections, depending on the severity of the infection.",
      diagnosis:
          "Diagnosis is often based on clinical signs, post-mortem examinations, and laboratory tests.\nBacterial cultures from affected tissues, such as skin, kidney, or liver, can confirm the presence of Aeromonas species.",
      clinicalSigns:
          "Clinical signs of Aeromoniasis vary depending on the species of fish, the infecting Aeromonas strain, and environmental factors.\nCommon symptoms include skin lesions, ulcers, fin rot, swollen abdomen, hemorrhages, and lethargy.\nFish may exhibit abnormal swimming behavior and loss of appetite.",
      transmission:
          "Aeromoniasis is highly contagious among fish and can be transmitted through direct contact, contaminated water, or ingestion of infected tissues.\nStressful conditions, poor water quality, and overcrowding can contribute to the spread of the disease.",
      causativeAgents:
          "Aeromonas hydrophila: This species is one of the most common causes of Aeromoniasis in fish, particularly in warm water species.\nAeromonas salmonicida: This bacterium is known to infect salmonids (such as salmon and trout) and is a major concern in aquaculture.",
      image: Assets.imagesBacterialRedDisease,
      title: "Bacterial Reddisease",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
    FishModel(
      impactOnAquaculture:
          "Aeromoniasis can have significant economic impacts on aquaculture by causing mortality, reduced growth rates, and decreased product quality.\nThe disease can spread rapidly in aquaculture facilities, leading to substantial losses if not properly managed.",
      preventionAndControl:
          "Prevention involves maintaining good water quality, avoiding overcrowding, and minimizing stressors.\nQuarantine new fish before introducing them to existing populations.\nVaccination strategies may be employed in aquaculture settings to reduce the risk of Aeromonas infections.",
      treatment:
          "Antibiotics are commonly used to treat Aeromoniasis. Common choices include florfenicol, oxytetracycline, and enrofloxacin.\nTreatment may be administered through medicated feed, bath treatments, or injections, depending on the severity of the infection.",
      diagnosis:
          "Diagnosis is often based on clinical signs, post-mortem examinations, and laboratory tests.\nBacterial cultures from affected tissues, such as skin, kidney, or liver, can confirm the presence of Aeromonas species.",
      clinicalSigns:
          "Clinical signs of Aeromoniasis vary depending on the species of fish, the infecting Aeromonas strain, and environmental factors.\nCommon symptoms include skin lesions, ulcers, fin rot, swollen abdomen, hemorrhages, and lethargy.\nFish may exhibit abnormal swimming behavior and loss of appetite.",
      transmission:
          "Aeromoniasis is highly contagious among fish and can be transmitted through direct contact, contaminated water, or ingestion of infected tissues.\nStressful conditions, poor water quality, and overcrowding can contribute to the spread of the disease.",
      causativeAgents:
          "Aeromonas hydrophila: This species is one of the most common causes of Aeromoniasis in fish, particularly in warm water species.\nAeromonas salmonicida: This bacterium is known to infect salmonids (such as salmon and trout) and is a major concern in aquaculture.",
      image: Assets.imagesAeromoniasis,
      title: "Aeromoniasis",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
    FishModel(
      impactOnAquaculture:
          "Aeromoniasis can have significant economic impacts on aquaculture by causing mortality, reduced growth rates, and decreased product quality.\nThe disease can spread rapidly in aquaculture facilities, leading to substantial losses if not properly managed.",
      preventionAndControl:
          "Prevention involves maintaining good water quality, avoiding overcrowding, and minimizing stressors.\nQuarantine new fish before introducing them to existing populations.\nVaccination strategies may be employed in aquaculture settings to reduce the risk of Aeromonas infections.",
      treatment:
          "Antibiotics are commonly used to treat Aeromoniasis. Common choices include florfenicol, oxytetracycline, and enrofloxacin.\nTreatment may be administered through medicated feed, bath treatments, or injections, depending on the severity of the infection.",
      diagnosis:
          "Diagnosis is often based on clinical signs, post-mortem examinations, and laboratory tests.\nBacterial cultures from affected tissues, such as skin, kidney, or liver, can confirm the presence of Aeromonas species.",
      clinicalSigns:
          "Clinical signs of Aeromoniasis vary depending on the species of fish, the infecting Aeromonas strain, and environmental factors.\nCommon symptoms include skin lesions, ulcers, fin rot, swollen abdomen, hemorrhages, and lethargy.\nFish may exhibit abnormal swimming behavior and loss of appetite.",
      transmission:
          "Aeromoniasis is highly contagious among fish and can be transmitted through direct contact, contaminated water, or ingestion of infected tissues.\nStressful conditions, poor water quality, and overcrowding can contribute to the spread of the disease.",
      causativeAgents:
          "Aeromonas hydrophila: This species is one of the most common causes of Aeromoniasis in fish, particularly in warm water species.\nAeromonas salmonicida: This bacterium is known to infect salmonids (such as salmon and trout) and is a major concern in aquaculture.",
      image: Assets.imagesBacterialRedDisease,
      title: "Bacterial Reddisease",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
  ];
}
