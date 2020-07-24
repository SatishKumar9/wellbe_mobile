import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/pages/splashscreen.dart';

import 'src/pages/home_page.dart';
import 'src/theme/theme.dart';
import 'src/pages/questions.dart';
import 'src/pages/ask.dart';
import 'src/pages/view_ans.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: AppTheme.lightTheme,
      home: SplashScreen(),
      title: 'WellBe Mobile',
      debugShowCheckedModeBanner: false,
      routes: {
        questionsPage.routeName: (context) => questionsPage(),
        FormCardWidget.routeName: (context) => FormCardWidget(),
        viewAnswer.routeName: (context) => viewAnswer(),
      }, //routes
    );
  }
}
