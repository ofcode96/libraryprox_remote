// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewText extends StatelessWidget {
  const AddNewText({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  String wichTitle(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    switch (title) {
      case "Book":
        return local.addnew(local.book);
      case "Student":
        return local.addnew(local.student);
      case "Borrow":
        return local.addnew(local.borrow);
      case "User":
        return local.addnew(local.users);
      default:
        return title;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(wichTitle(context));
  }
}
