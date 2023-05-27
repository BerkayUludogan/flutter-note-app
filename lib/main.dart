import 'package:flutter/material.dart';
import 'package:flutter_proje1/pages/main_page_view.dart';
import 'package:flutter_proje1/product/locale_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleManager.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: const Scaffold(
        body: MainPageView(),
      ),
    );
  }
}
