import 'dart:convert';
import 'package:flutter/material.dart';
import '/components/background.dart';
import 'package:http/http.dart' as http;

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<String> messages = [
    'Hey! i\'m here to help you with choosing your decor.. what is your room type? enter 1 for bedroom, 2 for child room..'
  ];
  List<String> responses = [];

  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String apiUrl = 'http://192.168.56.1:8000/expert/get_room/';
  var toSend = 'room';
  void _sendMessage() async {
    String message = _textEditingController.text;
    if (message.isNotEmpty) {
      setState(() {
        messages.add('User: $message');
        _textEditingController.clear();
      });
      if (apiUrl != 'end') {
        var response =
            await http.post(Uri.parse(apiUrl), body: {toSend: message});
        var responseBody = jsonDecode(response.body);
        if (response.statusCode == 200) {
          setState(() {
            messages.add(responseBody['message']);
          });
          apiUrl = responseBody['api'];
          print('---api url');
          print(apiUrl);
          var parts = apiUrl.split('/get_');
          toSend = parts[1].replaceAll('/', '');
          print(apiUrl);
          print(toSend);
        } else if (response.statusCode == 400) {
          setState(() {
            messages.add("please select a valid choice");
          });
        }
      } else {
        //messages.add("Your previous case has been ended .. /n if you would like to start a new case please enter your room type, enter 1 for bedroom, 2 for child room.. ");
        setState(() {
          messages.add(
              "Your previous case has been ended .. /n if you would like to start a new case please enter your room type, enter 1 for bedroom, 2 for child room.. ");
        });
        apiUrl = 'http://192.168.56.1:8000/expert/get_room/';
        toSend = 'room';
      }

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            const Text(
              'ℍ𝕠𝕞𝕖 𝕕𝕖𝕔𝕠𝕣𝕒𝕥𝕠𝕣 𝕖𝕩𝕡𝕖𝕣𝕥',
              style: TextStyle(
                color: Color.fromARGB(186, 194, 102, 26),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            // SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  if (message.startsWith('User:')) {
                    return ListTile(
                      title: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(167, 243, 128, 33),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            message.substring(6),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      title: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            message,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
