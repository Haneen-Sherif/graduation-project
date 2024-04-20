import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomFarmEquipmentItem extends StatelessWidget {
  const CustomFarmEquipmentItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.delete,
    required this.edit,
    required this.count,
    required this.image,
  });

  final String title;
  final String subTitle;
  final String count;
  final String image;
  final void Function() delete;
  final void Function() edit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(image,
                height: 111, width: 145, fit: BoxFit.cover)),
        Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle10(context).copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.96,
                ),
              ),
              Text(
                subTitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle7(context).copyWith(
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.96,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const ShapeDecoration(
                      color: Colors.black,
                      shape: OvalBorder(
                          side: BorderSide(width: 1, color: Colors.black)),
                    ),
                    child: Center(
                      child: Text(
                        count,
                        style: Styles.textStyle6(context).copyWith(
                          color: Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: edit,
                    child: const Icon(
                      Icons.edit,
                      size: 12,
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: delete,
                    child: const Icon(
                      Icons.delete,
                      size: 12,
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [],
                  // )
                ],
              )
            ],
          ),
        )
      ],
    );

    // return Container(
    //   padding: const EdgeInsets.only(right: 16, left: 6, top: 6, bottom: 6),
    //   decoration: ShapeDecoration(
    //     color: const Color(0xff8488CD),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(14),
    //     ),
    //   ),
    //   child: Row(
    //     children: [
    //       Expanded(
    //         flex: 2,
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Container(
    //               width: 12,
    //               height: 12,
    //               decoration: const ShapeDecoration(
    //                 color: Colors.white,
    //                 shape: OvalBorder(
    //                     side: BorderSide(width: 1, color: Colors.white)),
    //               ),
    //               child: Center(
    //                 child: Text(
    //                   count,
    //                   style: Styles.textStyle6.copyWith(
    //                     letterSpacing: 0.6,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(
    //               width: 2,
    //             ),
    //             Image.network(image),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(
    //         width: 10,
    //       ),
    //       Expanded(
    //         flex: 7,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Text(
    //               title,
    //               maxLines: 2,
    //               overflow: TextOverflow.ellipsis,
    //               style: Styles.textStyle10.copyWith(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w500,
    //                 letterSpacing: 0.96,
    //               ),
    //             ),
    //             Text(
    //               subTitle,
    //               maxLines: 3,
    //               overflow: TextOverflow.ellipsis,
    //               style: Styles.textStyle7.copyWith(
    //                 color: Colors.white,
    //                 fontWeight: FontWeight.w400,
    //                 letterSpacing: 0.96,
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       const SizedBox(
    //         width: 10,
    //       ),
    //       Expanded(
    //         flex: 2,
    //         child: Row(
    //           children: [
    //             GestureDetector(
    //               onTap: edit,
    //               child: const Icon(
    //                 Icons.edit,
    //                 color: Colors.white,
    //                 size: 12,
    //               ),
    //             ),
    //             const SizedBox(
    //               width: 14,
    //             ),
    //             GestureDetector(
    //               onTap: delete,
    //               child: const Icon(
    //                 Icons.delete,
    //                 color: Colors.white,
    //                 size: 12,
    //               ),
    //             ),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
