import 'package:flutter/material.dart';

enum ThemeTextType { body, body2, h1, h2, h3, button }

class ThemedText extends StatelessWidget {
  final String text;
  final ThemeTextType themeTextType;
  final double? fontSize;
  final Color? fontColor;
  final int? maxLines;
  final TextOverflow? textOverflow;

  const ThemedText({
    this.text = '',
    this.themeTextType = ThemeTextType.body,
    this.fontSize,
    this.fontColor = Colors.black,
    this.maxLines,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: _getTextStyle(themeTextType, context)?.copyWith(
        fontSize: fontSize,
        color: fontColor,
        overflow: textOverflow,
      ),
    );
  }

  TextStyle? _getTextStyle(ThemeTextType themeTextType, BuildContext context) {
    switch (themeTextType) {
      case ThemeTextType.body:
        return Theme.of(context).textTheme.bodyText1;
      case ThemeTextType.body2:
        return Theme.of(context).textTheme.bodyText2;
      case ThemeTextType.h1:
        return Theme.of(context).textTheme.headline1;
      case ThemeTextType.h2:
        return Theme.of(context).textTheme.headline2;
      case ThemeTextType.h3:
        return Theme.of(context).textTheme.headline3;
      case ThemeTextType.button:
        return Theme.of(context).textTheme.button;
      default:
        return Theme.of(context).textTheme.bodyText1;
    }
  }
}
