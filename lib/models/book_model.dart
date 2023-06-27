import 'dart:convert';

class Books {
  final int id;
  final String title;
  final int? version;
  final int? part;
  final int? pages;
  final String datePrint;
  final double? price;
  final int? copies;
  final int? edition;
  final String? author;
  final String? description;
  final int ownerId;
  bool isAviable;
  int? lastBrrowed;
  Books({
    required this.id,
    required this.title,
    this.version,
    this.part,
    this.pages,
    required this.datePrint,
    this.price,
    this.copies,
    this.edition,
    this.author,
    this.description,
    required this.ownerId,
    required this.isAviable,
    this.lastBrrowed,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'version': version,
      'part': part,
      'pages': pages,
      'date_print': datePrint,
      'price': price,
      'copies': copies,
      'edition': edition,
      'author': author,
      'decription': description,
      'owner_id': ownerId,
      'is_aviable': isAviable,
      'last_browed': lastBrrowed,
    };
  }

  factory Books.fromMap(Map<String, dynamic> map) {
    return Books(
      id: map['id'] as int,
      title: map['title'] as String,
      version: map['version'] != null ? map['version'] as int : null,
      part: map['part'] != null ? map['part'] as int : null,
      pages: map['pages'] != null ? map['pages'] as int : null,
      datePrint: map['date_print'] as String,
      price: map['price'] != null ? map['price'] as double : null,
      copies: map['copies'] != null ? map['copies'] as int : null,
      edition: map['edition'] != null ? map['edition'] as int : null,
      author: map['author'] != null ? map['author'] as String : null,
      description:
          map['decription'] != null ? map['decription'] as String : null,
      ownerId: map['owner_id'] as int,
      isAviable: map['is_aviable'] as bool,
      lastBrrowed:
          map['last_browed'] != null ? map['last_browed'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Books.fromJson(String source) =>
      Books.fromMap(json.decode(source) as Map<String, dynamic>);
}
