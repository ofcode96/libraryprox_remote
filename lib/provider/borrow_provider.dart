// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class BorrowIds {
  int bookId;
  int studentId;
  BorrowIds({
    required this.bookId,
    required this.studentId,
  });
}

class BorrowProvider extends ChangeNotifier {
  final BorrowIds _borrowIds = BorrowIds(bookId: 0, studentId: 0);

  BorrowIds get borrowIds => _borrowIds;

  void setBookId(int book) {
    _borrowIds.bookId = book;
    notifyListeners();
  }

  void setStudentId(int student) {
    _borrowIds.studentId = student;
    notifyListeners();
  }

  void clear() {
    _borrowIds.studentId = 0;
    _borrowIds.bookId = 0;
    notifyListeners();
  }
}
