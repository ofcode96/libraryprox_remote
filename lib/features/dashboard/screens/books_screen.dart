import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/books_body.dart';

import '../widgets/add_form_book.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BooksScreen extends StatelessWidget {
  static const String routerName = "/dashboard/books";

  const BooksScreen({Key? key}) : super(key: key);

  addNewBook(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const FormAdd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustumAppBar(title: local.book, context: context),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => addNewBook(context),
      ),
      body: const BooksBody(),
    );
  }
}
