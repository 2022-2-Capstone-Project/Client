import 'package:capstone/senior/confirmeditpage.dart';
import 'package:capstone/senior/mapframe.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'location_search.dart';
import 'location_controller.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

class EditTourPage extends StatefulWidget {
  const EditTourPage({Key? key}) : super(key: key);

  @override
  State<EditTourPage> createState() => _EditTourPageState();
}

class _EditTourPageState extends State<EditTourPage> {
  final items = ['Cat 1', 'Cat 2', 'Cat 3', 'Cat 4'];
  String? selectedItem;

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
                title: Text('투어 만들기',
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
            SizedBox(
              height: 30,
            ),

            //theme details
            Container(
              height: 50,
              width: 340,
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(child: Text('테마 정보')),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.add_a_photo_outlined,
                  size: 50,
                ),
              ),
            ),
            SizedBox(height: 25),

            //upload pic
            Text('사진 업로드', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 30,
            ),

            //enter title
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
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '제목',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
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
                      heroTag: "edit people",
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
                      heroTag: "remove people tour",
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

            //time
            Column(
              children: [
                Text(
                  '날짜과 시간 선택해주세요: ',
                  style: TextStyle(
                      fontSize: 20, color: Color.fromARGB(255, 14, 99, 246)),
                ),
                SizedBox(
                  height: 250,
                  child: ScrollDatePicker(
                    selectedDate: _selectedDate,
                    locale: Locale('en'),
                    onDateTimeChanged: (DateTime value) {
                      setState(() {
                        _selectedDate = value;
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            //enter tour details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromARGB(255, 14, 99, 246)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '투어 설명',
                    ),
                  ),
                ),
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
                    child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConfirmEditPage(),
                      ),
                    );
                  },
                  child: Text('수정',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                )),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
