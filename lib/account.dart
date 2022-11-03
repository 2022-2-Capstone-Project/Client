import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('계정', style: TextStyle(fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
      ),
    );
  }
}