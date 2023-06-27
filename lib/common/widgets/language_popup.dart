import 'package:flutter/material.dart';
import 'package:libraryprox_remote/constents/languages.dart';
import 'package:libraryprox_remote/provider/local_provider.dart';
import 'package:provider/provider.dart';

class LanguagePopup extends StatelessWidget {
  const LanguagePopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: Provider.of<LocalProvider>(context).local.toString(),
      onCanceled: () {},
      onSelected: (value) {
        Locale local = Locale(value);
        Provider.of<LocalProvider>(context, listen: false).setLocal(local);
      },
      icon: const Icon(Icons.translate),
      itemBuilder: (context) => languages
          .map((lng) => PopupMenuItem(
                value: lng,
                child: Text(lng.toUpperCase()),
              ))
          .toList(),
    );
  }
}
