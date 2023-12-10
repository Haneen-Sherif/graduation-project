import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/core/utils/styles.dart';

class FishInfoListView extends StatelessWidget {
  const FishInfoListView({
    super.key,
    required this.size,
    required this.fishList,
  });

  final Size size;
  final List<FishModel> fishList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
        child: GestureDetector(
          onTap: () {},
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
                      style: Styles.textStyle16.copyWith(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.96,
                      ),
                    ),
                    Text(
                      fishList[index].description,
                      style: Styles.textStyle12.copyWith(
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
                child: Image.asset(fishList[index].image),
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
