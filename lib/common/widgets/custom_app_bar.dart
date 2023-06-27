// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/language_popup.dart';
import 'package:libraryprox_remote/common/widgets/logout_button.dart';
import 'package:libraryprox_remote/common/widgets/theme_button.dart';

AppBar CustumAppBar(
    {required String title,
    Color? color,
    required BuildContext context,
    bool? returnBtn}) {
  return AppBar(
    title: SizedBox(
      width: MediaQuery.of(context).size.width * .7,
      child: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        softWrap: true,
      ),
    ),
    leading: returnBtn == null ? null : const BackButton(),
    actions: const [
      ThemeButton(),
      LanguagePopup(),
      LogoutButton(),
    ],
  );
}
