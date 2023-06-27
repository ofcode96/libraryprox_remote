import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/add_form_borrow.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/borrows_body.dart';
import 'package:libraryprox_remote/provider/borrow_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BorrowScreen extends StatelessWidget {
  static const String routerName = "/dashboard/borrow";

  const BorrowScreen({Key? key}) : super(key: key);

  addNewBorrow(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const FormAdd();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BorrowIds borrowIds = Provider.of<BorrowProvider>(context).borrowIds;
    bool hasBorrow = borrowIds.bookId == 0 || borrowIds.studentId == 0;
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustumAppBar(title: local.borrows, context: context),
      drawer: const CustomDrawer(),
      floatingActionButton: hasBorrow
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => addNewBorrow(context),
            ),
      body: const BorrowsBody(),
    );
  }
}
