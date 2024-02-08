import 'package:bloc/bloc.dart';
import 'package:graduation_project/Features/our_team/data/models/our_team_model.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:meta/meta.dart';

part 'our_team_state.dart';

class OurTeamCubit extends Cubit<OurTeamState> {
  OurTeamCubit() : super(OurTeamInitial());

  final List<OurTeamModel> ourTeamList = [
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
    OurTeamModel(
      image: Assets.imagesTeamMember1,
      name: "Calvin Cooper",
      description: "Randall Warren",
    ),
  ];
}
