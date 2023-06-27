import 'package:flutter/material.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/add_form_student.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/students_body.dart';

import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_drawer.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudentsScreen extends StatelessWidget {
  static const String routerName = "/dashboard/students";

  const StudentsScreen({Key? key}) : super(key: key);

  addNewStudent(BuildContext context) {
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
      appBar: CustumAppBar(title: local.students, context: context),
      drawer: const CustomDrawer(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => addNewStudent(context),
      ),
      body: const StudentsBody(),
    );
  }
}
