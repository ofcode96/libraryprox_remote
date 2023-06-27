// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:libraryprox_remote/apis/books_apis.dart';
import 'package:libraryprox_remote/constents/error_handling.dart';
import 'package:libraryprox_remote/constents/utils.dart';
import 'package:libraryprox_remote/models/book_model.dart';

BooksApi booksApi = BooksApi();

class BooksServices {
  Future<List<Books>> getAllBooks(BuildContext context, String? query) async {
    List<Books> books = [];

    Response response = await booksApi.getAll();
    var notValideData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        for (var book in notValideData) {
          books.add(Books.fromJson(jsonEncode(book)));
        }
      },
    );

    if (query != null) {
      return books.where((book) {
        final searchResult =
            book.title.toLowerCase().contains(query.toLowerCase()) ||
                book.author!.toLowerCase().contains(query.toLowerCase()) ||
                book.id.toString().toLowerCase().contains(query.toLowerCase());
        return searchResult;
      }).toList();
    }

    return books;
  }

  Future<Books> getOneBookById(int id) async {
    Response response = await booksApi.getOneById(id);
    Books book = Books.fromJson(jsonEncode(jsonDecode(response.body)));

    return book;
  }

  Future removeBook(int id, BuildContext context) async {
    Response response = await booksApi.delete(id);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Deleted book ");
      },
    );
  }

  Future updateBook(int id, Books book, BuildContext context) async {
    Response response = await booksApi.update(id, book);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Update book ");
      },
    );
  }

  Future addNewBook(Books book, BuildContext context) async {
    Response response = await booksApi.addNew(book);
    httpErrorHandler(
      response: response,
      context: context,
      onSuccess: () {
        showSnackBar(context, "Add book ");
      },
    );
  }
}
