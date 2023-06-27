// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomeSearch extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  const CustomeSearch({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CustomeSearch> createState() => _CustomeSearchState();
}

class _CustomeSearchState extends State<CustomeSearch> {
  final TextEditingController _seearchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _seearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? local = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.fromLTRB(10, 8, 10, 8),
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black26)),
      height: 42,
      child: TextField(
        style: const TextStyle(color: Colors.black),
        onChanged: widget.onChanged,
        controller: _seearchController,
        decoration: InputDecoration(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: _seearchController.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _seearchController.clear();
                      widget.onChanged!('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  )
                : null,
            hintText: "${local.search}...",
            hintStyle: const TextStyle(color: Colors.black),
            border: InputBorder.none),
      ),
    );
  }
}
