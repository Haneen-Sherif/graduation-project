import 'package:flutter/material.dart';
import 'package:graduation_project/Features/our_team/data/models/our_team_model.dart';
import 'package:graduation_project/core/utils/styles.dart';

class OurTeamItem extends StatelessWidget {
  const OurTeamItem({
    super.key,
    required this.index,
    required this.ourTeamList,
  });

  final int index;
  final List<OurTeamModel> ourTeamList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(ourTeamList[index].image),
        const SizedBox(
          height: 16,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            ourTeamList[index].name,
            style: Styles.textStyle20(context).copyWith(
              fontWeight: FontWeight.w700,
              fontFamily: "Montserrat",
              color: const Color(0xff585EC7),
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            ourTeamList[index].description,
            style: Styles.textStyle12(context).copyWith(
              color: const Color(0xff737373),
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }
}
