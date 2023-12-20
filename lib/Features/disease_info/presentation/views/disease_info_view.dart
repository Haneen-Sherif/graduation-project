import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/disease_info_view_body.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';

class DiseaseInfoView extends StatelessWidget {
  const DiseaseInfoView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: Scaffold(
        body: DiseaseInfoViewBody(index: index),
      ),
    );
  }
}
