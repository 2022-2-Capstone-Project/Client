import 'package:capstone/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TourGoingOn extends StatefulWidget {
  const TourGoingOn({super.key});

  @override
  State<TourGoingOn> createState() => _TourGoingOnState();
}

class _TourGoingOnState extends State<TourGoingOn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('투어 진행',
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 14, 99, 246),
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 14, 99, 246)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Text(
                  '투어 장소에 있을때,',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  '"투어 시작" 버튼을 눌러주세요',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 25,
                ),
                /*Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                        child: Text(
                      '${widget.themeModel.description}',
                      style: TextStyle(fontSize: 15),
                    ))), */
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Map : ',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .8,
                    height: 300,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(37.5051, 126.9571), zoom: 10),
                      markers: {
                        Marker(
                            markerId: const MarkerId('start'),
                            position: LatLng(37.5051, 126.9571))
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Text("2 Participants",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blueAccent,
                child: Text("투어 시작",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
