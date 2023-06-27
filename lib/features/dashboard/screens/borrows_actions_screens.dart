// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/capitalize.dart';
import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/awesome_floating_action_button.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';
import 'package:libraryprox_remote/common/widgets/list_detail_action.dart';
import 'package:libraryprox_remote/features/dashboard/screens/borrow_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/borrows_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';

import 'package:libraryprox_remote/models/borrow_model.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/logs_model.dart';
import '../../../models/user_model.dart';
import '../widgets/update_form_borrow.dart';

class BorrowsActionsScreen extends StatefulWidget {
  static const String routerName = "/dashboard/borrows/borrow";

  final Borrow? borrow;
  final bool? isDark;
  const BorrowsActionsScreen({Key? key, this.borrow, this.isDark})
      : super(key: key);

  @override
  State<BorrowsActionsScreen> createState() => _BorrowsActionsScreenState();
}

class _BorrowsActionsScreenState extends State<BorrowsActionsScreen> {
  BorrowsServices borrowsServices = BorrowsServices();
  LogsServices logsServices = LogsServices();

  String _key = "";
  dynamic _value = "";

  // Generate Data From Book
  validation(String key, dynamic value) {
    if (key == "start_date") {
      value = TimeConverter.convertToRealTime(value.toString());
    }
    if (key == "end_date") {
      value = TimeConverter.convertToRealTime(value.toString());
    }
    if (key == "is_aviable") {
      value = value ? "Yes" : "No";
    }
    key = key.capitalize().replaceAll("_", " ");

    value ??= "No";

    if (key == "Start date") {
      key = "Start Date";
    }
    if (key == "End date") {
      key = "End Date";
    }
    if (key == "Book id") {
      key = "Book ID";
    }
    if (key == "Student id") {
      key = "Student ID";
    }
    if (key == "Owner id") {
      key = "User Id";
    }
    if (key == "State") {
      key = "State Borrow";
      value = value == 0
          ? transelator(context, "Runing")
          : value == 1
              ? transelator(context, "Stoped")
              : transelator(context, "Missed");
    }

    key = transelator(context, key);
    setState(() {
      _key = key;
      _value = value;
    });
  }

  // Delete Book
  deleteBook() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    await borrowsServices.removeBorrow(widget.borrow!.id, context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(BorrowScreen.routerName, (route) => false);

    logsServices.log(
        Logs(
            opration: "Delete Borrow ${widget.borrow!.id}",
            user: user.username),
        context);

    setState(() {});
  }

  // Update Book Form
  updateBook() {
    showDialog(
      context: context,
      builder: (context) {
        return FormUpdate(borrow: widget.borrow);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustumAppBar(
          title: widget.borrow == null ? "" : widget.borrow!.id.toString(),
          context: context,
          returnBtn: true),
      drawer: const CustomDrawer(),
      floatingActionButton: AwesomeFloatingActionBar(
        onTapDelete: deleteBook,
        onTapEdit: updateBook,
        borrowState: false,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
                children: widget.borrow!.toMap().entries.map((e) {
              // validation
              validation(e.key, e.value);

              return ListDetailAction(keyList: _key, valueList: _value);
            }).toList()),
          ),
        ),
      ),
    );
  }
}
