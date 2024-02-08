import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/our_team/presentation/manager/our_team_cubit/our_team_cubit.dart';
import 'package:graduation_project/Features/our_team/presentation/views/widgets/our_team_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class OurTeamView extends StatefulWidget {
  const OurTeamView({super.key});

  @override
  State<OurTeamView> createState() => _OurTeamViewState();
}

class _OurTeamViewState extends State<OurTeamView> {
  GlobalKey<ScaffoldState> ourTeamKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: ourTeamKey,
        drawer: const CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: CustomAppBar(
            anotherKey: ourTeamKey,
          ),
        ),
        body: BlocProvider(
          create: (context) => OurTeamCubit(),
          child: const OurTeamViewBody(),
        ),
      ),
    );
  }
}
