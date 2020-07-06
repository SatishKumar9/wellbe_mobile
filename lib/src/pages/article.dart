import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/helper/articleModel.dart';
import 'package:flutter_smart_course/src/helper/quad_clipper.dart';
import 'package:flutter_smart_course/src/pages/home_page.dart';
import 'package:flutter_smart_course/src/pages/recomended_page.dart';
import 'package:flutter_smart_course/src/theme/color/light_color.dart';
import 'package:flutter_smart_course/src/theme/theme.dart';

class Article extends StatelessWidget {
  Article({Key key}) : super(key: key);

  double width;

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
//      borderRadius: BorderRadius.only(
//          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: Container(
          height: 80,
          width: width,
          decoration: BoxDecoration(
            color: LightColor.orange,
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 10,
                  right: -120,
                  child: _circularContainer(300, LightColor.lightOrange2)),
              Positioned(
                  top: -60,
                  left: -65,
                  child: _circularContainer(width * .5, LightColor.darkOrange)),
              Positioned(
                  top: -230,
                  right: -30,
                  child: _circularContainer(width * .7, Colors.transparent,
                      borderColor: Colors.white38)),
              Positioned(
                  top: 30,
                  left: 0,
                  child: Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: Colors.white,
                              size: 40,
                            ),
                            color: Colors.redAccent,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ))),
            ],
          )),
    );
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  Widget _titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 0),
                child: Text(
                  'How to Protect Your Heart if You Have Diabetes',
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
          Icons.star,
          color: Colors.red[500],
        ),
        Text('41'),
      ],
    ),
  );

  Widget _textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text('Treating high blood pressure \n\n'
    'Blood pressure is the force of blood flow inside your arteries (blood vessels). If your blood exerts too much force on those vessels, your heart has to work harder than it should, putting you at increased risk for heart attack, stroke, eye problems and kidney disease. As many as two out of three adults with diabetes have high blood pressure, also called hypertension. If you have diabetes, the ADA recommends having your blood pressure checked at every routine doctor’s visit.\n\n'
    'Your healthcare team will use two numbers to describe your results—for instance, 120/80. The first number—known as “systolic” pressure—refers to the pressure your blood exerts as it pushes through your blood vessels when your heart beats. The second number—“diastolic” pressure—refers to the pressure between heartbeats, when the vessels relax. If you have diabetes, the ADA recommends keeping your blood pressure below 130-140/80-90.\n\n'
      'If you aren’t able to treat hypertension effectively through lifestyle changes, your doctor will prescribe medication. There are several kinds of blood pressure drugs, though not all of them are equally good for people with diabetes. Some raise blood glucose levels or mask some of the symptoms of low blood glucose (hypoglycemia). And you may need one or more to reach your blood pressure goals'
      'Lowering high cholesterol \n\n'
      'We’ve all heard about the perils of cholesterol, a type of fat produced by your liver and found in your blood. It’s important to understand the difference between the “good” kind and the “bad.” \n\n'
      'Low-density lipoproteins—also known as LDL, or the “bad” cholesterol—can build up and clog your blood vessels. That buildup is called plaque. If you have too much LDL, you’re at greater risk of a heart attack or stroke. \n\n'
      'High-density lipoproteins—also called HDL and referred to as the cholesterol—helps remove the LDL from your blood vessels.',
      softWrap: true,
    ),
  );

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(
        //  backgroundColor: Colors.blue,
        icon: Icon(icon),
        title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.purple,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.star_border),
          _bottomIcons(Icons.book),
          _bottomIcons(Icons.person),
        ],
        onTap: (index) {
//            setState(() {
//              _currentNav =  index;
//            });
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => RecomendedPage()));
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              _header(context),
              Image.asset(
                'assets/diabetes.jpg',
                width: 600,
                height: 240,
                fit: BoxFit.cover,
              ),
              _titleSection,
              _textSection,
            ],
          ),
        ),
      ),
    );
  }
}
