import 'package:flutter/material.dart';

import 'spacer.dart';
import 'themed_button.dart';
import 'themed_text.dart';

class ThemedError extends StatelessWidget {
  const ThemedError({
    Key? key,
    required this.errorText,
    required this.onClick,
  }) : super(key: key);

  final String errorText;
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ThemedText(
            text: errorText,
          ),
          const VSpacer(15),
          ThemedButton(
            const ThemedText(
              text: 'Retry',
              fontColor: Colors.white,
            ),
            backgroundColor: const Color.fromRGBO(126, 140, 247, 1),
            onClick: onClick,
          )
        ],
      ),
    );
  }
}
