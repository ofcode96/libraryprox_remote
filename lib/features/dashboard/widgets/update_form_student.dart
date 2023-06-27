// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/common/widgets/dropdown.dart';
import 'package:libraryprox_remote/common/widgets/update_button.dart';
import 'package:libraryprox_remote/features/dashboard/screens/students_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/students_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/models/student_model.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/logs_model.dart';
import '../../../models/user_model.dart';
import '../../../provider/user_provider.dart';

class FormUpdate extends StatefulWidget {
  final Students? student;
  const FormUpdate({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  State<FormUpdate> createState() => _FormUpdateState();
}

class _FormUpdateState extends State<FormUpdate> {
  List<String> listItemsBanned = ["Yes", "No"];
  List<String> listItemsRoles = ["Normal", "VIP", "VVIP"];

  StudentServices studentsServices = StudentServices();
  LogsServices logsServices = LogsServices();

  // Form Key
  final _updateStudentFormKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _adderssController = TextEditingController();
  final TextEditingController _dateBirthController = TextEditingController();
  final TextEditingController _signiDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _isBannedController = TextEditingController();
  final TextEditingController _decriptionController = TextEditingController();

  initControllers() {
    _fnameController.text = widget.student!.fName.toString();
    _adderssController.text = widget.student!.address.toString();
    _phoneController.text = widget.student!.phone.toString();
    _roleController.text = widget.student!.role == 0
        ? listItemsRoles[0]
        : widget.student!.role == 1
            ? listItemsRoles[1]
            : listItemsRoles[2];
    _dateBirthController.text =
        TimeConverter.convertToRealTime(widget.student!.dateBirth);

    _signiDateController.text =
        TimeConverter.convertToRealTime(widget.student!.signIn);

    _decriptionController.text = widget.student!.description != null
        ? widget.student!.description.toString()
        : "";
    _isBannedController.text = widget.student!.isBanned ? "Yes" : "No";
  }

  updateStudent() {
    User user = Provider.of<UserProvider>(context, listen: false).user;

    Students student = Students(
        id: widget.student!.id,
        fName: _fnameController.text,
        dateBirth: _dateBirthController.text,
        ownerId: user.id,
        isBanned: transelator(context, _isBannedController.text) ==
                transelator(context, "Yes")
            ? true
            : false,
        address: _adderssController.text,
        role: roleOPtionsInt(),
        description: _decriptionController.text,
        phone: _phoneController.text,
        signIn: TimeConverter.convertToRealTime(widget.student!.signIn));

    studentsServices.updateStudent(student.id, student, context);

    logsServices.log(
        Logs(
            opration: "Update Student ${widget.student!.id}",
            user: user.username),
        context);
    setState(() {});
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(StudentsScreen.routerName);
  }

  String roleOptionStr() {
    switch (int.parse(_roleController.text)) {
      case 0:
        return "Normal";
      case 1:
        return "VIP";
      case 2:
        return "VVIP";
      default:
        return "Normal";
    }
  }

  int roleOPtionsInt() {
    switch (_roleController.text) {
      case "Normal":
        return 0;
      case "VIP":
        return 1;
      case "VVIP":
        return 2;

      default:
        return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    super.dispose();

// Dispose Controller
    _fnameController.dispose();
    _adderssController.dispose();
    _dateBirthController.dispose();
    _signiDateController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    _isBannedController.dispose();
    _decriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;

    listItemsBanned = listItemsBanned
        .map(
          (e) => transelator(context, e),
        )
        .toList();

    return AlertDialog(
      title: Text(transelator(context, "Update Student")),
      content: SingleChildScrollView(
        child: Form(
          key: _updateStudentFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transelator(context, "Student Full Name")),
              const SizedBox(height: 3),
              CustomTextField(
                controller: _fnameController,
                hintText: transelator(context, "Student Full Name"),
                onChanged: (String text) async {},
              ),
              const SizedBox(height: 5),
              Text(transelator(context, "Address")),
              const SizedBox(height: 3),
              CustomTextField(
                controller: _adderssController,
                hintText: transelator(context, "Address"),
                onChanged: (String text) async {},
              ),
              Text(transelator(context, "Phone Number")),
              const SizedBox(height: 3),
              CustomTextField(
                controller: _phoneController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                hintText: transelator(context, "Phone Number"),
                onChanged: (String text) async {},
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Date Birth")),
                        const SizedBox(height: 5),
                        CustomTextField(
                          readOnly: true,
                          controller: _dateBirthController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.parse(_dateBirthController.text),
                                firstDate: DateTime(1999),
                                lastDate: DateTime(DateTime.now().year + 5));

                            if (pickedDate != null) {
                              setState(() {
                                _dateBirthController.text =
                                    DateFormat("yyyy-MM-dd").format(pickedDate);
                              });
                            }
                          },
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Role")),
                        const SizedBox(height: 3),
                        DropDown(
                          value: _roleController.text,
                          items: listItemsRoles
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _roleController.text = value!;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Banned")),
                        const SizedBox(height: 3),
                        DropDown(
                          value: transelator(context, _isBannedController.text),
                          items: listItemsBanned
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          color: isDark
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _isBannedController.text = value!;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transelator(context, "Description")),
                  const SizedBox(height: 3),
                  CustomTextField(
                    controller: _decriptionController,
                    hintText: transelator(context, "Description"),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              UpdateButton(onPressed: () {
                if (_updateStudentFormKey.currentState!.validate()) {
                  updateStudent();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
