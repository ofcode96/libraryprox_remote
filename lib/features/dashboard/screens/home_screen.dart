// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:libraryprox_remote/common/widgets/linechart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/widgets/cards_dashborad.dart';
import '../../../common/widgets/custom_app_bar.dart';
import '../../../common/widgets/custom_drawer.dart';
import '../../../common/widgets/heading_title.dart';

class HomeScreen extends StatefulWidget {
  static const String routerName = "/dashboard/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustumAppBar(title: local.dashboard, context: context),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const CardsDashboard(),
                const SizedBox(
                  height: 5,
                ),
                HeadingTitle(
                  title: local.borrowOpr,
                ),
                const SizedBox(
                  height: 10,
                ),
                const LineChartWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
