// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:libraryprox_remote/common/helpers/generate_id.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/add_button.dart';

import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/features/dashboard/screens/borrow_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/borrows_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/models/borrow_model.dart';
import 'package:libraryprox_remote/models/logs_model.dart';
import 'package:libraryprox_remote/provider/borrow_provider.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/user_model.dart';

class FormAdd extends StatefulWidget {
  const FormAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  BorrowsServices borrowsServices = BorrowsServices();
  LogsServices logsServices = LogsServices();

  // Form Key
  final _addBorrowFormKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController _bookIdController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  addStudent() {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    int borrowId = generateUniqueId();
    Borrow borrow = Borrow(
        id: borrowId,
        bookId: int.parse(_bookIdController.text),
        studentId: int.parse(_studentIdController.text),
        ownerId: user.id,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        state: 0);

    borrowsServices.addNewBorrow(borrow, context);
    logsServices.log(
        Logs(opration: "Add New Borrow $borrowId", user: user.username),
        context);

    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(BorrowScreen.routerName);
    Provider.of<BorrowProvider>(context, listen: false).clear();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _startDateController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
    _endDateController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose Controller
    _bookIdController.dispose();
    _studentIdController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _bookIdController.text =
        Provider.of<BorrowProvider>(context).borrowIds.bookId.toString();
    _studentIdController.text =
        Provider.of<BorrowProvider>(context).borrowIds.studentId.toString();

    return AlertDialog(
      title: Text(transelator(context, "Borrow")),
      content: SingleChildScrollView(
        child: Form(
          key: _addBorrowFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transelator(context, "Book ID")),
              const SizedBox(height: 3),
              CustomTextField(
                readOnly: true,
                controller: _bookIdController,
                hintText: transelator(context, "Book ID"),
                onChanged: (String text) async {},
              ),
              const SizedBox(height: 5),
              Text(transelator(context, "Student ID")),
              const SizedBox(height: 3),
              CustomTextField(
                controller: _studentIdController,
                hintText: transelator(context, "Student ID"),
                onChanged: (String text) async {},
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Start Date")),
                        const SizedBox(height: 5),
                        CustomTextField(
                          readOnly: true,
                          controller: _startDateController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.parse(_startDateController.text),
                                firstDate: DateTime(1999),
                                lastDate: DateTime(DateTime.now().year + 5));

                            if (pickedDate != null) {
                              setState(() {
                                _startDateController.text =
                                    DateFormat("yyyy-MM-dd").format(pickedDate);
                              });
                            }
                          },
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "End Date")),
                        const SizedBox(height: 5),
                        CustomTextField(
                          readOnly: true,
                          controller: _endDateController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    DateTime.parse(_endDateController.text),
                                firstDate: DateTime(1999),
                                lastDate: DateTime(DateTime.now().year + 5));

                            if (pickedDate != null) {
                              setState(() {
                                _endDateController.text =
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
              AddButton(onPressed: () {
                if (_addBorrowFormKey.currentState!.validate()) {
                  addStudent();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
