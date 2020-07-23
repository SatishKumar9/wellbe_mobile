import './questions.dart';
import './drawer.dart';
import 'package:flutter/material.dart';

class viewAnswer extends StatefulWidget {
  @override
  _viewAnswerState createState() => _viewAnswerState();
  static const String routeName = "/viewans";
}

class _viewAnswerState extends State<viewAnswer> {
  @override
  Widget build(BuildContext context) {
    final Map<String, Object> data = ModalRoute.of(context).settings.arguments;
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              data['question'],
              style: TextStyle(fontSize: 22),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                "by ${data['user_id']}",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(data['answer']),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, questionsPage.routeName);
          },
          child: Icon(Icons.bookmark_border)),
    ));
  }
}
