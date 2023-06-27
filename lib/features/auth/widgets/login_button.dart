// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String text;
  final Function()? onPressed;

  const LoginButton({
    Key? key,
    required this.height,
    required this.width,
    required this.color,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
        backgroundColor: color,
      ),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
