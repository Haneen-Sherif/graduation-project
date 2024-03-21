import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/experts_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/fish_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_stack_widget.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/report_widget.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    // final List<FishModel> fishList =
    //     BlocProvider.of<HomeCubit>(context).fishList;
    // final List<ExpertsModel> expertsList =
    //     BlocProvider.of<HomeCubit>(context).expertsList;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: HomeStackWidget(size: size, scaffoldKey: scaffoldKey),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 18,
            ),
          ),
          SliverToBoxAdapter(
            child: Text("Fish Diseases",
                textAlign: TextAlign.center, style: Styles.textStyle27),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 74,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 94,
              width: 74,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 79,
                    color: const Color(0xff8488CD),
                  ),
                  Positioned(
                    top: -40,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 94,
                      child: FishListView(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 24,
            ),
          ),
          SliverToBoxAdapter(
            child: Text(
              "Experts",
              textAlign: TextAlign.center,
              style: Styles.textStyle27,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 95,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 120,
              width: 79,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 79,
                    color: const Color(0xff8488CD),
                  ),
                  Positioned(
                    top: -70,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: 122,
                      child: ExpertsListView(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: ReportWidget(size: size),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 12,
            ),
          ),
          SliverToBoxAdapter(
            child: HomeFooterWidget(size: size),
          )
        ],
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
