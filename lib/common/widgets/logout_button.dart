import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/shared_prefrences.dart';
import 'package:libraryprox_remote/features/auth/screens/auth_srceen.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AuthScreen.routerName,
          (route) => false,
        );
        await SharedPrefrencesServices.clear();
      },
      icon: const Icon(Icons.login_outlined),
    );
  }
}
