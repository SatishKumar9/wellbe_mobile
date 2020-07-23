import './questions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/functions.dart';

class FormCardWidget extends StatefulWidget {
  // const FormCardWidget({
  //   Key key,
  // }) : super(key: key);
  static const String routeName = "/askq";

  @override
  _FormCardWidgetState createState() => _FormCardWidgetState();
}

class _FormCardWidgetState extends State<FormCardWidget> {
  String question = '';
  var name;
  String pnumber = '';
  //num number;

  @override
  void initState() {
    super.initState();
    get_user();
    get_details();
    //fetchData();
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
            // print("aws");
            // print(pnum.runtimeType);
            //num number = num.parse(pnum);
            pnumber = pnum;
            print("asdfgh");
            print(pnumber.runtimeType);
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Us'),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Expanded(
            child: Column(
              children: <Widget>[
                Text("Post your Question",
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                Text(
                    "Team WellBe tries to answer your question as earliest as possible. You can always check the status in 'My questions' page."),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 8,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Enter Question"),
                    onChanged: (String value) {
                      question = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                RaisedButton(
                  onPressed: () {
                    //print(question);
                    // ____________________POST DATA__________________________________
                    final Map<String, dynamic> QuestionData = {
                      'question': question,
                      'user_id': pnumber,
                    };
                    http
                        .post(
                            'https://q4llznnws8.execute-api.us-east-1.amazonaws.com/create_question',
                            body: json.encode(QuestionData))
                        .then((http.Response resp) {
                      final Map<String, dynamic> respdata =
                          json.decode(resp.body);
                      print(respdata); //Not really necessary
                    });

                    //formkey.currentState.validate();
                    // Constants.prefs.setBool("loggedIn",true);

                    // Navigator.push(context,MaterialPageRoute(builder: (context)=>homePage()));
                    Navigator.pushNamed(context, questionsPage.routeName);
                  },
                  child: Text("Ask"),
                  color: Colors.blue,
                  textColor: Colors.white,
                )
              ],
            ),
          )),
    );
  }
}
