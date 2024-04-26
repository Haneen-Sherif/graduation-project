import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/our_team/presentation/manager/our_team_cubit/our_team_cubit.dart';
import 'package:graduation_project/Features/our_team/presentation/views/widgets/our_team_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

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
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Our Team"),
          centerTitle: true,
        ),
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(70),
        //   child: Padding(
        //       padding: EdgeInsets.only(top: 16, left: 21),
        //       child: CustomForgotPasswordBackIcon()),
        //   // child: CustomAppBar(
        //   //   anotherKey: farmKey,
        //   // )
        // ),
        body: BlocProvider(
          create: (context) => OurTeamCubit(),
          child: const OurTeamViewBody(),
        ),
      ),
    );
  }
}
