import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class FishListView extends StatelessWidget {
  const FishListView({
    super.key,
    required this.fishList,
  });

  final List<FishModel> fishList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        width: 8,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: fishList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          context.push(
            AppRoutes.kDiseaseInfoView,
            extra: index,
          );
        },
        child: SizedBox(
          width: 74,
          child: Container(
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.only(bottom: 2, right: 1, left: 1),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              child: Column(
                children: [
                  Image.asset(fishList[index].image,
                      height: 67, width: 74, fit: BoxFit.fill),
                  SizedBox(
                    width: 140,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      fishList[index].title,
                      textAlign: TextAlign.center,
                      style: Styles.textStyle7.copyWith(
                        letterSpacing: 0.96,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
