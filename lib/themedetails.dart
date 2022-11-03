import 'package:flutter/material.dart';

class ThemeDetails extends StatefulWidget {
  @override
  _ThemeDetailsState createState() => _ThemeDetailsState();
}

class _ThemeDetailsState extends State<ThemeDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('테마',
            style: TextStyle(fontSize: 30, color: Colors.blueAccent, fontWeight: FontWeight.bold)),
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
      body:
      CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 60,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                  child: Center(child:Text("학교", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  )
              ),),
            pinned: true,
            backgroundColor: Colors.blueAccent,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("/Users/syaffa255/StudioProjects/capstoneproject/lib/cau.jpeg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Text('학교에 대해 잘 알고 계시고 다른 학생들에게 알려주고 싶으면 이 학교 투어를 만들어 보세요~! 투어 시키면서 새로운 친구들과 친해질 수 있는 기회 놓치지 마세요! 나만의 알고 있는 정보들도 다른 학생들에게 공유해보세요', textAlign: TextAlign.center,style: TextStyle(height: 3),)
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('/Users/syaffa255/StudioProjects/capstoneproject/lib/caumap.png'),
                  fit: BoxFit.fill,
                ),
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 56,
        margin: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Row(
          children: <Widget>[
            Container(
              width: 66,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[Icon(Icons.bookmark, color: Colors.black)],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blueAccent,
                child: Text("투어 만들기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );


  }
}