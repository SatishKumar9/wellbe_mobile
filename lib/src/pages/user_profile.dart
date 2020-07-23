import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/pages/home_page.dart';
import '../helper/functions.dart';
// import 'main.dart';
import 'package:http/http.dart';
import 'drawer.dart';

class UserProfilePage extends StatefulWidget {
  @override
  UserProfilePageState createState() => UserProfilePageState();
}

class UserProfilePageState extends State<UserProfilePage> {
  String phone_no = "";

  String gender = "F";
  TextEditingController _name;
  TextEditingController _dob;
  TextEditingController _gdr;
  TextEditingController _ad1;
  TextEditingController _ad2;
  TextEditingController _lm;
  TextEditingController _area;
  TextEditingController _city;
  TextEditingController _dist;
  TextEditingController _state;
  TextEditingController _pcd;
  bool en_otp = false;

  user_logout(phone_num, token) async {
    print("phone number is $phone_num");
    print("token is $token");
    const url = "https://hk5xq4ss70.execute-api.us-east-1.amazonaws.com/test";
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"phone_no": phone_num, "token": token};
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    var resp = jsonDecode(response.body);
    print(resp);
    localDelete("phone_no");
    localDelete("name");
    localDelete("token");
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Logged Out"),
            content: new Text("You are logged out successfully."),
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
  }

  logout_user() {
    localRead("token").then((tkn) {
      localRead("phone_no").then((phone_no) {
        user_logout(phone_no, tkn);
      });
    });
  }

  @override
  get_profile_user(phone_num) async {
    print("phone number is $phone_num");
    String url = "https://gfesxkoj2f.execute-api.us-east-1.amazonaws.com/test";
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {"phone_no": phone_num};
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    var resp = jsonDecode(response.body);
    print(resp);
    return resp;
  }

  decor(text) {
    return InputDecoration(
      // border: OutlineInputBorder(),
      labelText: text,
      filled: true,
      labelStyle: TextStyle(
        color: Colors.white,
      ),
      errorStyle: TextStyle(
        color: Colors.white,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(20.0),
      ),
    );
  }

  Future<void> get_profile_data() async {
    localRead("phone_no").then((phone) {
      get_profile_user(phone).then((resp) {
        setState(() {
          _name = TextEditingController(text: resp["name"]);
          _gdr = TextEditingController(
              text: (resp["gender"] == "M") ? "Male" : "Female");
          _dob = TextEditingController(text: resp["date_of_birth"]);
          _ad1 = TextEditingController(text: resp["lane1"]);
          _ad2 = TextEditingController(text: resp["lane2"]);
          _lm = TextEditingController(text: resp["landmark"]);
          _area = TextEditingController(text: resp["area"]);
          _city = TextEditingController(text: resp["city"]);
          _dist = TextEditingController(text: resp["district"]);
          _state = TextEditingController(text: resp["state"]);
          _pcd = TextEditingController(text: resp["pincode"].toString());
        });
      });
    });
  }

  update_profile(phone_num) async {
    print("phone number is $phone_num");
    String url = "https://q9akra8mx0.execute-api.us-east-1.amazonaws.com/test";
    final headers = {'Content-Type': 'application/json'};
    Map<String, dynamic> body = {
      "phone_no": phone_num,
      "lane1": _ad1.text,
      "lane2": _ad2.text,
      "area": _area.text,
      "landmark": _lm.text,
      "city": _city.text,
      "district": _dist.text,
      "state": _state.text,
      "pincode": _pcd.text
    };
    Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    var resp = jsonDecode(response.body);
    print(resp);
    return resp;
  }

  Future<void> profile_update_address() async {
    localRead("phone_no").then((phone) {
      if (phone != null) {
        update_profile(phone).then((resp) {
          print(resp);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    get_profile_data();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      // drawer: AppDrawer(),
      body: SafeArea(
        child: Container(
          child: Form(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              children: <Widget>[
                SizedBox(height: 20.0),
                // Text(
                //   "User Profile",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 36,
                //     color: Colors.white,
                //   ),
                // ),
                FlatButton(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Logout",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20,
                          // color: Colors.white,
                        ),
                      ),
                      Padding(
                          padding:
                              const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Icon(
                            Icons.exit_to_app,
                            // color: Colors.white,
                            size: 18.0,
                          ))
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  onPressed: () {
                    logout_user();
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                  "Profile Details",
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: false,
                  controller: _name,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Name",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),

                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: false,
                  controller: _gdr,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Gender",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  enabled: false,
                  controller: _dob,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Date of Birth",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 15.0),
                Text(
                  "Address",
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 15.0),
                new TextFormField(
                  controller: _ad1,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Address Lane 1";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Address Lane 1",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _ad2,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Address Lane 2";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Address Lane 2",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _lm,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Landmark";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Landmark",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _area,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty Area";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Area",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _city,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty City";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "City",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _dist,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty District";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "District",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _state,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Empty State";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "State",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                new TextFormField(
                  controller: _pcd,
                  validator: (value) {
                    if (value.isEmpty ||
                        (int.tryParse(value) == null) ||
                        (value.length != 6)) {
                      return "Invalid Pin Code";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: "Pin Code",
                    filled: true,
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  // style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12.0),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.5),
                      // borderSide: BorderSide(color: Colors.white),
                      // shape: StadiumBorder(),
                      color: Colors.blue,
                      onPressed: () {
                        profile_update_address();
                      },
                    )
                  ],
                  alignment: MainAxisAlignment.center,
                )
              ],
            ),
            autovalidate: true,
          ),
          // decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //         begin: Alignment.topRight,
          //         end: Alignment.bottomLeft,
          //         colors: [Colors.blue, Colors.teal])),
        ),
      ),
    );
  }
}
