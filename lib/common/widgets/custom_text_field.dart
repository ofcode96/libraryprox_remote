// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final String? initailValue;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final bool? obscureText;
  final bool? mostEmpty;
  final TextStyle? style;

  const CustomTextField(
      {Key? key,
      this.controller,
      this.hintText,
      this.onChanged,
      this.initailValue,
      this.keyboardType,
      this.onTap,
      this.inputFormatters,
      this.readOnly,
      this.obscureText,
      this.mostEmpty,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: style,
      obscureText: obscureText != null ? true : false,
      readOnly: readOnly != null ? true : false,
      onTap: onTap,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      initialValue: initailValue,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
      ),
      validator: (value) {
        if (mostEmpty != null) {
          return null;
        } else {
          if (value!.isEmpty) {
            return "Enter Your $hintText";
          }
          return null;
        }
      },
    );
  }
}
