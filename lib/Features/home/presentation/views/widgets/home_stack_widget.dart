import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/detect_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class HomeStackWidget extends StatelessWidget {
  const HomeStackWidget({
    Key? key,
    required this.size,
    required this.scaffoldKey,
    required this.farmOwnerId,
  }) : super(key: key);

  final Size size;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String farmOwnerId;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.7,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(Assets.imagesFishBG),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              ListTile(
                leading: IconButton(
                  onPressed: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                title: Image.asset(
                  Assets.imagesLogo_1,
                  height: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      'Early detection, lifelong wellness.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle30(context).copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    AutoSizeText(
                      'Dive into our Fish Disease App.',
                      maxLines: 2,
                      style: Styles.textStyle18(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(child: SizedBox()),
              FittedBox(
                child: DetectButton(
                  space: 16,
                  myWidget: Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff349caa),
                              borderRadius: BorderRadius.circular(26)),
                          height: 26,
                          width: 26,
                          child: Image.asset(Assets.iconsRight),
                        ),
                      ],
                    ),
                  ),
                  color: Color(0xff087ca8),
                  text: "Detect",
                  onPressed: () async {
                    await BlocProvider.of<RatingCubit>(context)
                        .isSubscripted(farmOwnerId);

                    bool response = await BlocProvider.of<RatingCubit>(context)
                        .isUserSubscriped;
                    if (response == true) {
                      context.push(AppRoutes.kDetectView, extra: farmOwnerId);
                    } else if (response == false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You have to be subscribed"),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 55,
              )
            ],
          ),
        ),
      ),
    );
  }
}
