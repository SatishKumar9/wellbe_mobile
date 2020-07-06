import 'package:flutter/material.dart';
import 'home_page.dart';
import 'recomended_page.dart';

class AppDrawer extends StatefulWidget {
  @override
  _drawer createState() => _drawer();
}

Widget _createHeader() {
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
            child: Text("Welcome to WellBe",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

class _drawer extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          ListTile(
            title: Row(
              children: <Widget>[
                Icon(Icons.person),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Login'),
                )
              ],
            ),
            onTap: () {},
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
                Icon(Icons.bookmark),
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text('Bookmarks'),
                )
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                new MaterialPageRoute(builder: (context) => RecomendedPage()),
              );
            },
          ),
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
