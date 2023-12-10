import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
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
        width: 25,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: fishList.length,
      itemBuilder: (context, index) => Column(
        children: [
          Image.asset(fishList[index].image),
          SizedBox(
            width: 140,
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              fishList[index].title,
              textAlign: TextAlign.center,
              style: Styles.textStyle16.copyWith(
                fontWeight: FontWeight.w500,
                letterSpacing: 0.96,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
