import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';

import '../widgets/logs_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogsScreen extends StatelessWidget {
  static const String routerName = "/dashboard/logs";

  const LogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustumAppBar(title: local.logs, context: context),
      drawer: const CustomDrawer(),
      body: const LogsBody(),
    );
  }
}
