import 'package:flutter/material.dart';
import '../helper/functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './view_ans.dart';

class myQuestions extends StatefulWidget {
  @override
  _myQuestionsState createState() => _myQuestionsState();
}

class _myQuestionsState extends State<myQuestions> {
  var url = "https://jsonplaceholder.typicode.com/photos";
  String pnumber = '';
  var respdata;
  var data;

  @override
  void initState() {
    super.initState();
    get_details();
  }

  get_details() {
    localRead("phone_no").then((pnum) => {
          setState(() {
            pnumber = pnum;
            // print(pnumber.runtimeType);
          }),
          get_my_questions(pnum),
          fetchData()
        });
  }

  get_my_questions(String pnumber) async {
    final Map<String, dynamic> QuestionData = {
      "user_id": pnumber,
    };
    print("ead $pnumber");
    http
        .post(
            'https://fbesm7kxc5.execute-api.us-east-1.amazonaws.com/list_my_questions',
            headers: {'Content-Type': 'application/json'},
            body: json.encode(QuestionData))
        .then((http.Response resp) {
      // respdata = json.decode(resp.body);
      setState(() {
        respdata = json.decode(resp.body);
      });
      // print(respdata);
    });
  }

  fetchData() async {
    var res = await http.get(url);
    data = jsonDecode(res.body);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (respdata != null)
        ? ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(respdata[index]["question"]),
                subtitle: Text(""),
                leading: Image.network(
                    "https://img.icons8.com/cotton/40/000000/person-male--v2.png"),
                onTap: () {
                  Navigator.pushNamed(context, viewAnswer.routeName,
                      arguments: respdata[index]);
                },
              );
            },
            itemCount: respdata.length,
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
