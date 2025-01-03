import 'package:flutter/material.dart';
import 'package:shopping_app/screens/signup_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shopping_app/generated/l10n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = const Locale('en', '');

  void _toggleLanguage() {
    setState(() {
      _currentLocale = _currentLocale.languageCode == 'en'
          ? const Locale('ar')
          : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: _currentLocale,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SignUpPage(toggleLanguage: _toggleLanguage),
    );
  }
}
