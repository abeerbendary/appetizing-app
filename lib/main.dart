import 'dart:io';

import 'package:appetizing/Screens/DeliveryAdd.dart';
import 'package:appetizing/Screens/Image_Analysis.dart';
import 'package:appetizing/Screens/mapViewing.dart';
import 'package:appetizing/Screens/tyyy.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'Screens/ClientData.dart';
import 'Screens/Design.dart';
import 'dart:convert';

import 'Screens/GenderType.dart';
import 'Screens/GetLocationForOrder.dart';
import 'Screens/HistoryMenueDay.dart';
import 'Screens/LoadNonEating.dart';
import 'Screens/Login.dart';
import 'Screens/MainMeun.dart';
import 'Screens/Medicines_Supplements.dart';
import 'Screens/OldSubscriptionData.dart';
import 'Screens/load_chronic_diseases.dart';
import 'Screens/subscription.dart';



void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // debugShowCheckedModeBanner: false,
      title: 'Flutter Login Demo',
      theme: ThemeData(
        primarySwatch:buildMaterialColor(Color(0xFF600505)),
      ),
      home: MyHomePage(title: 'Flutter Login Demo Homepage'),
    );
  }
}
MaterialColor buildMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title }) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // List _load_color=[];
  // Color balck;
  // final Data_User_Regist = GetStorage();
  @override
  void initState() {
    // sleep(Duration(seconds: 10));
    super.initState();
   }
  @override
  Widget build(BuildContext context) {

   //  Design design =new Design();
   // design.readColors();
    return Scaffold(
       //body:OldSubscriptionData(),
      body:Login(),
    );
  }
}
