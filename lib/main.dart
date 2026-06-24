import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/currency_controller.dart';
import 'pages/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CurrencyController(),

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),

      home: HomePage(),
    );
  }
}
