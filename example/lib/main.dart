import 'package:flutter/material.dart';
import 'package:flutter_load_kit/flutter_load_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loadkit Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: Center(
          child: SizedBox(
            width: 300,
            child: LoadKitLineChase(
              itemCount: 7,
            ),
          ),
        ),
      ),
    );
  }
}
