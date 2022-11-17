import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Container(
                  height: 52,
                  margin: EdgeInsets.only(top: 8.0),
                  padding: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 1.0),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        autofocus: false,
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: hint,
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 0)),
                        ),
                      ))
                    ],
                  ),
                )
              ],
            )));
  }
}
