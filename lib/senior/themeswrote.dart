import 'package:capstone/senior/editthemepage.dart';
import 'package:capstone/senior/edittourdetails.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ThemesWrotePage extends StatefulWidget {
  const ThemesWrotePage({Key? key}) : super(key: key);

  @override
  State<ThemesWrotePage> createState() => _ThemesWrotePageState();
}

class _ThemesWrotePageState extends State<ThemesWrotePage> {
  void _showPopUp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('삭제하시겠습니까??'),
            content: Text('Once delete, cannot be undone'),
            actions: [
              MaterialButton(
                onPressed: () {},
                child: Text('아니요'),
              ),
              MaterialButton(
                onPressed: () {},
                child: Text('예'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 14, 99, 246)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('내가 쓴 테마 목록',
            style: TextStyle(
                color: Color.fromARGB(255, 14, 99, 246), fontSize: 25)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: ((context) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditThemePage(),
                  ),
                );
              }),
              backgroundColor: Colors.blue,
              icon: Icons.edit,
            ),
            SlidableAction(
              onPressed: ((context) {
                _showPopUp(context);
              }),
              backgroundColor: Colors.red,
              icon: Icons.delete,
            )
          ]),
          child: Container(
            height: 90,
            color: Colors.grey.shade200,
            child: Center(
              child: ListTile(
                title: Text('테마 1'),
                subtitle: Text('--간단한 설명--'),
                leading: Icon(
                  Icons.school,
                  size: 40,
                  color: Colors.blueAccent,
                ),
                trailing: Icon(Icons.arrow_right_outlined),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
