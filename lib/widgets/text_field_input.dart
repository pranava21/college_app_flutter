import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final String validatorText;
  final String labelText;
  final TextInputType textInputType;
  const TextFieldInput(
      {Key? key,
      required this.textEditingController,
      required this.hintText,
      this.isPass = false,
      required this.textInputType,
      required this.validatorText,
      required this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const inputBorder =
        OutlineInputBorder();
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          labelText: labelText,
          contentPadding: const EdgeInsets.all(8)),
      keyboardType: textInputType,
      obscureText: isPass,
      validator: (value) {
        if (value!.isEmpty) {
          return validatorText;
        }
      },
    );
  }
}
