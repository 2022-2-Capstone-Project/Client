import 'dart:convert';
import 'dart:io';
import 'package:capstone/senior/input_file.dart';
import 'package:capstone/senior/mapframe.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location_search.dart';
import 'location_controller.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'package:http/http.dart' as http;

class MakeThemePage extends StatefulWidget {
  const MakeThemePage({Key? key}) : super(key: key);

  @override
  State<MakeThemePage> createState() => _MakeThemePageState();
}

class _MakeThemePageState extends State<MakeThemePage> {
  List<String> items = ['학교', '맛집', '공부'];
  String? selectedItem = "학교";

  static final LatLng _kMapCenter = LatLng(37.532600, 127.024612);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  int _count = 0;

  void increment() {
    setState(() {
      _count++;
    });
  }

  void decrement() {
    setState(() {
      _count--;
    });
  }

  DateTime _selectedDate = DateTime.now();

  File? _image;
  PickedFile? _pickedFile;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        _image = File(_pickedFile!.path);
      });
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _participantController = TextEditingController();
  final TextEditingController _placeController = TextEditingController();

  void makeTheme(String username, password) async {
    var data = {};
    http
        .post(
          Uri.parse("http://127.0.0.1:8000/tour-theme/"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
          }),
        )
        .then((response) => print(response.body))
        .catchError((error) => print(error));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            new Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                title: Text('테마 만들기',
                    style: TextStyle(
                        color: Color.fromARGB(255, 14, 99, 246),
                        fontWeight: FontWeight.bold,
                        fontSize: 25)), // You can add title here
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 14, 99, 246)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor:
                    Colors.transparent, //You can make this transparent
                elevation: 0.0, //No shadow
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: (() => _pickImage()),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 50,
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              alignment: Alignment.center,
              child: _pickedFile != null
                  ? Image.file(
                      File(_pickedFile!.path),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : const Text('사진 선택하세요',
                      style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '제목',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            //category
            Container(
              width: 340,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: TextStyle(fontSize: 20)),
                          ))
                      .toList(),
                  hint: Text('카테고리'),
                  onChanged: ((item) => setState(() => selectedItem = item)),
                  iconSize: 30,
                  icon: Icon(Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 14, 99, 246)),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            // google maps
            Text(
              '만날 위치는 선택해주세요: ',
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 14, 99, 246)),
            ),
            Container(
              child: ClipRRect(
                child: Container(
                  padding: EdgeInsets.all(30),
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: double.infinity,
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    initialCameraPosition: _kInitialPosition,
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 30,
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapFrame(),
                        ),
                      );
                    },
                    child: Text('위치 검색',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //participants
            Container(
              width: 340,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    '  인원: ',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Expanded(child: Container()),
                  Container(
                    width: 30,
                    height: 30,
                    child: FloatingActionButton(
                      heroTag: "add people for make theme",
                      child: Icon(Icons.add),
                      onPressed: () {
                        increment();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('${_count}'),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    child: FloatingActionButton(
                      heroTag: "remove people for make theme",
                      child: Icon(Icons.remove),
                      onPressed: () {
                        decrement();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 30,
            ),

            //make theme button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 40,
                padding: EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 14, 99, 246),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Text('테마 만들기',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20))),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
