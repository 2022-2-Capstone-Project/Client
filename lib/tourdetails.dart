import 'package:flutter/material.dart';

class TourDetails extends StatefulWidget {
  @override
  _TourDetailsState createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('투어',
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
                  child: Center(child:Text("정문에서 후문까지 편하게 가는법!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
              background: Image.asset("/Users/syaffa255/StudioProjects/capstoneproject/lib/puang.jpeg",
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile (
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Text('S'),
              ),
              title: Text('성원, 소프트웨어학과, 4학년', style: TextStyle(fontSize: 13),),
            ),
          ),
          SliverToBoxAdapter(
              child: Text('테마 : 학교', style: TextStyle(fontSize: 16, height: 3),textAlign: TextAlign.center,)
          ),
          SliverToBoxAdapter(
              child: Text('예상 소요 시간: 2시간', style: TextStyle(fontSize: 15, height: 3),textAlign: TextAlign.center,)
          ),
          SliverToBoxAdapter(
              child: Text('장소: 중앙대학교 정문', style: TextStyle(fontSize: 15, height: 3),textAlign: TextAlign.center,)
          ),
          SliverToBoxAdapter(
              child: Text('게시일시 : 10분전', style: TextStyle(fontSize: 15, height: 3),textAlign: TextAlign.center,)
          ),
          SliverToBoxAdapter(
              child: Text('설명서:', style: TextStyle(fontSize: 15, height: 3),textAlign: TextAlign.center,)
          ),
          SliverToBoxAdapter(
              child: Text('새내기들과 친해지고 싶은 16학번입니다~ 우리 학교가 언덕이 좀 심하죠? 편하게 갈 수 잇는 방법 알려드려요! 부담 갖지 말고 연락주세요! *밥도 사드려요', textAlign: TextAlign.center,style: TextStyle(height: 3),)
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
                children: <Widget>[Icon(Icons.favorite, color: Colors.red)],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                color: Colors.blueAccent,
                child: Text("신청하기", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );


  }
}