// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/add_button.dart';
import 'package:provider/provider.dart';

import 'package:libraryprox_remote/common/helpers/generate_id.dart';
import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/features/dashboard/screens/students_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/students_services.dart';
import 'package:libraryprox_remote/models/logs_model.dart';
import 'package:libraryprox_remote/models/student_model.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';

import '../../../models/user_model.dart';

class FormAdd extends StatefulWidget {
  const FormAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  StudentServices studentsServices = StudentServices();
  LogsServices logsServices = LogsServices();

  List<String> listItemsRoles = ["Normal", "VIP", "VVIP"];

  // Form Key
  final _addStudentFormKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _adderssController = TextEditingController();
  final TextEditingController _dateBirthController = TextEditingController();
  final TextEditingController _signiDateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _roleController =
      TextEditingController(text: "Normal");
  final TextEditingController _isBannedController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  addStudent() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    int studentId = generateUniqueId();
    Students student = Students(
      id: studentId,
      fName: _fnameController.text,
      signIn: _signiDateController.text,
      ownerId: user.id,
      isBanned: false,
      role: roleOPtions(),
      description: _descriptionController.text,
      dateBirth: _dateBirthController.text,
      phone: _phoneController.text,
      address: _adderssController.text,
    );

    studentsServices.addNewStudent(student, context);
    logsServices.log(
        Logs(opration: "Add New Student $studentId", user: user.username),
        context);

    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(StudentsScreen.routerName);
    setState(() {});
  }

  int roleOPtions() {
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
    _signiDateController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _dateBirthController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
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
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    return AlertDialog(
      title: Text(transelator(context, "Student")),
      content: SingleChildScrollView(
        child: Form(
          key: _addStudentFormKey,
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
                                firstDate: DateTime(1900),
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
                        DropdownButton(
                          isExpanded: true,
                          alignment: Alignment.centerRight,
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
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
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(transelator(context, "Description")),
                  const SizedBox(height: 3),
                  CustomTextField(
                    controller: _descriptionController,
                    hintText: transelator(context, "Description"),
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              AddButton(
                onPressed: () {
                  if (_addStudentFormKey.currentState!.validate()) {
                    addStudent();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
