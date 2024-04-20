import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/experts_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/feedback_container.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/fish_list_view.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_stack_widget.dart';
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
            child: Column(
              children: [
                Text("Fish Diseases",
                    textAlign: TextAlign.center,
                    style: Styles.textStyle24(context)
                        .copyWith(color: Color(0xff1D2B4F))),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  style: Styles.textStyle12(context)
                      .copyWith(color: Color(0xff636E88)),
                )
              ],
            ),
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
                    color: kPrimaryColor,
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
              height: 18,
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Text(
                  "Specialists",
                  textAlign: TextAlign.center,
                  style: Styles.textStyle24(context)
                      .copyWith(color: Color(0xff1D2B4F)),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
                  style: Styles.textStyle12(context)
                      .copyWith(color: Color(0xff636E88)),
                )
              ],
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
                    color: kPrimaryColor,
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
          SliverToBoxAdapter(
            child: Text(
              "About Us",
              textAlign: TextAlign.center,
              style: Styles.textStyle24(context)
                  .copyWith(color: Color(0xff1D2B4F)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27),
              child: FeedbackContainer(),
            ),
          ),
          // SliverFillRemaining(
          //   hasScrollBody: false,
          //   child: ReportWidget(size: size),
          // ),
          // const SliverToBoxAdapter(
          //   child: SizedBox(
          //     height: 12,
          //   ),
          // ),
          // SliverToBoxAdapter(
          //   child: HomeFooterWidget(size: size),
          // )
        ],
      ),
    );
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              surfaceTintColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Exit App',
              ),
              content: const Text(
                'Do you want to close the app?',
              ),
              // backgroundColor: kPrimaryColor,
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
        style: const TextStyle(color: kPrimaryColor),
      ),
    );
  }
}
