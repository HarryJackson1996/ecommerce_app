import 'package:flutter/material.dart';

class ThemedButton extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final VoidCallback? onClick;
  final double? height;
  final double? width;

  const ThemedButton(
    this.child, {
    Key? key,
    required this.onClick,
    this.backgroundColor = Colors.black,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        key: key,
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
            Theme.of(context).textTheme.button,
          ),
          elevation: MaterialStateProperty.all(2.0),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0)),
          shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30.0)))),
        ),
        onPressed: onClick,
        child: child,
      ),
    );
  }
}
