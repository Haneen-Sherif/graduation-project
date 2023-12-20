import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

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
