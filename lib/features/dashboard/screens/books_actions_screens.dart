// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/widgets/list_detail_action.dart';
import 'package:provider/provider.dart';

import 'package:libraryprox_remote/common/helpers/capitalize.dart';
import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/common/helpers/transelator.dart';
import 'package:libraryprox_remote/common/widgets/awesome_floating_action_button.dart';
import 'package:libraryprox_remote/common/widgets/custom_app_bar.dart';
import 'package:libraryprox_remote/common/widgets/custom_drawer.dart';
import 'package:libraryprox_remote/constents/utils.dart';
import 'package:libraryprox_remote/features/dashboard/screens/books_screen.dart';
import 'package:libraryprox_remote/features/dashboard/services/books_services.dart';
import 'package:libraryprox_remote/features/dashboard/services/logs_services.dart';
import 'package:libraryprox_remote/features/dashboard/widgets/update_form_book.dart';
import 'package:libraryprox_remote/models/book_model.dart';
import 'package:libraryprox_remote/provider/borrow_provider.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';

import '../../../models/logs_model.dart';
import '../../../models/user_model.dart';

class BooksActionsScreen extends StatefulWidget {
  static const String routerName = "/dashboard/books/book";

  final Books? book;
  final bool? isDark;
  const BooksActionsScreen({Key? key, this.book, this.isDark})
      : super(key: key);

  @override
  State<BooksActionsScreen> createState() => _BooksActionsScreenState();
}

class _BooksActionsScreenState extends State<BooksActionsScreen> {
  BooksServices booksServices = BooksServices();
  LogsServices logsServices = LogsServices();
  String _key = "";
  dynamic _value = "";

  // Validation
  void validation(String key, dynamic value) {
    if (key == "date_print") {
      value = TimeConverter.convertToRealTime(value);
    }
    if (key == "is_aviable") {
      value = value ? transelator(context, "Yes") : transelator(context, "No");
    }

    value ??= "No";

    key = key.capitalize().replaceAll("_", " ");

    if (key == "Title") {
      key = "Book Title";
    }
    if (key == "Date print") {
      key = "Date Print";
    }
    if (key == "Decription") {
      key = "Description";
    }
    if (key == "Is aviable") {
      key = "Aviable";
    }
    if (key == "Owner id") {
      key = "User Id";
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
    await booksServices.removeBook(widget.book!.id, context);
    Navigator.of(context)
        .pushNamedAndRemoveUntil(BooksScreen.routerName, (route) => false);

    logsServices.log(
        Logs(opration: "Delete Book ${widget.book!.id}", user: user.username),
        context);

    setState(() {});
  }

  // Update Book Form
  updateBook() {
    showDialog(
      context: context,
      builder: (context) {
        return FormUpdate(book: widget.book);
      },
    );
  }

  // Add Book To Borrow
  bookToBorrow() {
    // If book is not avaible
    if (!widget.book!.isAviable) {
      showSnackBar(context, "You Cant Add To Borrow ");
      return null;
    }

    Provider.of<BorrowProvider>(context, listen: false)
        .setBookId(widget.book!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustumAppBar(
          title: widget.book == null ? "" : widget.book!.title,
          context: context,
          returnBtn: true),
      drawer: const CustomDrawer(),
      floatingActionButton: AwesomeFloatingActionBar(
        onTapDelete: deleteBook,
        onTapAddToBorrow: bookToBorrow,
        onTapEdit: updateBook,
        borrowState: widget.book!.isAviable,
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
                children: widget.book!.toMap().entries.map((e) {
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
