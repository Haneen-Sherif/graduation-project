import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:intl/intl.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
    required this.timestamp,
  });

  final String msg;
  final int chatIndex;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final formattedTime = DateFormat.jm().format(timestamp);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment:
            chatIndex == 0 ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.6,
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
                  width: 241,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: SizedBox(
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                child: AnimatedTextKit(
                                  isRepeatingAnimation: false,
                                  repeatForever: false,
                                  displayFullTextOnTap: true,
                                  totalRepeatCount: 1,
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      msg.trim(),
                                      textStyle:
                                          Styles.textStyle12(context).copyWith(
                                        color: const Color(0xff1E1E1E),
                                        fontFamily: "Open Sans",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
    );
  }
}
