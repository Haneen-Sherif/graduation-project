import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/custom_fish_info_row.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/disease_info_order.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class DiseaseInfoViewBody extends StatelessWidget {
  const DiseaseInfoViewBody({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    // print("diseaseInfo: ============= $diseaseInfo");
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
              child: FutureBuilder<DiseasesModel>(
                future: homeCubit.getDisease(id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else {
                    final disease = snapshot.data!;
                    return Column(
                      children: [
                        const CustomTitle(title: " Fish Diseases"),
                        const SizedBox(
                          height: 26,
                        ),
                        Image.file(File(disease.photoPath!)),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomFishInfoRow(
                          title: disease.name!,
                          subTitle: disease.description!,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DiseaseInfoOrder(number: "1"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomFishInfoRow(
                                title: "Causative Agents:",
                                subTitle: disease.description!,
                                // diseaseInfoList: diseaseInfoList,
                                // index: index,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DiseaseInfoOrder(number: "2"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomFishInfoRow(
                                title: "Transmission:",
                                subTitle: disease.description!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DiseaseInfoOrder(number: "3"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomFishInfoRow(
                                title: "Clinical Signs:",
                                subTitle: disease.description!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DiseaseInfoOrder(number: "4"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomFishInfoRow(
                                title: "Diagnosis:",
                                subTitle: disease.description!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DiseaseInfoOrder(number: "5"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomFishInfoRow(
                                title: "Treatment:",
                                subTitle: disease.description!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DiseaseInfoOrder(number: "6"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomFishInfoRow(
                                title: "Prevention and Control:",
                                subTitle: disease.description!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DiseaseInfoOrder(number: "7"),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: CustomFishInfoRow(
                                title: "Impact on Aquaculture:",
                                subTitle: disease.description!,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
            HomeFooterWidget(size: size)
          ],
        ),
      ),
    );
  }
}
