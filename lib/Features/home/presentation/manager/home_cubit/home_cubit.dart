import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final List<FishModel> fishList = [
    FishModel(
      image: Assets.imagesAeromoniasis,
      title: "Aeromoniasis",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
    FishModel(
      image: Assets.imagesBacterialRedDisease,
      title: "Bacterial Reddisease",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
    FishModel(
      image: Assets.imagesAeromoniasis,
      title: "Aeromoniasis",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
    FishModel(
      image: Assets.imagesBacterialRedDisease,
      title: "Bacterial Reddisease",
      description:
          "The genus Aeromonas comprises some of the most important fish bacterial pathogens that affect aquaculture worldwide. Several species other than A. salmonicida, the causative agent of furunculosis in salmonids have been responsible for severe losses both in freshwater and marine aquaculture. Aeromonads have a big repertoire of virulence factors that contribute to their pathogenicity. In this chapter, we review the recent developments in the study of those virulence factors, and we describe the pathologies caused in fish focusing on the Mediterranean aquaculture.",
    ),
  ];
}
