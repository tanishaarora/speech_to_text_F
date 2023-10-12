import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

class SpeechToText extends StatefulWidget {
  const SpeechToText({super.key});

  @override
  State<SpeechToText> createState() => _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToText> {
  late stt.SpeechToText _speechToText;
  bool isListening = false;
  String text = 'Press the button to start speaking...';

  @override
  void initState() {
    super.initState();
    _speechToText = stt.SpeechToText();
  }

  void onListen() async {
    if (!isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() {
          isListening = true;
        });
        _speechToText.listen(
         //   listenFor: Duration(minutes: 10),
            onResult: (val) => setState(() {
                  text = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        isListening = false;
        _speechToText.stop();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech to text'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        endRadius: 60,
        glowColor: Colors.blue,
        repeat: true,
        animate: _speechToText.isListening,
        showTwoGlows: true,
        duration: Duration(milliseconds: 2000),
        child: FloatingActionButton(
          onPressed: () {
            onListen();
          },
          child: Icon(_speechToText.isListening ? Icons.close : Icons.mic),

        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 25, 25, 150),
          child: Text(text, style: TextStyle(color: Colors.black, fontSize: 15),),
        ),
      ),
    );
  }
}
