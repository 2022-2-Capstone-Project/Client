import 'package:capstone/api_manager.dart';
import 'package:capstone/senior/location_controller.dart';
import 'package:capstone/senior/makethemepage.dart';
import 'package:capstone/senior/themedetailspage.dart';
import 'package:capstone/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme_model.dart';

class ThemePage extends StatefulWidget {
  late ThemeModel themeModel;

  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  void initState() {
    ApiManager.getThemes().then((value) {
      print("${value.first.title} ${value.first.toJson()}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("yyyy-MM-d");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('테마 목록',
              style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 14, 99, 246),
                  fontWeight: FontWeight.bold)),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color.fromARGB(255, 14, 99, 246),
                size: 30,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<ThemeModel>>(
            builder: ((context, snapshot) {
              if (snapshot.data == null && snapshot.error == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text("${snapshot.error}"),
                );
              }

              final themeList = snapshot.data;

              if (themeList?.isEmpty == true) {
                return const Center(
                  child: Text("Empty Themes"),
                );
              }

              return ListView.builder(
                  itemCount: themeList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final data = themeList![index];
                    return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        // height: 150,
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (settings) => ThemeDetails(data)));
                          }),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(70)),
                                  child: data.thumbnail == null
                                      ? Container(
                                          color: Theme.of(context).primaryColor,
                                          child: const Icon(
                                            Icons.image,
                                            color: Colors.white,
                                            size: 60,
                                          ),
                                        )
                                      : Image.network(
                                          data.thumbnail!,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(' ${data.title}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                          '${data.nickname},${data.created}에 올림',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14)),
                                      Row(
                                        children: [
                                          Text('${data.participants}명,',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 14)),
                                          Text(
                                            '${data.startPlace}, ',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      new Text(
                                        ' 예상 소요 시간 : ${data.estimated} 분',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ));
                  });
            }),
            future: ApiManager.getThemes(),
          ),
        ),
        floatingActionButton: LocationController.get.userId == null
            ? null
            : FloatingActionButton.extended(
                heroTag: "make theme",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MakeThemePage(),
                      ));
                },
                label: const Text('테마 만들기'),
                icon: Icon(Icons.add),
                backgroundColor: Color.fromARGB(255, 14, 99, 246),
              ),
      ),
    );
  }
}
