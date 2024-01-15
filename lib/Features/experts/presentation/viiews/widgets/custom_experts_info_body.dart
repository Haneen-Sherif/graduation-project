import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomExpertsInfoBody extends StatelessWidget {
  const CustomExpertsInfoBody({
    super.key,
    required this.expertsList,
    required this.index,
  });

  final List<ExpertsModel> expertsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Align(
          alignment: Alignment.center,
          child: CustomTitle(title: "Experts Contacts"),
        ),
        const SizedBox(
          height: 56,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomExpertsInfo(
                    expertsList: expertsList,
                    index: index,
                    title: 'Name : ',
                    subTitle: expertsList[index].name,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomExpertsInfo(
                    expertsList: expertsList,
                    index: index,
                    title: 'Age : ',
                    subTitle: expertsList[index].age.toString(),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomExpertsInfo(
                    expertsList: expertsList,
                    index: index,
                    title: 'From : ',
                    subTitle: expertsList[index].from,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomExpertsInfo(
                    expertsList: expertsList,
                    index: index,
                    title: 'mobile : ',
                    subTitle: expertsList[index].mobile,
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomExpertsInfo(
                    expertsList: expertsList,
                    index: index,
                    title: 'Email : ',
                    subTitle: expertsList[index].email,
                  ),
                  const SizedBox(
                    height: 22,
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 27,
            ),
            Expanded(
              flex: 4,
              child: Image.asset(expertsList[index].image),
            )
          ],
        ),
        Text(
          "Professional information :",
          style: Styles.textStyle15.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 9,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            expertsList[index].professionalInformation,
            style: Styles.textStyle15,
          ),
        ),
      ],
    );
  }
}
