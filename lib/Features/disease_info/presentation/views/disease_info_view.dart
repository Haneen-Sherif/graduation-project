import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/disease_info_view_body.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';

class DiseaseInfoView extends StatelessWidget {
  const DiseaseInfoView({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Padding(
              padding: const EdgeInsets.only(top: 16, left: 21),
              child: CustomForgotPasswordBackIcon(),
            ),
          ),
          body: DiseaseInfoViewBody(id: index),
        ),
      ),
    );
  }
}
