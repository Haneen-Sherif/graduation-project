import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/experts_profile_view_body.dart';

class ExpertsProfileView extends StatelessWidget {
  const ExpertsProfileView({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ExpertsCubit(),
        child: ExpertsProfileViewBody(index: index),
      ),
    );
  }
}
