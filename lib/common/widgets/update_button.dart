import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';

class UpdateButton extends StatelessWidget {
  final void Function()? onPressed;
  const UpdateButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          transelator(context, "Update"),
        ),
      ),
    );
  }
}
