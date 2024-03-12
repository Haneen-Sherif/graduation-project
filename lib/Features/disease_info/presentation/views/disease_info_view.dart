import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/disease_info_view_body.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class DiseaseInfoView extends StatefulWidget {
  const DiseaseInfoView({super.key, required this.index});

  final int index;

  @override
  State<DiseaseInfoView> createState() => _DiseaseInfoViewState();
}

class _DiseaseInfoViewState extends State<DiseaseInfoView> {
  GlobalKey<ScaffoldState> infoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: SafeArea(
        child: Scaffold(
          key: infoKey,
          drawer: const CustomDrawer(),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: CustomAppBar(
              anotherKey: infoKey,
            ),
          ),
          body: DiseaseInfoViewBody(id: widget.index),
        ),
      ),
    );
  }
}
