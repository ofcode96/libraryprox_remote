import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:libraryprox_remote/l10n/l10n.dart';
import 'package:libraryprox_remote/common/themes/dark.dart';
import 'package:libraryprox_remote/common/themes/light.dart';
import 'package:libraryprox_remote/features/auth/screens/auth_srceen.dart';
import 'package:libraryprox_remote/features/dashboard/screens/home_screen.dart';
import 'package:libraryprox_remote/provider/borrow_provider.dart';
import 'package:libraryprox_remote/provider/local_provider.dart';
import 'package:libraryprox_remote/provider/theme_provider.dart';
import 'package:libraryprox_remote/provider/user_provider.dart';
import 'package:libraryprox_remote/router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BorrowProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeProvider>(context).isDark;
    final localProvider = Provider.of<LocalProvider>(context);
    final initialScreen =
        Provider.of<UserProvider>(context).user.username.isEmpty
            ? const AuthScreen()
            : const HomeScreen();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LibraryProX',
      onGenerateRoute: (settings) => generateRouter(settings),
      theme: !isDark ? lightTheme : darkTheme,
      home: initialScreen,
      supportedLocales: L10n.all,
      locale: localProvider.local,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}
