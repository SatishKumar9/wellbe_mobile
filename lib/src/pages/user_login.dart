import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/pages/home_page.dart';
import '../helper/functions.dart';
import 'package:http/http.dart';
// import 'main.dart';
import 'drawer.dart';
import 'user_reg.dart';

class UserLoginPage extends StatefulWidget {
  @override
  _UserLoginPageState createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  String phone_no = "";
  String otp = "";
  int otp_status;
  bool error = false;
  String error_msg = "";
  TextEditingController _phoneNoChannge = TextEditingController();
  TextEditingController _otpChannge = TextEditingController();
  bool en_otp = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<void> sendOtpUser(String phone_no) async {
    final uri = 'https://pc23lexkok.execute-api.us-east-1.amazonaws.com/test';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "phone_no": phone_no,
    };
    Response response = await post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    var resp = jsonDecode(response.body);
    print(resp);
  }

  Future<int> _VerifyOtp() async {
    print("phone is $phone_no");
    print("otp is $otp");

    final uri = 'https://puqzulg5l3.execute-api.us-east-1.amazonaws.com/test';
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"phone_no": phone_no, "otp": otp};
    Response response = await post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );

    var resp = jsonDecode(response.body);
    // int statusCode = resp["statusCode"];
    int responseBody = resp["result"];
    print("response: $resp");

    if (responseBody == 1) {
      String _token = resp["token"];
      String _name = resp["name"];
      print("login successful");
      print("name is $_name");
      print("phone_no is $phone_no");
      print("token is $_token");
      // String _token = "WeLc4qHz3xZtoHggl_P9zzM7cv6osGk2cTrjz3gUTrU";
      localWrite("name", _name);
      localWrite("phone_no", phone_no);
      localWrite("token", _token);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("Login Success"),
              content: new Text("Your Login was successful"),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => HomePage()));
                    },
                    child: new Text(
                      "Close",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ))
              ],
            );
          });
    } else if (responseBody == 0) {
      setState(() {
        error = true;
        error_msg = "Incorrect OTP";
      });
    } else if (responseBody == -1) {
      print("NO user registered");
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              title: new Text("No User "),
              content: new Text(
                  "You need to register this number for usage of our servies."),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) =>
                                  UserRegistrationPage(phone_no)));
                    },
                    child: new Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ))
              ],
            );
          });
    }
    print(responseBody);
    return responseBody;
  }

  @override
  Widget build(BuildContext context) {
    bool _otpvalid = true, _phvalid = true;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("WellBe"),
      ),
      drawer: AppDrawer(),
      body: SafeArea(
        child: new Container(
          child: new Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 100.0),
                Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                  ),
                ),
                new TextFormField(
                  controller: _phoneNoChannge,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value.isEmpty ||
                        (int.tryParse(value) == null) ||
                        (value.length != 10)) {
                      return "Invalid Phone Number";
                    }
                    en_otp = true;
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Phone Number",
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                new ButtonBar(
                  children: <Widget>[
                    new OutlineButton(
                      child: Text(
                        "Send OTP",
                        style: TextStyle(color: Colors.white),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
                      highlightColor: Colors.white,
                      onPressed: () {
                        phone_no = _phoneNoChannge.text;
                        en_otp ? sendOtpUser(phone_no) : null;
                        setState(() {
                          _phvalid = _phoneNoChannge.text.isNotEmpty;
                        });
                      },
                      borderSide: BorderSide(color: Colors.white),
                      shape: StadiumBorder(),
                    )
                  ],
                  alignment: MainAxisAlignment.center,
                ),
                error
                    ? SizedBox(
                        height: 40.0,
                        child: Text(
                          error_msg,
                          style: TextStyle(color: Colors.white),
                        ))
                    : SizedBox(height: 1.0),
                new TextFormField(
                  enabled: en_otp,
                  controller: _otpChannge,
                  style: TextStyle(color: Colors.white),
                  validator: (value) {
                    if (value.isEmpty ||
                        (int.tryParse(value) == null) ||
                        (value.length != 6)) {
                      return "Invalid OTP";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "OTP",
                    filled: true,
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  obscureText: true,
                ),
                // TextFormField(
                // 	enabled: false,
                // 	keyboardType: TextInputType.phone,
                // 	decoration: InputDecoration(
                // 		border: InputBorder.none,
                // 		labelText: "OTP",
                // 		filled: true,
                // 	),
                // ),
                ButtonBar(
                  children: <Widget>[
                    OutlineButton(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          // fontSize: 18.0,
                        ),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
                      onPressed: () {
                        setState(() {
                          otp = _otpChannge.text;
                          _otpvalid = _otpChannge.text.isNotEmpty;
                        });
                        _VerifyOtp();
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          duration: new Duration(seconds: 2),
                          content: new Row(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("  Signing-In...")
                            ],
                          ),
                        ));
                      },
                      borderSide: BorderSide(color: Colors.white),
                      shape: StadiumBorder(),
                    )
                  ],
                  alignment: MainAxisAlignment.center,
                )
              ],
            ),
            autovalidate: true,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.blue, Colors.teal])),
        ),
      ),
    );
  }
}
