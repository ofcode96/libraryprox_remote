import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Logs {
  final String? date;
  final String opration;
  final String user;
  Logs({
    this.date,
    required this.opration,
    required this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'opration': opration,
      'user': user,
    };
  }

  factory Logs.fromMap(Map<String, dynamic> map) {
    return Logs(
      date: map['date'] != null ? map['date'] as String : null,
      opration: map['opration'] as String,
      user: map['user'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Logs.fromJson(String source) =>
      Logs.fromMap(json.decode(source) as Map<String, dynamic>);
}
