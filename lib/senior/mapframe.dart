import 'package:capstone/senior/location_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'location_controller.dart';

class MapFrame extends StatefulWidget {
  const MapFrame({Key? key}) : super(key: key);

  @override
  State<MapFrame> createState() => _MapFrameState();
}

class _MapFrameState extends State<MapFrame> {
  late CameraPosition _cameraPosition;
  final MarkerId _markerId = MarkerId("loc");

  LatLng? _newLatLng;

  List<Placemark>? placemarks;

  @override
  void initState() {
    super.initState();
    _cameraPosition =
        CameraPosition(target: LatLng(37.5051, 126.9571), zoom: 17);

    super.initState();
  }

  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
//_newLatLng

    return GetBuilder<LocationController>(builder: (LocationController) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (placemarks != null) {
              Navigator.of(context).pop("${placemarks?.first.name}");
            }
          },
          label: Text("Done"),
          icon: const Icon(Icons.place),
        ),
        appBar: AppBar(
          title: const Text('위치 선택'),
          backgroundColor: Color.fromARGB(255, 14, 99, 246),
        ),
        body: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: false,
              gestureRecognizers: {
                Factory<OneSequenceGestureRecognizer>(
                    () => TapGestureRecognizer())
              },
              onMapCreated: (GoogleMapController mapController) {
                _mapController = mapController;
              },
              onCameraMove: (position) {
                position.target;
                placemarkFromCoordinates(
                        position.target.latitude, position.target.longitude)
                    .then((value1) {
                  placemarks = value1;
                });
              },
              initialCameraPosition: _cameraPosition,
            ),
            Align(child: Image.asset(height: 40, "images/marker_map_icon.png"))
          ],
        ),
      );
    });
  }
}
