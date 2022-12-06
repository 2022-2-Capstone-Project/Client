import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:capstone/api_manager.dart';
import 'package:capstone/senior/input_file.dart';
import 'package:capstone/senior/mapframe.dart';
import 'package:capstone/senior/navigation_bar.dart';
import 'package:capstone/theme_model.dart';
import 'package:capstone/tour_model.dart';
import 'package:capstone/tour_request.dart';
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
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:capstone/tour_model.dart';

class MakeTourPage extends StatefulWidget {
  String? chosenTheme;

  int? themeId;

  int? profileId;

  String username = "";

  MakeTourPage(
      {Key? key,
      this.chosenTheme,
      this.themeId,
      this.profileId,
      this.username = ""})
      : super(key: key);

  @override
  State<MakeTourPage> createState() => _MakeTourPageState();
}

class _MakeTourPageState extends State<MakeTourPage> with RestorationMixin {
  ImagePicker _imagePicker = ImagePicker();

  XFile? pickedImage;

  StreamController<File> _imagePicked = StreamController.broadcast();

  static final LatLng _kMapCenter = LatLng(37.532600, 127.024612);

  //String _selectedDate = "";

  String _selectedTimeStr = "";

  TimeOfDay? _selectedTimeofDay;

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

  final RestorableDateTime _selectedDateTime =
      RestorableDateTime(DateTime(2022, 12, 1));

  late RestorableRouteFuture<DateTime?> _restorableRouteFuture;

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDateTime.value = newSelectedDate;
        // ScaffoldMessenger.of(context).showSnackBar(snackBar)
      });
    }
  }

  int _count = 0;

  void increment() {
    setState(() {
      _count++;
    });
  }

  void decrement() {
    setState(() {
      if (_count > 0) {
        _count--;
      }
    });
  }

  DateTime _selectedDate = DateTime.now();

  final TextEditingController _chosenTheme = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _datetimeController = TextEditingController();
  final TextEditingController _startPlaceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //final Completer<GoogleMapController> _mapController = Completer();

  static Route<DateTime> _datePickerRoute(
      BuildContext context, Object? arguments) {
    final lastDate = DateTime.now();
    return DialogRoute<DateTime>(
        context: context,
        builder: (BuildContext context) {
          return DatePickerDialog(
              initialDate: DateTime.now(),
              firstDate: DateTime(2022),
              lastDate: DateTime(2023));
        });
  }

  @override
  void initState() {
    _restorableRouteFuture = RestorableRouteFuture(
        onComplete: _selectDate,
        onPresent: ((navigator, arguments) => navigator.restorablePush(
            _datePickerRoute,
            arguments: _selectedDateTime.value.millisecondsSinceEpoch)));

    if (widget.chosenTheme != null) {
      _chosenTheme.text = widget.chosenTheme ?? "";
    }
    super.initState();
  }

  void showSnackbar(BuildContext context, String msg, {Function? action}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(msg),
        action: SnackBarAction(
          label: "Done",
          onPressed: (() {
            if (action != null) {
              action.call();
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (setting) => NavBar()),
                  (route) => false);
            }
          }),
        )));
  }

  @override
  Widget build(BuildContext context) {
    Future<TimeOfDay?> _selectedTimeRes;
    return Scaffold(
      appBar: AppBar(
        title: const Text('투어 만들기',
            style: TextStyle(
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold,
                fontSize: 25)), // You can add title here
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 14, 99, 246)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent, //You can make this transparent
        elevation: 0.0, //No shadow
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            //upload photo
            InkWell(
              onTap: () {
                _imagePicker.pickImage(source: ImageSource.gallery).then(
                    ((value) {
                  pickedImage = value;

                  if (value?.path != null) {
                    final imgFile = File(value!.path);

                    _imagePicked.sink.add(imgFile);
                  }
                }), onError: (error) {
                  print("ONERROR -> $error");
                });
              },
              child: Container(
                height: 60,
                width: 60,
                margin: EdgeInsets.all(15),
                child: StreamBuilder<File>(
                    builder: (_, snapshot) {
                      final defaultIcon = Icon(Icons.camera);

                      print("object_imsage: ${snapshot.data}");

                      if (snapshot.hasData) {
                        return Image.file(
                          snapshot.requireData,
                          fit: BoxFit.cover,
                        );
                      } else {
                        if (snapshot.hasError) {
                          print("ERROR: ${snapshot.error}");
                        }
                        return defaultIcon;
                      }
                    },
                    stream: _imagePicked.stream),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    border: Border.all(color: Colors.blueGrey, width: 2)),
              ),
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
                    controller: _chosenTheme,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Chosen Theme',
                    ),
                  ),
                ),
              ),
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
                      hintText: 'Title',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

            //date and time
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextButton.icon(
                              onPressed: () {
                                _restorableRouteFuture.present();
                              },
                              icon: Icon(Icons.date_range_outlined),
                              label: Text(
                                  "${_selectedDateTime.value.day}/${_selectedDateTime.value.month}/${_selectedDateTime.value.year}"))),
                      Expanded(
                          child: TextButton.icon(
                              onPressed: () {
                                _selectedTime(context);
                              },
                              icon: Icon(Icons.punch_clock_outlined),
                              label: Text(_selectedTimeofDay == null
                                  ? "Select time"
                                  : "${_selectedTimeofDay?.hour}:${_selectedTimeofDay?.minute}")))
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),

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
                    '  participants: ',
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
                    controller: _startPlaceController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Start Place',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 25,
            ),
            //google maps
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 30,
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
                          builder: (context) => MapFrame(),
                        ),
                      ).then((pickedData) {
                        // Display in start place
                        _startPlaceController.text = "$pickedData";
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'Select location ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
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
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Description',
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: 30,
            ),
            //make theme button
            InkWell(
              onTap: () {
                final latLong = _kInitialPosition.target;
                ApiManager.getProfileDetail(username: widget.username)
                    .then((value) {
                  ApiManager.createTour(
                          TourRequest(
                              tourName: _titleController.text,
                              latitude: latLong.latitude,
                              longitude: latLong.longitude,
                              participants: _count,
                              startPlace: _startPlaceController.text,
                              description: _descriptionController.text,
                              themeId: widget.themeId,
                              profileId: value.id,
                              date:
                                  "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'T'${_selectedTimeofDay?.minute}:${_selectedTimeofDay?.hour}"),
                          pickedImage)
                      .then((value) {
                    print("BytesOfImage: $value");
                    showSnackbar(context, "Tour added successfully!");
                  }, onError: (error) {
                    print("BytesOfImage_error: $error");
                  });
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  height: 40,
                  padding: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 14, 99, 246),
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                      child: Text('투어 만들기',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  String? get restorationId => widget.chosenTheme;

  /*
tours
  */

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDateTime, "selected_date_res_id");
    registerForRestoration(_restorableRouteFuture, "date_picker_restoration");
  }

  void _selectedTime(BuildContext context) async {
    final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        onEntryModeChanged: ((time) {
          _selectedTimeStr = time.name;
        }),
        builder: (context, child) {
          return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!);
        });
    setState(() {
      _selectedTimeofDay = time;
    });
  }
}
