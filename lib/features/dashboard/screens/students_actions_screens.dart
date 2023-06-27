// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/capitalize.dart';
import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/awesome_floating_action_button.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';
import 'package:libraryprox_remote/common/widgets/list_detail_action.dart';
import 'package:libraryprox_remote/constents/utils.dart';
import 'package:libraryprox_remote/features/dashboard/screens/students_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/students_services.dart';

import 'package:libraryprox_remote/models/student_model.dart';
import 'package:libraryprox_remote/provider/borrow_provider.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/logs_model.dart';
import '../../../models/user_model.dart';
import '../widgets/update_form_student.dart';

class StudentsActionsScreen extends StatefulWidget {
  static const String routerName = "/dashboard/students/student";

  final Students? student;
  final bool? isDark;
  const StudentsActionsScreen({Key? key, this.student, this.isDark})
      : super(key: key);

  @override
  State<StudentsActionsScreen> createState() => _StudentsActionsScreenState();
}

class _StudentsActionsScreenState extends State<StudentsActionsScreen> {
  StudentServices studentsServices = StudentServices();
  LogsServices logsServices = LogsServices();

  String _key = "";
  dynamic _value = "";

  // Validation
  void validation(String key, dynamic value) {
    if (key == "date_birth") {
      value = TimeConverter.convertToRealTime(value);
    }

    if (key == "signin_date") {
      value = TimeConverter.convertToRealTime(value);
    }
    if (key == "is_banned") {
      value = value ? transelator(context, "Yes") : transelator(context, "No");
      key = "Banned";
    }

    if (key == "decription") {
      key = "Description";
    }

    // String Pattren keys
    key = key.capitalize().replaceAll("_", " ");

    if (key == "role") {
      switch (value) {
        case 0:
          value = "Normal Student";

          break;
        case 1:
          value = "VIP Student";

          break;
        case 2:
          value = "VVIP Student";

          break;
        default:
          value = value;
      }
    }

    if (key == "Owner id") {
      key = "User Id";
    }
    if (key == "Date birth") {
      key = "Date Birth";
    }
    if (key == "Fname") {
      key = "Student Full Name";
    }
    if (key == "Phone") {
      key = "Phone Number";
    }
    value ??= "No";

    key = transelator(context, key);
    setState(() {
      _key = key;
      _value = value;
    });
  }

  // Delete Student
  deleteStudent() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    await studentsServices.removeStudent(widget.student!.id, context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(StudentsScreen.routerName, (route) => false);

    logsServices.log(
        Logs(
            opration: "Delete Book ${widget.student!.id}", user: user.username),
        context);

    setState(() {});
  }

  // Update Book Form
  updateStudent() {
    showDialog(
      context: context,
      builder: (context) {
        return FormUpdate(student: widget.student);
      },
    );
  }

  // Add Book To Borrow
  bookToBorrow() {
    // If book is not avaible
    if (widget.student!.isBanned) {
      showSnackBar(context, "You Cant Add To Borrow ");
      return null;
    }

    Provider.of<BorrowProvider>(context, listen: false)
        .setStudentId(widget.student!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustumAppBar(
          title: widget.student == null ? "" : widget.student!.fName,
          context: context,
          returnBtn: true),
      drawer: const CustomDrawer(),
      floatingActionButton: AwesomeFloatingActionBar(
        onTapDelete: deleteStudent,
        onTapAddToBorrow: bookToBorrow,
        onTapEdit: updateStudent,
        borrowState: !widget.student!.isBanned,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
                children: widget.student!.toMap().entries.map((e) {
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
