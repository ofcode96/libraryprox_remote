import 'package:flutter/material.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Provider.of<ThemeProvider>(context).isDark;

    return IconButton(
      onPressed: () {
        Provider.of<ThemeProvider>(context, listen: false).setTheme(!isDark);
      },
      icon:
          Icon(!isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
    );
  }
}
