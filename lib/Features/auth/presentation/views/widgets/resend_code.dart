import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ReSendCode extends StatelessWidget {
  const ReSendCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Send code again',
          style: Styles.textStyle16.copyWith(
            color: Colors.black.withOpacity(0.699999988079071),
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          '00:20',
          style: Styles.textStyle16.copyWith(
            color: Colors.black.withOpacity(0.699999988079071),
            fontFamily: 'Inter',
          ),
        )
      ],
    );
  }
}
