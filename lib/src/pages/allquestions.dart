import 'package:flutter/material.dart';
import '../helper/functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './view_ans.dart';

class allQuestions extends StatefulWidget {
  @override
  _allQuestionsState createState() => _allQuestionsState();
}

class _allQuestionsState extends State<allQuestions> {
  var url = "https://jsonplaceholder.typicode.com/photos";
  var trueurl =
      "https://n542hobffe.execute-api.us-east-1.amazonaws.com/list_all_questions";
  var data;
  var truedata;
  var name;
  num pnum;
  @override
  void initState() {
    super.initState();
    get_user();
    get_details();
    fetchData();
  }

  get_user() {
    localRead("name").then((nam) => {
          setState(() {
            print("user name: $nam");
            name = nam;
          })
        });
  }

  get_details() {
    localRead("phone_no").then((pnum) => {
          setState(() {
            print("phone num: $pnum");
            print("qwerty");
            print(pnum.runtimeType);
            print("zxcvb");
            pnum = pnum;
          })
        });
  }

  fetchData() async {
    var res = await http.get(url);
    var trueres = await http.get(trueurl);
    data = jsonDecode(res.body);
    truedata = jsonDecode(trueres.body);
    //print(truedata);
    //print(data.runtimeType);
    //print(truedata[0]["question"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (truedata != null)
        ? ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(truedata[index]["question"]),
                subtitle: Text(
                  "by ${truedata[index]["user_id"]}",
                  style: TextStyle(fontSize: 12),
                ),
                leading: Image.network(
                    "https://img.icons8.com/cotton/40/000000/person-male--v2.png"),
                onTap: () {
                  Navigator.pushNamed(context, viewAnswer.routeName,
                      arguments: truedata[index]);
                },
              );
            },
            itemCount: truedata.length,
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
