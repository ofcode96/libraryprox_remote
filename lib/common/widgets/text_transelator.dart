// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Texttranselator extends StatelessWidget {
  const Texttranselator({
    Key? key,
    required this.text,
    this.textStyle,
  }) : super(key: key);
  final String text;
  final TextStyle? textStyle;

  String wichTitle(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    switch (text) {
      case "Book":
        return local.addnew(local.book);
      case "Student":
        return local.addnew(local.student);
      case "Borrow":
        return local.addnew(local.borrow);
      case "User":
        return local.addnew(local.users);
      default:
        return text;
    }
  }

  convertText(BuildContext context) {
    return wichTitle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      wichTitle(context),
      style: textStyle,
    );
  }
}
