import 'package:flutter/material.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class DropDown extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>>? items;
  final void Function(String?)? onChanged;
  const DropDown({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context, listen: false).isDark;

    return SizedBox(
      height: 65,
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isDark ? Colors.white : Colors.black, width: 1.5),
          ),
        ),
        alignment: Alignment.center,
        elevation: 15,
        isExpanded: true,
        style: const TextStyle(
          fontSize: 20.0,
        ),
        value: value,
        items: items,
        onChanged: onChanged,
      ),
    );
  }
}
