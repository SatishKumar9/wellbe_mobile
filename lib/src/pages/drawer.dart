import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/pages/donate_request.dart';
import 'package:flutter_smart_course/src/pages/payments.dart';

import 'home_page.dart';
import 'recomended_page.dart';
import 'user_login.dart';
import 'user_profile.dart';
import 'categories.dart';

import '../helper/functions.dart';

class AppDrawer extends StatefulWidget {
  @override
  _drawer createState() => _drawer();
}

Widget _createHeader(name) {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('assets/abstract_design_background_3007.jpg'),
        ),
      ),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Row(
              children: <Widget>[
                Text(
                  "Welcome ",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  (name != null) ? name : 'to WellBe',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )),
      ]));
}

class _drawer extends State<AppDrawer> {
  var user; // = localRead("user");
  var name;
  // var emp;
  // var emp_name;
  Widget show;

  get_user() {
    localRead("name").then((nam) => {
          setState(() {
            print("user name: $nam");
            name = nam;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    get_user();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(name),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.person),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text((name != null) ? 'Profile' : 'Login'),
                )
              ],
            ),
            onTap: () {
              if (name != null) {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => UserProfilePage()));
              } else {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (context) => UserLoginPage()));
              }
            },
          ),
          Divider(
            thickness: 1,
            endIndent: 20,
            indent: 20,
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.home),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Home'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.category),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Category'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => CategoriesPage()));
            },
          ),
          // ListTile(
          //   title: Row(
          //     children: <Widget>[
          //       Icon(Icons.bookmark),
          //       Padding(
          //         padding: EdgeInsets.only(left: 8.0),
          //         child: Text('Bookmarks'),
          //       )
          //     ],
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       new MaterialPageRoute(builder: (context) => RecomendedPage()),
          //     );
          //   },
          // ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.chat),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Q/A Forum'),
                )
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.attach_money),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Donations'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => PaymentScreen()));
            },
          ),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.monetization_on),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('FundRaiser'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => UserDonateRequest()));
            },
          ),
        ],
      ),
    );
  }
}
