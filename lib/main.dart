import 'package:flutter/material.dart';
import 'package:newspapers/NewspapersList.dart';

void main() {
  runApp(NewspapersApp());
}

class NewspapersApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Newspapers",
      theme: ThemeData(primarySwatch: Colors.green, accentColor: Colors.red),
      home: NewspapersList(title: "Trang chủ"),
    );
  }
}
