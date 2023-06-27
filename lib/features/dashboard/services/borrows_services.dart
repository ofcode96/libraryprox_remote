// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/apis/borrows_apis.dart';
import 'package:libraryprox_remote/common/helpers/time_converter.dart';
import 'package:libraryprox_remote/constents/error_handling.dart';
import 'package:libraryprox_remote/constents/utils.dart';
import 'package:libraryprox_remote/features/dashboard/services/books_services.dart';
import 'package:libraryprox_remote/models/book_model.dart';
import 'package:libraryprox_remote/models/borrow_model.dart';

BorrowsApi borrowsApi = BorrowsApi();

BooksServices booksServices = BooksServices();

class BorrowsServices {
  Future<List<Borrow>> getAllBorrow(BuildContext context, String? query) async {
    List<Borrow> borrows = [];

    Response response = await borrowsApi.getAll();
    var notValideData = jsonDecode(response.body);

    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        for (var borrow in notValideData) {
          borrows.add(Borrow.fromJson(jsonEncode(borrow)));
        }
      },
    );

    if (query != null) {
      return borrows.where((borrow) {
        final searchResult = borrow.studentId
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            borrow.bookId
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            borrow.id.toString().toLowerCase().contains(query.toLowerCase());
        return searchResult;
      }).toList();
    }

    return borrows;
  }

  Future removeBorrow(int id, BuildContext context) async {
    Response borrowResponse = await borrowsApi.getOneById(id);
    Response response = await borrowsApi.delete(id);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () async {
        showSnackBar(context, "Deleted Borrow ");
        Borrow borrow =
            Borrow.fromJson(jsonEncode(jsonDecode(borrowResponse.body)));

        Books book = await booksServices.getOneBookById(borrow.bookId);

        Books updatedBook = Books(
            id: borrow.bookId,
            title: book.title,
            datePrint: TimeConverter.convertToRealTime(book.datePrint),
            ownerId: book.ownerId,
            isAviable: true,
            author: book.author,
            copies: book.copies,
            description: book.description,
            edition: book.copies,
            lastBrrowed: borrow.studentId,
            pages: book.pages,
            part: book.part,
            price: book.price,
            version: book.version);

        booksServices.updateBook(borrow.bookId, updatedBook, context);
      },
    );
  }

  Future updateBorrow(int id, Borrow borrow, BuildContext context) async {
    Response response = await borrowsApi.update(id, borrow);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Update Borrow ");
      },
    );
  }

  Future addNewBorrow(Borrow borrow, BuildContext context) async {
    Response response = await borrowsApi.addNew(borrow);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () async {
        Books book = await booksServices.getOneBookById(borrow.bookId);

        Books updatedBook = Books(
            id: borrow.bookId,
            title: book.title,
            datePrint: TimeConverter.convertToRealTime(book.datePrint),
            ownerId: book.ownerId,
            isAviable: false,
            author: book.author,
            copies: book.copies,
            description: book.description,
            edition: book.copies,
            lastBrrowed: borrow.studentId,
            pages: book.pages,
            part: book.part,
            price: book.price,
            version: book.version);

        booksServices.updateBook(borrow.bookId, updatedBook, context);
        showSnackBar(context, "Add borrow ");
      },
    );
  }

  Future borrowStatistics(BuildContext context) async {
    Response response = await borrowsApi.getStatstics();
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () async {
        // print(response.body);
      },
    );

    return response;
  }
}
