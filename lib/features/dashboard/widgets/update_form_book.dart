// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:libraryprox_remote/common/widgets/dropdown.dart';
import 'package:provider/provider.dart';

import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/custom_text_field.dart';
import 'package:libraryprox_remote/common/widgets/update_button.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/books_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';

import '../../../models/book_model.dart';
import '../../../models/logs_model.dart';
import '../../../models/user_model.dart';
import '../../../provider/user_provider.dart';

class FormUpdate extends StatefulWidget {
  final Books? book;
  const FormUpdate({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  State<FormUpdate> createState() => _FormUpdateState();
}

class _FormUpdateState extends State<FormUpdate> {
  List<String> listItemsAvaible = ["Yes", "No"];

  BooksServices booksServices = BooksServices();
  LogsServices logsServices = LogsServices();

  // Form Key
  final _updateBookFormKey = GlobalKey<FormState>();

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
  final TextEditingController _isAvaibleController = TextEditingController();

  initControllers() {
    _titleController.text = widget.book!.title;
    _verionController.text = widget.book!.version.toString();
    _partController.text = widget.book!.part.toString();
    _pagesController.text = widget.book!.pages.toString();
    _datePrintController.text =
        TimeConverter.convertToRealTime(widget.book!.datePrint);
    _priceController.text = widget.book!.price.toString();
    _copiesController.text = widget.book!.copies.toString();
    _editionController.text = widget.book!.edition.toString();
    _authorController.text = widget.book!.author.toString();
    _decriptionController.text = widget.book!.description != null
        ? widget.book!.description.toString()
        : "";
    _isAvaibleController.text = widget.book!.isAviable ? "Yes" : "No";
  }

  updateBook() {
    Books book = Books(
      id: widget.book!.id,
      title: _titleController.text,
      datePrint: _datePrintController.text,
      ownerId: widget.book!.ownerId,
      isAviable: _isAvaibleController.text == transelator(context, "Yes")
          ? true
          : false,
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

    booksServices.updateBook(book.id, book, context);
    User user = Provider.of<UserProvider>(context, listen: false).user;

    logsServices.log(
        Logs(opration: "Update Book ${widget.book!.id}", user: user.username),
        context);
    setState(() {});
    Navigator.pop(context);
    Navigator.of(context).pushReplacementNamed(BooksScreen.routerName);
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
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;

    listItemsAvaible =
        listItemsAvaible.map((e) => transelator(context, e)).toList();

    return AlertDialog(
      title: Text(transelator(context, "Update Book")),
      content: SingleChildScrollView(
        child: Form(
          key: _updateBookFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transelator(context, "Book Title")),
              const SizedBox(height: 3),
              CustomTextField(
                controller: _titleController,
                hintText: transelator(context, "Book Title"),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          controller: _verionController,
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
                keyboardType: TextInputType.datetime,
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
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(transelator(context, "Aviable")),
                        const SizedBox(height: 3),
                        DropDown(
                          value:
                              transelator(context, _isAvaibleController.text),
                          items: listItemsAvaible
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
                            _isAvaibleController.text = value!;
                            setState(() {});
                          },
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
              UpdateButton(onPressed: () {
                if (_updateBookFormKey.currentState!.validate()) {
                  updateBook();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
