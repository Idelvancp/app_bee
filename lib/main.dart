import 'dart:math';
import 'package:flutter/material.dart';
import 'screens/ apiary/apiariesScreen.dart';
import 'screens/ apiary/apiaryForm.dart';
import 'routes/appRoute.dart';

void main() => runApp(BeeApp());

class BeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.amber,
        ),
      ),
      routes: {
        AppRoutes.HOME: (ctx) => ApiariesScreen(),
        AppRoutes.APIARY_FORM: (ctx) => ApiaryForm(),
      },
    );
  }
}
