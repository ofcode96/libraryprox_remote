import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Borrow {
  final int id;
  final String startDate;
  final String endDate;
  final int state;
  final int bookId;
  final int studentId;
  final int ownerId;
  Borrow({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.bookId,
    required this.studentId,
    required this.ownerId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'start_date': startDate,
      'end_date': endDate,
      'state': state,
      'book_id': bookId,
      'student_id': studentId,
      'owner_id': ownerId,
    };
  }

  factory Borrow.fromMap(Map<String, dynamic> map) {
    return Borrow(
      id: map['id'] as int,
      startDate: map['start_date'] as String,
      endDate: map['end_date'] as String,
      state: map['state'] as int,
      bookId: map['book_id'] as int,
      studentId: map['student_id'] as int,
      ownerId: map['owner_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Borrow.fromJson(String source) =>
      Borrow.fromMap(json.decode(source) as Map<String, dynamic>);
}
