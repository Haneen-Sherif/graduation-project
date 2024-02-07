import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/custom_fish_info_row.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class DiseaseInfoViewBody extends StatelessWidget {
  const DiseaseInfoViewBody({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<FishModel> diseaseInfoList =
        BlocProvider.of<HomeCubit>(context).fishList;
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.03,
                vertical: size.height * 0.02,
              ),
              child: Column(
                children: [
                  const CustomTitle(title: " Fish Diseases"),
                  const SizedBox(
                    height: 26,
                  ),
                  Image.asset(diseaseInfoList[index].image),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomFishInfoRow(
                    title: diseaseInfoList[index].title,
                    subTitle: diseaseInfoList[index].description,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomFishInfoRow(
                    title: "Causative Agents:",
                    subTitle: diseaseInfoList[index].causativeAgents,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomFishInfoRow(
                    title: "Transmission:",
                    subTitle: diseaseInfoList[index].transmission,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomFishInfoRow(
                    title: "Clinical Signs:",
                    subTitle: diseaseInfoList[index].clinicalSigns,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomFishInfoRow(
                    title: "Diagnosis:",
                    subTitle: diseaseInfoList[index].diagnosis,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomFishInfoRow(
                    title: "Treatment:",
                    subTitle: diseaseInfoList[index].treatment,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomFishInfoRow(
                    title: "Prevention and Control:",
                    subTitle: diseaseInfoList[index].preventionAndControl,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomFishInfoRow(
                    title: "Impact on Aquaculture:",
                    subTitle: diseaseInfoList[index].impactOnAquaculture,
                    diseaseInfoList: diseaseInfoList,
                    index: index,
                  ),
                ],
              ),
            ),
            HomeFooterWidget(size: size)
          ],
        ),
      ),
    );
  }
}
