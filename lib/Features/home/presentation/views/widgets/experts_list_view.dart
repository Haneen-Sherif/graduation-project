import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ExpertsListView extends StatelessWidget {
  const ExpertsListView({
    super.key,
    required this.expertsList,
  });

  final List<ExpertsModel> expertsList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(
        width: 8,
      ),
      scrollDirection: Axis.horizontal,
      itemCount: expertsList.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          context.push(
            AppRoutes.kExpertsProfileView,
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
                  offset: const Offset(4, 4),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 0,
              child: Column(
                children: [
                  Image.asset(
                    expertsList[index].image,
                    height: 96,
                    width: 79,
                    fit: BoxFit.fill,
                  ),
                  SizedBox(
                    height: 23,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Dr. ",
                          style: Styles.textStyle7.copyWith(
                            letterSpacing: 0.96,
                          ),
                        ),
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          expertsList[index].name,
                          style: Styles.textStyle7.copyWith(
                            letterSpacing: 0.96,
                          ),
                        ),
                      ],
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
