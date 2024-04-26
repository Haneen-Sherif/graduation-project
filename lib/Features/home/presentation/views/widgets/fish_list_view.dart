import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class FishListView extends StatelessWidget {
  const FishListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomeLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      } else if (state is HomeSuccess) {
        List<DiseasesModel> diseases =
            BlocProvider.of<HomeCubit>(context).diseases;

        // print("=====================");
        // print(diseases);
        // print("=====================");
        return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: diseases.length,
            itemBuilder: (context, index) {
              DiseasesModel disease = diseases[index];
              return GestureDetector(
                onTap: () {
                  context.push(
                    AppRoutes.kDiseaseInfoView,
                    extra: disease.id,
                  );
                },
                child: SizedBox(
                  width: 74,
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding:
                        const EdgeInsets.only(bottom: 2, right: 1, left: 1),
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
                          Image.network(
                            disease.photoPath ?? '',
                            height: 67,
                            width: 74,
                            fit: BoxFit.cover,
                          ),
                          // Image.network((disease.photoPath!),
                          //     height: 67, width: 74, fit: BoxFit.fill),
                          SizedBox(
                            width: 140,
                            child: Text(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              disease.name!,
                              textAlign: TextAlign.center,
                              style: Styles.textStyle7(context).copyWith(
                                letterSpacing: 0.96,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      } else if (state is HomeFailure) {
        return Center(
          child: Text('Failed to load diseases: ${state.message}'),
        );
      } else {
        final diseases = BlocProvider.of<HomeCubit>(context).getAllDisease();

        print("=====================");
        print(diseases);
        print("=====================");
        final diseases2 = BlocProvider.of<HomeCubit>(context).diseases;

        print("=====================");
        print(diseases2);
        print("=====================");
        return Container();
      }
    });
  }
}
