import 'package:flutter/material.dart';
import 'package:libraryprox_remote/common/helpers/generate_id.dart';

class ListDetailAction extends StatelessWidget {
  final String keyList;
  final dynamic valueList;

  const ListDetailAction(
      {super.key, required this.keyList, required this.valueList});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key(generateUniqueId().toString()),
      title: Text("$keyList  : $valueList"),
    );
  }
}
