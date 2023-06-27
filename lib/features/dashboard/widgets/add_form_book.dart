// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:libraryprox_remote/common/helpers/generate_id.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/add_button.dart';

import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/books_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/models/logs_model.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../models/book_model.dart';
import '../../../models/user_model.dart';

class FormAdd extends StatefulWidget {
  const FormAdd({
    Key? key,
  }) : super(key: key);

  @override
  State<FormAdd> createState() => _FormAddState();
}

class _FormAddState extends State<FormAdd> {
  BooksServices booksServices = BooksServices();
  LogsServices logsServices = LogsServices();

  // Form Key
  final _addBookFormKey = GlobalKey<FormState>();

  // TextControllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _verionController = TextEditingController();
  final TextEditingController _partController = TextEditingController();
  final TextEditingController _pagesController = TextEditingController();
  final TextEditingController _datePrintController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _copiesController = TextEditingController();
  final TextEditingController _editionController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _decriptionController = TextEditingController();

  addBook() async {
    User user = Provider.of<UserProvider>(context, listen: false).user;
    int bookId = generateUniqueId();
    Books book = Books(
      id: bookId,
      title: _titleController.text,
      datePrint: _datePrintController.text,
      ownerId: user.id,
      isAviable: true,
      lastBrrowed: 0,
      author: _authorController.text,
      copies: int.parse(_copiesController.text),
      description: _decriptionController.text,
      edition: int.parse(_editionController.text),
      pages: int.parse(_pagesController.text),
      part: int.parse(_partController.text),
      price: double.parse(_priceController.text),
      version: int.parse(_verionController.text),
    );

    booksServices.addNewBook(book, context);
    logsServices.log(
        Logs(opration: "Add New Book $bookId", user: user.username), context);

    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(BooksScreen.routerName);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _datePrintController.text = DateFormat("yyyy-MM-dd").format(DateTime.now());
  }

  @override
  void dispose() {
    super.dispose();

    // Dispose Controller
    _titleController.dispose();
    _verionController.dispose();
    _partController.dispose();
    _pagesController.dispose();
    _datePrintController.dispose();
    _priceController.dispose();
    _copiesController.dispose();
    _editionController.dispose();
    _authorController.dispose();
    _decriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(transelator(context, "Book")),
      content: SingleChildScrollView(
        child: Form(
          key: _addBookFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transelator(context, "Book Title")),
              const SizedBox(height: 3),
              CustomTextField(
                controller: _titleController,
                hintText: transelator(context, "Book"),
                onChanged: (String text) async {},
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Version")),
                        const SizedBox(height: 3),
                        CustomTextField(
                          controller: _verionController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: transelator(context, "Version"),
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Part")),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: _partController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: transelator(context, "Part"),
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Pages")),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: _pagesController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: transelator(context, "Pages"),
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(transelator(context, "Date Print")),
              CustomTextField(
                readOnly: true,
                controller: _datePrintController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.parse(_datePrintController.text),
                      firstDate: DateTime(1),
                      lastDate: DateTime(DateTime.now().year + 5));

                  if (pickedDate != null) {
                    setState(() {
                      _datePrintController.text =
                          DateFormat("yyyy-MM-dd").format(pickedDate);
                    });
                  }
                },
                onChanged: (String text) async {},
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Copies")),
                        const SizedBox(height: 3),
                        CustomTextField(
                          controller: _copiesController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: transelator(context, "Copies"),
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Edition")),
                        const SizedBox(height: 5),
                        CustomTextField(
                          controller: _editionController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: transelator(context, "Edition"),
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Price")),
                        const SizedBox(height: 3),
                        CustomTextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          hintText: transelator(context, "Price"),
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Author")),
                        const SizedBox(height: 3),
                        CustomTextField(
                          controller: _authorController,
                          // initailValue: widget.book!.author.toString(),
                          hintText: transelator(context, "Author"),
                          onChanged: (String text) async {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
              AddButton(onPressed: () {
                if (_addBookFormKey.currentState!.validate()) {
                  addBook();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
