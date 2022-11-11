import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('채팅',
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
