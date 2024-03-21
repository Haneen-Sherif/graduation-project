// import 'package:flutter/material.dart';
// import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
// import 'package:graduation_project/core/utils/styles.dart';

// class ExpertsGridViewItem extends StatelessWidget {
//   const ExpertsGridViewItem({
//     super.key,
//     required this.expertsList,
//     required this.index,
//   });

//   final List<ExpertsModel> expertsList;
//   final int index;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Image.asset(expertsList[index].image),
//         Container(
//           width: double.infinity,
//           height: 21,
//           decoration: ShapeDecoration(
//             color: const Color(0x635460C7),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8),
//             child: Text(
//               "Dr. ${expertsList[index].name}",
//               style: Styles.textStyle15.copyWith(
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }
