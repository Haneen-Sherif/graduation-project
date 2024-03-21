import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomExpertsInfoBody extends StatelessWidget {
  const CustomExpertsInfoBody({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final expertsCubit = BlocProvider.of<ExpertsCubit>(context);
    return FutureBuilder<ExpertsModel>(
      future: expertsCubit.getExpert(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final expert = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
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
                          // expertsList: expertsList,
                          id: id,
                          title: 'Name : ',
                          subTitle: expert.userName!,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        // CustomExpertsInfo(
                        //   // expertsList: expertsList,
                        //   id: widget.id,
                        //   title: 'Age : ',
                        //   subTitle: expert.age.toString(),
                        // ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomExpertsInfo(
                          id: id,
                          title: 'From : ',
                          subTitle: expert.address!,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomExpertsInfo(
                          id: id,
                          title: 'mobile : ',
                          subTitle: expert.phoneNumber!,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomExpertsInfo(
                          id: id,
                          title: 'Email : ',
                          subTitle: expert.email!,
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
                    child: Image.network(expert.personalPhoto!),
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
                  expert.moreInfo!,
                  style: Styles.textStyle15,
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
