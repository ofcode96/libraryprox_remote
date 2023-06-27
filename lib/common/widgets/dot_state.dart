// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:libraryprox_remote/provider/local_provider.dart';

class DotState extends StatelessWidget {
  const DotState({
    Key? key,
    this.successColor = Colors.green,
    this.failColor = Colors.red,
    required this.isSoccess,
  }) : super(key: key);
  final Color successColor;
  final Color failColor;

  final bool isSoccess;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: Provider.of<LocalProvider>(context).local?.languageCode == "ar"
          ? null
          : 0,
      left: Provider.of<LocalProvider>(context).local?.languageCode != "ar"
          ? null
          : 0,
      top: MediaQuery.of(context).size.height * .02,
      child: CircleAvatar(
        backgroundColor: isSoccess ? successColor : failColor,
        radius: 7,
      ),
    );
  }
}
