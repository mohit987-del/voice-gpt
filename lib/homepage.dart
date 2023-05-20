
import 'package:assistant/pallete.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'widgets/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = 'yo';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Allen",
          style: TextStyle(
            color: Pallete.blackColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      AssetImage("assets/images/virtualAssistant.png"),
                  backgroundColor: Pallete.assistantCircleColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius:
                    BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
              ),
              child: const Text(
                "Good Morning, what task can i do for you ?",
                style: TextStyle(
                  fontFamily: "Cera Pro",
                  fontSize: 20,
                  color: Pallete.mainFontColor,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10).copyWith(left: 40),
              alignment: Alignment.centerLeft,
              child: const Text(
                "Here are a few features ",
                style: TextStyle(
                  color: Pallete.mainFontColor,
                  fontFamily: "Cera Pro",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
             const Column(
              children:  [
                SuggestionWidget(
                  heading: "ChatGPT",
                  data:
                      "A smarter wat to stay organized and informed with ChatGPT",
                  color: Pallete.firstSuggestionBoxColor,
                ),
                SuggestionWidget(
                  heading: "Dall-E",
                  data:
                      "Get inspired and stay creative with your personal assistant powered by Dall-E",
                  color: Pallete.secondSuggestionBoxColor,
                ),
                SuggestionWidget(
                  heading: "Smart Voice Assistant",
                  data:
                      "Get the best of both worlds with a voice assistant powered by Dall-E  and ChatGPT",
                  color: Pallete.thirdSuggestionBoxColor,
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
            _speechToText.isNotListening ? _startListening() : _stopListening() ;
        },
        child: Icon(Icons.mic),
      ),
    );
  }
}
