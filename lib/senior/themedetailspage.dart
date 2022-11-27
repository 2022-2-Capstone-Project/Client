import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/makethemepage.dart';
import 'package:capstone/senior/maketourpage.dart';
import 'package:flutter/material.dart';

import '../theme_model.dart';

class ThemeDetails extends StatefulWidget {
  late ThemeModel themeModel;

  ThemeDetails(this.themeModel);

  @override
  _ThemeDetailsState createState() => _ThemeDetailsState();
}

class _ThemeDetailsState extends State<ThemeDetails> {
  @override
  Widget build(BuildContext context) {
    ThemeModel model = widget.themeModel;

    Size size = MediaQuery.of(context).size;
    final thumbnail = model.thumbnail;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('테마',
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
                          backgroundColor: Colors.green,
                          child: Text('S'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Text("${model.author}"),
                            Text("${model.followers} followers"),
                          ],
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Column(
                          children: [
                            Text("${model.rating}"),
                          ],
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
            style: TextStyle(height: 3, fontSize: 20),
          )),
          SliverToBoxAdapter(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '${model.created}',
                textAlign: TextAlign.center,
                style: TextStyle(height: 3),
              ),
              Text(
                '${model.estimated}',
                textAlign: TextAlign.center,
                style: TextStyle(height: 3),
              ),
              Text(
                '${model.participants}',
                textAlign: TextAlign.center,
                style: TextStyle(height: 3),
              ),
            ],
          )),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Text("설명:"),
              Text(
                model.description ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(height: 3),
              ),
            ],
          )),

          // start place (map showing the lat and long of the place)
        ],
      ),
      bottomNavigationBar: LocationController.get.userId == null
          ? null
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
                        Icon(Icons.bookmark, color: Colors.black)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      color: Color.fromARGB(255, 14, 99, 246),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MakeTourPage(),
                            ),
                          );
                        },
                        child: Text("투어 만들기",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
