import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/experts_view_body.dart';

class ExpertsView extends StatelessWidget {
  const ExpertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ExpertsCubit(),
        child: ExpertsViewBody(),
      ),
    );
  }
}
