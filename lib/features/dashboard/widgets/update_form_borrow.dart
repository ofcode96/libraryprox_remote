// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/common/widgets/dropdown.dart';
import 'package:libraryprox_remote/common/widgets/update_button.dart';
import 'package:libraryprox_remote/features/dashboard/services/borrows_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/models/borrow_model.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/logs_model.dart';
import '../../../models/user_model.dart';
import '../../../provider/user_provider.dart';
import '../screens/borrow_screen.dart';

class FormUpdate extends StatefulWidget {
  final Borrow? borrow;
  const FormUpdate({
    Key? key,
    required this.borrow,
  }) : super(key: key);

  @override
  State<FormUpdate> createState() => _FormUpdateState();
}

class _FormUpdateState extends State<FormUpdate> {
  List<String> listItemsStetes = ["Runing", "Stoped", "Missed"];

  BorrowsServices borrowsServices = BorrowsServices();
  LogsServices logsServices = LogsServices();

  // Form Key
  final _updateBorrowFormKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController _bookIdController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();

  initControllers() {
    _bookIdController.text = widget.borrow!.bookId.toString();
    _studentIdController.text = widget.borrow!.studentId.toString();
    _startDateController.text =
        TimeConverter.convertToRealTime(widget.borrow!.startDate.toString());
    _endDateController.text =
        TimeConverter.convertToRealTime(widget.borrow!.endDate.toString());
    _stateController.text = widget.borrow!.state == 0
        ? listItemsStetes[0]
        : widget.borrow!.state == 1
            ? listItemsStetes[1]
            : listItemsStetes[2];
  }

  updateBorrow() {
    Borrow borrow = Borrow(
        id: widget.borrow!.id,
        bookId: widget.borrow!.bookId,
        studentId: widget.borrow!.studentId,
        ownerId: widget.borrow!.ownerId,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        state: transelator(context, _stateController.text) ==
                transelator(context, listItemsStetes[0])
            ? 0
            : transelator(context, _stateController.text) ==
                    transelator(context, listItemsStetes[1])
                ? 1
                : 2);

    borrowsServices.updateBorrow(borrow.id, borrow, context);
    User user = Provider.of<UserProvider>(context, listen: false).user;

    logsServices.log(
        Logs(
            opration: "Update Borrow ${widget.borrow!.id}",
            user: user.username),
        context);
    setState(() {});
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(BorrowScreen.routerName);
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
    _bookIdController.dispose();
    _studentIdController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;

    listItemsStetes =
        listItemsStetes.map<String>((e) => transelator(context, e)).toList();

    return AlertDialog(
      title: Text(transelator(context, "Update Borrow")),
      content: SingleChildScrollView(
        child: Form(
          key: _updateBorrowFormKey,
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
                                firstDate: DateTime(1900),
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
              Text(transelator(context, "State Borrow")),
              const SizedBox(height: 3),
              DropDown(
                value: transelator(context, _stateController.text),
                items: listItemsStetes
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(
                                color: isDark ? Colors.white : Colors.black),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  _stateController.text = value!;
                  setState(() {});
                },
              ),
              UpdateButton(onPressed: () {
                if (_updateBorrowFormKey.currentState!.validate()) {
                  updateBorrow();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
