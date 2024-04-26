import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class FishInfoListView extends StatelessWidget {
  const FishInfoListView({
    super.key,
    required this.fishList,
  });

  final List<FishModel> fishList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GestureDetector(
          onTap: () {
            context.push(
              AppRoutes.kDiseaseInfoView,
              extra: index,
            );
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      overflow: TextOverflow.ellipsis,
                      fishList[index].title,
                      textAlign: TextAlign.center,
                      style: Styles.textStyle16(context).copyWith(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.96,
                      ),
                    ),
                    Text(
                      fishList[index].description,
                      style: Styles.textStyle12(context).copyWith(
                        letterSpacing: 0.72,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 13,
              ),
              Flexible(
                child: Image.network(fishList[index].image),
              )
            ],
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 4),
      itemCount: fishList.length,
    );
  }
}
