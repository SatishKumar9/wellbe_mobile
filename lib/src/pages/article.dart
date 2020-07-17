import 'package:flutter/material.dart';

class Article extends StatelessWidget {
  // Article({Key key}) : super(key: key);

  Article(this.article);

  double width;
  var article = new Map();

  Widget _titleSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  width: 65,
                  margin: EdgeInsets.only(bottom: 7),
                  child: _chip(
                    article["category"],
                    Colors.deepPurple,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: Text(
                    article["title"],
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
//              Text(
//                'Kandersteg, Switzerland',
//                style: TextStyle(
//                  color: Colors.grey[500],
//                ),
//              ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.bookmark_border,
            color: Colors.grey[500],
          ),
          Text('41'),
        ],
      ),
    );
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
        text.toUpperCase(),
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 10),
      ),
    );
  }

  Widget _textSection() {
    return Container(
      padding: const EdgeInsets.only(left: 30,right: 30, bottom: 30),
      child: Text(
        article["desc"],
        softWrap: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              // _header(context),
              Image.network(
                article["imageUrl"],
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              _titleSection(),
              _textSection(),
            ],
          ),
        ),
      ),
    );
  }
}
