import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String menuLocalization(BuildContext context, String text) {
  AppLocalizations? local = AppLocalizations.of(context)!;

  switch (text) {
    case "Home":
      return local.home;
    case "Books":
      return local.books;
    case "Students":
      return local.students;
    case "Borrows":
      return local.borrows;
    case "Logs":
      return local.logs;
    case "Users":
      return local.users;
    case "About":
      return local.about;
    default:
      return text;
  }
}
