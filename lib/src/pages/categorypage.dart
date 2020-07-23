import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/helper/quad_clipper.dart';
import 'package:flutter_smart_course/src/pages/googlemap.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:flutter_smart_course/src/theme/theme.dart';

import 'dart:convert';
import 'package:http/http.dart';

import 'googlemap.dart';
import 'article.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  CategoryPage(this.category);

  @override
  CategoryPageState createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  var categoryArticles = [];
  double width;

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      child: Container(
        height: 73,
        width: width,
        decoration: BoxDecoration(
          color: LightColor.orange,
        ),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
                top: 10,
                right: -120,
                child: _circularContainer(300, LightColor.lightOrange2)),
            Positioned(
                top: -60,
                left: -65,
                child: _circularContainer(width * .5, LightColor.darkOrange)),
            Positioned(
                top: -230,
                right: -30,
                child: _circularContainer(width * .7, Colors.transparent,
                    borderColor: Colors.white38)),
            Positioned(
              top: 30,
              left: 0,
              child: Container(
                width: width,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: <Widget>[
                    Icon(
                      Icons.keyboard_arrow_left,
                      color: Colors.white,
                      size: 30,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Articles",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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

  Widget _articlesList(List categoryArticles) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            for (var index = 0; index < categoryArticles.length; index++)
              InkWell(
                onTap: () {
                  print('clicked card iterable $index');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Article(categoryArticles[index])),
                  );
                },
                child: Column(
                  children: <Widget>[
                    _courceInfo(
                        categoryArticles[index], _getDecorationContainer(index),
                        background: (index % 3 == 0)
                            ? LightColor.seeBlue
                            : (index % 3 == 1)
                                ? LightColor.darkOrange
                                : LightColor.lightOrange2),
                    Divider(
                      thickness: 1,
                      endIndent: 20,
                      indent: 20,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _getDecorationContainer(int index) {
    if (index % 3 == 0) {
      return _decorationContainerA(Colors.redAccent, -110, -85);
    } else if (index % 3 == 1) {
      return _decorationContainerB();
    } else if (index % 3 == 2) {
      return _decorationContainerC();
    }
  }

  Widget _card(
      {Color primaryColor = Colors.redAccent,
      String imgPath,
      Widget backWidget}) {
    return Container(
        height: 190,
        width: width * .34,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: Color(0x12000000))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: backWidget,
        ));
  }

  Widget _courceInfo(Map article, Widget decoration, {Color background}) {
    return Container(
        height: 170,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: _card(primaryColor: background, backWidget: decoration),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(article["title"],
                            style: TextStyle(
                                color: LightColor.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: background,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    article["intro"],
                    style: AppTheme.h6Style.copyWith(
                        fontSize: 12, color: LightColor.extraDarkPurple),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    _chip(article["tags"], LightColor.darkpurple, height: 5),
                    SizedBox(
                      width: 10,
                    ),
                    //_chip(model.tag2, LightColor.seeBlue, height: 5),
                  ],
                )
              ],
            ))
          ],
        ));
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

  Widget _decorationContainerA(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        _smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
                CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _decorationContainerB() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(
                radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child:
                CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circularContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _decorationContainerC() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        _smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  Widget _mapSection(String category) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          print('clicked maps');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GooglemapPage(category)),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(7)),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 15, color: Colors.black12)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Image.network(
                  'https://img.icons8.com/color/30/000000/map-pin.png'),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Looking for a doctor?',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Click to view nearby hospitals around you')
                ],
              ),
              Image.network(
                  'https://img.icons8.com/color/35/000000/google-maps-new.png')
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getCategoryArticles(category) async {
    final url = 'https://06wt2jhm21.execute-api.us-east-1.amazonaws.com/test';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"bodypart": category};
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    var resp = jsonDecode(response.body);
    if (resp["statusCode"] == 200) {
      setState(() {
        categoryArticles = resp["body"];
      });
      // print(categoryArticles);
      // print(categoryArticles.length);
    }
  }

  @override
  void initState() {
    getCategoryArticles(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: (categoryArticles.length == 0)
              ? Column(children: <Widget>[
                  _header(context),
                  Center(
                    heightFactor: 15,
                    child: CircularProgressIndicator(),
                  )
                ])
              : Column(
                  children: <Widget>[
                    _header(context),
                    _mapSection(widget.category),
                    _articlesList(categoryArticles)
                  ],
                ),
        ),
      ),
    );
  }
}
