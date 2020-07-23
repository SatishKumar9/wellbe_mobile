import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'home_page.dart';
import 'drawer.dart';
import '../helper/functions.dart';

class UserDonateRequest extends StatefulWidget {
  @override
  _UserDonateRequestState createState() => _UserDonateRequestState();
}

class _UserDonateRequestState extends State<UserDonateRequest> {
  String phone_no = "";
  TextEditingController _name = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _reason = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getUser() {
    localRead("phone_no").then((phone) => {
          setState(() {
            print("phone number: $phone");
            phone_no = phone;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> raiseFund() async {
    final uri = 'https://4yce3motwc.execute-api.us-east-1.amazonaws.com/test';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "name": _name.text,
      "description": _desc.text,
      "reason": _reason.text,
      "phone_no": phone_no
    };
    Response response = await post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Request Succesful!"),
          content: new Text(
              "For further verification, you will be contacted with your registered phone number by our team. Please make sure you have all the information required for the same."),
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: new Text("Close"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Fundraiser"),
      ),
      body: SafeArea(
        child: new Container(
          child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 34.0),
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(
                  "Fundraiser",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    // color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                new TextFormField(
                  controller: _name,
                  // style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Name for a fundraiser";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Fundraiser Name",
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                new TextFormField(
                  controller: _desc,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  // style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Description is empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Description",
                    filled: true,
                    // labelStyle: TextStyle(
                    //   color: Colors.white,
                    // ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                new TextFormField(
                  controller: _reason,
                  // style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Reason";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Reason",
                    filled: true,
                    // labelStyle: TextStyle(
                    //   color: Colors.white,
                    // ),
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "Request",
                        style: TextStyle(
                          color: Colors.white,
                          // fontSize: 18.0,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
                      onPressed: () {
                        raiseFund();
                      },
                      // borderSide: BorderSide(color: Colors.white),
                      // shape: StadiumBorder(),
                      color: Colors.blue,
                    )
                  ],
                  alignment: MainAxisAlignment.center,
                )
              ],
            ),
            autovalidate: true,
          ),
        ),
      ),
    );
  }
}
