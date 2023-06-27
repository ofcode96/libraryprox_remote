import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Students {
  final int id;
  final String fName;
  final String address;
  final String dateBirth;
  final String signIn;
  final String phone;
  final int role;
  final bool isBanned;
  final String? description;
  final int ownerId;

  Students({
    required this.id,
    required this.fName,
    required this.address,
    required this.dateBirth,
    required this.signIn,
    required this.phone,
    required this.role,
    required this.isBanned,
    this.description,
    required this.ownerId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fname': fName,
      'address': address,
      'date_birth': dateBirth,
      'signin_date': signIn,
      'phone': phone,
      'role': role,
      'is_banned': isBanned,
      'decription': description,
      'owner_id': ownerId,
    };
  }

  factory Students.fromMap(Map<String, dynamic> map) {
    return Students(
      id: map['id'] as int,
      fName: map['fname'] as String,
      address: map['address'] as String,
      dateBirth: map['date_birth'] as String,
      signIn: map['signin_date'] as String,
      phone: map['phone'] as String,
      role: map['role'] as int,
      isBanned: map['is_banned'] as bool,
      description:
          map['decription'] != null ? map['decription'] as String : null,
      ownerId: map['owner_id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Students.fromJson(String source) =>
      Students.fromMap(json.decode(source) as Map<String, dynamic>);
}
