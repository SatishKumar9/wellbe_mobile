import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../helper/functions.dart';

import './allquestions.dart';
import './myquestions.dart';
import './bookmarks.dart';
import './drawer.dart';
import './ask.dart';
import 'dart:convert';
import './view_ans.dart';

class questionsPage extends StatefulWidget {
  static const String routeName = "/questions";
  @override
  _questionsPageState createState() => _questionsPageState();
}

class _questionsPageState extends State<questionsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.grey[180],
        appBar: AppBar(
          title: Text("Q/A Forum"),
          bottom: TabBar(tabs: <Widget>[
            Tab(text: 'All'),
            Tab(text: 'My Questions'),
            Tab(text: 'My Bookmarks'),
          ]),
        ),
        body: TabBarView(
          children: <Widget>[
            allQuestions(),
            myQuestions(),
            bookmarkedQuestions()
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, FormCardWidget.routeName);
            },
            child: Text(
              "ASK",
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
        drawer: AppDrawer(),
      ),
    );
  }
}
