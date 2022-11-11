import 'package:capstone/senior/location_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _cameraPosition =
        CameraPosition(target: LatLng(45.521563, -122.677433), zoom: 17);
  }

  late GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (LocationController) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          backgroundColor: Colors.green,
        ),
        body: Stack(
          children: [
            GoogleMap(
                onMapCreated: (GoogleMapController mapController) {
                  _mapController = mapController;
                },
                initialCameraPosition: _cameraPosition),
            Positioned(
              top: 100,
              left: 10,
              right: 20,
              child: GestureDetector(
                onTap: () => Get.dialog(LocationSearchDialog(
                  mapController: _mapController,
                )),
                child: Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 25,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          '${LocationController.pickPlaceMark.name ?? ''}'
                          '${LocationController.pickPlaceMark.locality ?? ''}'
                          '${LocationController.pickPlaceMark.postalCode ?? ''}'
                          '${LocationController.pickPlaceMark.country ?? ''}',
                          style: TextStyle(fontSize: 20),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.search,
                          size: 25,
                          color: Theme.of(context).textTheme.bodyText1!.color),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
