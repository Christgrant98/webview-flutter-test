import 'package:flutter/material.dart';
import 'package:webview_flutterxwebview_flutterx/pade.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(child: Center(child: DailySteppsPage())),
      ),
    );
  }
}
