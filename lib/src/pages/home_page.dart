import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/helper/quad_clipper.dart';
import 'package:flutter_smart_course/src/helper/articleModel.dart';
import 'package:flutter_smart_course/src/pages/article.dart';
import 'package:flutter_smart_course/src/pages/recomended_page.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import "dart:math";
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart';

import 'drawer.dart';
import 'article.dart';
import 'notifications.dart';
import '../helper/functions.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // HomePage({Key key}) : super(key: key);

  double width;
  var categories = [];
  var categoryArticles = [];

  // _HomePageState() {
  //   getCategories().then((value) => setState(() {
  //         categories = value;
  //       }));
  // }

  final decorationList = ['a', 'b', 'c', 'd', 'e', 'f'];
  final _random = new Random();

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      child: Container(
          height: 70,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.purple,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 30,
                  right: -100,
                  child: _circularContainer(300, LightColor.lightpurple)),
              Positioned(
                  top: -100,
                  left: -45,
                  child: _circularContainer(width * .5, LightColor.darkpurple)),
              Positioned(
                  top: -180,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 20,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.toc,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Search here...",
                                style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30,
                              )
                            ],
                          ),
                          SizedBox(height: 0),
                        ],
                      )))
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _categoryRow(
    String title,
    Color primary,
    Color textColor,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: LightColor.titleTextColor, fontWeight: FontWeight.bold),
          ),
          _chip("See all", primary)
        ],
      ),
    );
  }

  Widget _featuredRowA(context, String category) {
    getCategoryArticles(category);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            for (var index = 0; index < ArticleList.list.length; index++)
              InkWell(
                onTap: () {
                  print('clicked card iterable $index');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Article(ArticleList.list[index])),
                  );
                },
                child: _card(
                  primary: (index == 0) ? LightColor.orange : Colors.white,
                  backWidget: (index == 0)
                      ? _decorationContainerA(LightColor.lightOrange, 50, -30)
                      : _decorationContainerRandomise(),
                  chipColor: LightColor.orange,
                  model: ArticleList.list[index],
                  isPrimaryCard: (index == 0) ? true : false,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _featuredRowB() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            _card(
              primary: LightColor.seeBlue,
              chipColor: LightColor.seeBlue,
              backWidget: _decorationContainerD(
                  LightColor.darkseeBlue, -100, -65,
                  secondary: LightColor.lightseeBlue,
                  secondaryAccent: LightColor.seeBlue),
              model: ArticleList.list[0],
              isPrimaryCard: true,
            ),
            _card(
              primary: Colors.white,
              chipColor: LightColor.lightpurple,
              backWidget: _decorationContainerE(
                LightColor.lightpurple,
                90,
                -40,
                secondary: LightColor.lightseeBlue,
              ),
              model: ArticleList.list[1],
            ),
            _card(
              primary: Colors.white,
              chipColor: LightColor.lightOrange,
              backWidget: _decorationContainerF(
                  LightColor.lightOrange, LightColor.orange, 50, -30),
              model: ArticleList.list[2],
            ),
            _card(
              primary: Colors.white,
              chipColor: LightColor.seeBlue,
              backWidget: _decorationContainerA(
                LightColor.yellow,
                -70,
                30,
              ),
              model: ArticleList.list[0],
            ),
          ],
        ),
      ),
    );
  }

  Widget _card(
      {BuildContext context,
      Color primary = Colors.redAccent,
      ArticleModel model,
      String chipText2 = '',
      Widget backWidget,
      Color chipColor = LightColor.orange,
      bool isPrimaryCard = false}) {
    return Container(
      height: 180,
      width: width * .32,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: primary.withAlpha(200),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              offset: Offset(0, 20),
              blurRadius: 10,
              color: LightColor.lightpurple.withAlpha(20))
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          child: Stack(
            children: <Widget>[
              backWidget,
              Positioned(
                bottom: 20,
                left: 10,
                child: _cardInfo(model.title, chipText2,
                    LightColor.titleTextColor, chipColor,
                    isPrimaryCard: isPrimaryCard),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _cardInfo(String title, String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          // SizedBox(height: 5),
          //_chip(courses, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  Widget _decorationContainerRandomise() {
    var item = decorationList[_random.nextInt(decorationList.length)];
    if (item == 'a') return _decorationContainerA(LightColor.yellow, -70, 30);
    if (item == 'b') return _decorationContainerB(Colors.white, 90, -40);
    if (item == 'c') return _decorationContainerC(Colors.white, 50, -30);
    if (item == 'd')
      return _decorationContainerD(Colors.white, -100, -65,
          secondary: LightColor.lightseeBlue,
          secondaryAccent: LightColor.seeBlue);
    if (item == 'e')
      return _decorationContainerE(
        LightColor.lightpurple,
        90,
        -40,
        secondary: LightColor.lightseeBlue,
      );
    if (item == 'f')
      return _decorationContainerF(
          LightColor.lightOrange, LightColor.orange, 50, -30);
  }

  Widget _decorationContainerA(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: primary.withAlpha(255),
          ),
        ),
        _smallContainer(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerB(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
    );
  }

  Widget _decorationContainerC(Color primary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        _smallContainer(
          LightColor.yellow,
          35,
          70,
        )
      ],
    );
  }

  Widget _decorationContainerD(Color primary, double top, double left,
      {Color secondary, Color secondaryAccent}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        _smallContainer(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
    );
  }

  Widget _decorationContainerE(Color primary, double top, double left,
      {Color secondary}) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: primary.withAlpha(100),
          ),
        ),
        Positioned(
            top: 40,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: primary, radius: 40))),
        Positioned(
            top: 45,
            right: -50,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(backgroundColor: secondary, radius: 50))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Widget _decorationContainerF(
      Color primary, Color secondary, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: 25,
            right: -20,
            child: RotatedBox(
              quarterTurns: 1,
              child: ClipRect(
                  clipper: QuadClipper(),
                  child: CircleAvatar(
                      backgroundColor: primary.withAlpha(100), radius: 50)),
            )),
        Positioned(
            top: 34,
            right: -8,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
        _smallContainer(LightColor.yellow, 15, 90, radius: 5)
      ],
    );
  }

  Positioned _smallContainer(Color primary, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primary.withAlpha(255),
        ));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  Future<void> getCategoryArticles(category) async {
    final url = 'https://aszhzax9c3.execute-api.us-east-1.amazonaws.com/test/';
    final headers = {'Content-Type': 'application/json'};
    // print(category);
    Map<String, dynamic> body = {"category": category};
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    var resp = jsonDecode(response.body);
    if (resp["statusCode"] == 200) {
      // Comment -> resp["body"].length > 1000   ???
      // for (var i = 0; i < resp["body"].length; i++ ) {
      //   print(resp["body"][i]);
      // }
      setState(() {
        categoryArticles = resp["body"];
      });
      print(categoryArticles);
    }
  }

  Future<void> getCategories() async {
    final url = 'https://evgl7agfd8.execute-api.us-east-1.amazonaws.com/test/';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {};
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    var resp = jsonDecode(response.body);
    if (resp["statusCode"] == 200) {
      // print(resp["body"]);
      // for (var category in resp["body"]) {
      //   getCategoryArticles(category);
      // }
      setState(() {
        categories = resp["body"];
      });
      print("catgories $categories");
    }
  }

  @override
  void initState() {
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    // int _currentNav = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("WellBe"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            color: Colors.white,
          )
        ],
      ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentNav,
//         showSelectedLabels: false,
//         showUnselectedLabels: false,
//         selectedItemColor: LightColor.purple,
//         unselectedItemColor: Colors.grey.shade300,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           _bottomIcons(Icons.home),
//           _bottomIcons(Icons.star_border),
//           _bottomIcons(Icons.book),
//           _bottomIcons(Icons.person),
//         ],
//         onTap: (index) {
//            setState(() {
//              _currentNav =  index;
//            });
//           Navigator.pushReplacement(
//               context, MaterialPageRoute(builder: (context) => Article()));
//         },
//       ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // _header(context),
              SizedBox(height: 20),
              for (var category in categories)
                Column(children: <Widget>[
                  _categoryRow(category, LightColor.orange, LightColor.orange),
                  _featuredRowA(context, category)
                ]),
              _categoryRow("Asthma", LightColor.orange, LightColor.orange),
              // _featuredRowA(context),
              SizedBox(height: 0),
              _categoryRow(
                  "Diabetes", LightColor.purple, LightColor.darkpurple),
              _featuredRowB()
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
