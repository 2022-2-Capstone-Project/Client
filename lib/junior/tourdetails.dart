import 'package:capstone/tour_model.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../api_manager.dart';
import '../senior/navigation_bar.dart';

class TourDetails extends StatefulWidget {
  final TourModel tour;
  TourDetails(this.tour);
  @override
  _TourDetailsState createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final date = widget.tour.created?.split("T");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('투어',
            style: TextStyle(
                fontSize: 30,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.share,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              // do something
            },
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 60,
            flexibleSpace: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .5,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage('${widget.tour.thumbnail}'),
                      fit: BoxFit.cover)),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Icon(Icons.account_circle),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text('${widget.tour.authorName}'),
                            //Text('${widget.tour.followers} followers'),
                            Text('0 followers'),
                          ],
                        ),
                        SizedBox(
                          width: 150,
                        ),
                        Row(
                          children: [Text('0'), Text(" 점")],
                        )
                      ],
                    ),
                  ),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  )),
            ),
            pinned: true,
            backgroundColor: Color.fromARGB(255, 14, 99, 246),
            expandedHeight: 300,
          ),
          SliverToBoxAdapter(
              child: Text(
            '${widget.tour.tourName}',
            textAlign: TextAlign.center,
            style:
                TextStyle(height: 2, fontSize: 30, fontWeight: FontWeight.bold),
          )),
          SliverToBoxAdapter(
              child: Text(
            'Theme: ${widget.tour.title}',
            textAlign: TextAlign.center,
            style:
                TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
          )),
          SliverToBoxAdapter(
              child: Container(
            margin: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Created date : ${date?.first}',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 2, fontSize: 15),
                ),
                Text(
                  'Date and Time : ${widget.tour.date}',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 2, fontSize: 15),
                ),
              ],
            ),
          )),
          SliverToBoxAdapter(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Description:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.tour.description}' ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(height: 3, fontSize: 20),
              ),
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Start Place: ${widget.tour.start_place}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .8,
                        height: 300,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(widget.tour.latitude!,
                                  widget.tour.longitude!),
                              zoom: 10),
                          markers: {
                            Marker(
                                markerId: const MarkerId('start'),
                                position: LatLng(widget.tour.latitude!,
                                    widget.tour.longitude!))
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),

          // start place (map showing the lat and long of the place)
        ],
      ),
      bottomNavigationBar: FutureBuilder<bool?>(
        builder: ((context, snapshot) {
          final isSenior = snapshot.data == true;
          final isHideNavBar =
              LocationController.get.userId == null || isSenior;
          return isHideNavBar
              ? Container(
                  height: 0,
                  width: 0,
                )
              : Container(
                  height: 56,
                  margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 66,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.favorite, color: Colors.red),
                          ],
                        ),
                      ),
                      Text("1/${widget.tour.participants} Participants",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.blueAccent,
                          child: GestureDetector(
                            onTap: () {
                              ApiManager.updateApplicationTour().then((value) {
                                showSnackbar(
                                    context, "Participant added successfully!");
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConfirmRegPage(),
                                  ),
                                );*/
                              });
                            },
                            child: Text("신청하기",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        }),
        future: ApiManager.isSenior(),
      ),
    );
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
}
