import 'package:flutter/material.dart';

class ThemedTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? iconData;
  final void Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final String initialValue;
  const ThemedTextFormField({
    Key? key,
    this.hintText = '',
    this.iconData,
    this.onChanged,
    this.obscureText = false,
    this.validator,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      onChanged: onChanged,
      cursorColor: const Color.fromARGB(255, 113, 113, 113),
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: iconData,
        enabledBorder: _customOutlineInputBorder(),
        focusedBorder: _customOutlineInputBorder(),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
              color: const Color.fromARGB(255, 113, 113, 113),
              fontSize: 14.0,
              letterSpacing: 1,
            ),
        errorBorder: _customOutlineInputBorder(color: Colors.white),
        focusedErrorBorder: _customOutlineInputBorder(color: Colors.white),
      ),
    );
  }

  OutlineInputBorder _customOutlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? const Color.fromARGB(255, 255, 255, 255),
        width: 2,
      ),
      borderRadius: BorderRadius.circular(20.0),
    );
  }
}
