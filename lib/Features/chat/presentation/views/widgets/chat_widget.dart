import 'package:flutter/material.dart';

import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:intl/intl.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    this.timestamp,
    this.type,
    this.imageMessage,
  });

  final String msg;
  final int chatIndex;
  final DateTime? timestamp;

  final String? type;
  final String? imageMessage;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final formattedTime = DateFormat.jm().format(timestamp!);

    return type == 'text'
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              crossAxisAlignment: chatIndex == 0
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: chatIndex == 0
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    crossAxisAlignment: chatIndex == 0
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: chatIndex == 0
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          decoration: ShapeDecoration(
                            color: chatIndex == 0
                                ? kPrimaryColor.withOpacity(0.46)
                                : Color(0xFFEBE9E9),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                          ),
                          child: Text(
                            msg.trim(),
                            style: const TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formattedTime,
                        style: Styles.textStyle12(context)
                            .copyWith(fontFamily: "Open Sans"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: chatIndex == 0
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: chatIndex == 0
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height / 2.5,
                  width: size.width,
                  alignment: chatIndex == 0
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    height: size.height / 2.5,
                    width: size.width / 2,
                    alignment: Alignment.center,
                    child: imageMessage != ""
                        ? Image.network(imageMessage!)
                        : CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                  ),
                ),
                // const SizedBox(height: 8),
                Text(
                  formattedTime,
                  style: Styles.textStyle12(context)
                      .copyWith(fontFamily: "Open Sans"),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
  }
}
