import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/add_form_users.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/users_body.dart';

class UsersScreen extends StatelessWidget {
  static const String routerName = "/dashboard/users";

  const UsersScreen({Key? key}) : super(key: key);

  addNewUser(BuildContext context) {
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
      appBar: CustumAppBar(title: local.users, context: context),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => addNewUser(context),
      ),
      body: const UsersBody(),
    );
  }
}
