import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/fish_info_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/fish_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_stack_widget.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/report_widget.dart';
import 'package:graduation_project/constants.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FishModel> fishList =
        BlocProvider.of<HomeCubit>(context).fishList;
    Size size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (bool didPop) async {
        await _showExitConfirmationDialog(context);
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeStackWidget(size: size),
            const SizedBox(
              height: 42,
            ),
            SizedBox(
              height: 200,
              child: FishListView(fishList: fishList),
            ),
            FishInfoListView(
              size: size,
              fishList: fishList,
            ),
            const SizedBox(
              height: 12,
            ),
            ReportWidget(size: size),
            const SizedBox(
              height: 12,
            ),
            HomeFooterWidget(size: size)
          ],
        ),
      ),
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Exit App',
                style: TextStyle(color: kSecondaryColor),
              ),
              content: const Text(
                'Do you want to close the app?',
                style: TextStyle(color: kSecondaryColor),
              ),
              backgroundColor: kPrimaryColor,
              actions: <Widget>[
                _buildDialogButton(context, 'No', false),
                _buildDialogButton(context, 'Yes', true),
              ],
            );
          },
        ) ??
        false;
  }

  Widget _buildDialogButton(BuildContext context, String text, bool value) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(value),
      child: Text(
        text,
        style: const TextStyle(color: kSecondaryColor),
      ),
    );
  }
}
