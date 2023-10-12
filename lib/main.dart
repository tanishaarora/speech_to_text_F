import 'package:flutter/material.dart';
import 'package:image_to_text_conversion/speech_to_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget{
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Speech to text",
      home: SpeechToText(),
    );
  }
}