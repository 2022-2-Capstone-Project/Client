import 'package:capstone/api_manager.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/makethemepage.dart';
import 'package:capstone/senior/maketourpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../theme_model.dart';

class ThemeDetails extends StatefulWidget {
  late ThemeModel themeModel;

  ThemeDetails(this.themeModel);

  @override
  _ThemeDetailsState createState() => _ThemeDetailsState();
}

class _ThemeDetailsState extends State<ThemeDetails> {
  bool ispreimun = false;

  @override
  void initState() {
    ispreimun = widget.themeModel.premium;
    if (ispreimun == true)
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showDialoge(context));
    super.initState();
  }

  void showDialoge(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("This theme is premium"),
        content: const Text("To open it 100 points will be deducted"),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: Colors.grey,
              padding: const EdgeInsets.all(14),
              child: const Text("cancel",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Container(
              color: Colors.grey,
              padding: const EdgeInsets.all(14),
              child: const Text("confirm",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeModel model = widget.themeModel;

    Size size = MediaQuery.of(context).size;
    final thumbnail = model.thumbnail;

    final startLocationLatLng = LatLng(model.lat, model.long);
    final markerId = MarkerId("${model.url}");
    final marker = Marker(
        position: startLocationLatLng,
        markerId: markerId,
        infoWindow: InfoWindow(title: model.startPlace));

    final format = DateFormat("yyyy-MM-d");
    final date = model.created?.split("T");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('??????',
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 14, 99, 246),
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.share,
                color: Color.fromARGB(255, 14, 99, 246),
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
                              Text("${model.nickname}"),
                              Text("${model.followers} followers"),
                            ],
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          Row(
                            children: [Text("${model.rating}"), Text("???")],
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
              flexibleSpace: FlexibleSpaceBar(
                background: thumbnail == null
                    ? Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        child: const Icon(Icons.image),
                      )
                    : Image.network(
                        thumbnail,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            SliverToBoxAdapter(
                child: Text(
              '${model.title}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 2, fontSize: 30, fontWeight: FontWeight.bold),
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
                    '?????? ???: ${date?.first}',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 2, fontSize: 15),
                  ),
                  Text(
                    '?????? ?????? ??????: ${model.estimated} ???',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 2, fontSize: 15),
                  ),
                  Text(
                    '????????? ???: ${model.participants} ???',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 2, fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )),
            SliverToBoxAdapter(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "??????:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  model.description ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 3, fontSize: 20),
                ),
                Container(
                  height: 400,
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        "?????? ??????: ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                      Center(
                          child: Text(
                        "${model.startPlace}",
                        style: TextStyle(fontSize: 20, height: 3),
                      )),
                      Expanded(
                          child: GoogleMap(
                              markers: {marker},
                              initialCameraPosition: CameraPosition(
                                  target: startLocationLatLng, zoom: 15))),
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
                LocationController.get.userId == null || !isSenior;
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
                              Icon(Icons.bookmark_add_outlined,
                                  color: Colors.black)
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            color: Color.fromARGB(255, 14, 99, 246),
                            child: GestureDetector(
                              onTap: () {
                                //http://127.0.0.1:8000/tour-themes/19/
                                final themeIdUrls = model.url?.split("/");
                                print(
                                    "themeID: $themeIdUrls - ${model.author} \n ${themeIdUrls?[4]}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MakeTourPage(
                                        chosenTheme: model.title,
                                        username: model.author ?? "",
                                        themeId:
                                            int.tryParse("${themeIdUrls?[4]}")),
                                  ),
                                );
                              },
                              child: Text("?????? ?????????",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          }),
          future: ApiManager.isSenior(),
        ));
  }
}
