import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class Design {
  // static const Color Background = Color(0xffffffff);
  // static const Color Background_Menue= Color(0xffffffff);
  // static const Color color_icon= Color(0xff600505);
  // static const Color color_BoxShadow=Colors.black26;
  // static const Color color_BoxShadow2= Color(0xffD6D6D6);
  // static const Color color_BoxDecoration=Colors.white;
  //
  // static const Color Background_Button_first = Color(0xff600505);
  // static const Color Background_Button_second = Color(0xff4A5043);
  // static const TextStyle Button_first = TextStyle(
  //   color: Color(0xffffffff),
  //   fontFamily: 'ACME',
  // );
  // static const TextStyle Button_ = TextStyle(
  //   fontSize: 18,
  //   color: Color(0xff600505),
  //   fontFamily: 'ABEL',
  // );
  // static const TextStyle Button_second = TextStyle(
  //   color: Color(0xffffffff),
  //   fontFamily: 'ACME',
  // );
  //
  // static const TextStyle Title = TextStyle(
  //   fontSize: 30,
  //   color: Color(0xff600505),
  //   fontFamily: 'ACME',
  //   fontWeight: FontWeight.bold,
  // );
  // static const TextStyle Title2 = TextStyle(
  //   fontSize: 16,
  //   color: Color(0xff600505),
  //   fontFamily: 'ACME',
  //   fontWeight: FontWeight.bold,
  // );
  //
  // static const TextStyle text = TextStyle(
  //   fontSize: 18,
  //   color: Color(0xff600505),
  //   fontFamily: 'ABEL',
  //
  // );
  // static const TextStyle text_select = TextStyle(
  //   fontSize: 18,
  //   fontWeight: FontWeight.bold,
  //   color: Color(0xff600505),
  //   fontFamily: 'ABEL',
  //
  // );
  // static const TextStyle text_title = TextStyle(
  //   fontSize: 18,
  //   fontWeight: FontWeight.bold,
  //   color: Color(0xff600505),
  //   fontFamily: 'ABEL',
  //
  // );
  // static const TextStyle edit_text = TextStyle(
  //   fontSize: 20,
  //   color: Color(0xff4A5043),
  //   fontFamily: 'ABEL',
  // );
  // static const TextStyle small_text = TextStyle(
  //   fontSize: 15,
  //   color: Color(0xff000000),
  //   fontFamily: 'ABEL',
  //   decoration: TextDecoration.underline,
  // );

/////////////////////////////
  static   Color Background = Color(0xffffffff);
  static  Color Background_Menue= Color(0xffffffff);
  static  Color color_icon= Color(0xff600505);
  static  Color color_BoxShadow=Colors.black26;
  static   Color color_BoxShadow2= Color(0xffD6D6D6);
  static   Color color_BoxDecoration=Colors.white;

  static   Color Background_Button_first=Color(0xff600505);
  static   Color  Button_firstColor=Color(0xffffffff);
  static   Color  Button_SecondColor=Color(0xffffffff);
   static   Color Background_Button_second = Color(0xff4A5043);
  static   TextStyle Button_first = TextStyle(
    // color: Color(0xffffffff),
    color: Button_firstColor,
    fontFamily: 'ACME',
  );
  static   TextStyle Button_ = TextStyle(
    fontSize: 18,
    color: Color(0xff600505),
    fontFamily: 'ABEL',
  );
  static   TextStyle Button_second = TextStyle(
    color:Background_Button_second,
    // color: Color(0xffffffff),
    fontFamily: 'ACME',
  );
  static   TextStyle yes = TextStyle(
    color:Background_Button_first,
    // color: Color(0xffffffff),
    fontFamily: 'ACME',
  );
  static   TextStyle no = TextStyle(
    color:Background_Button_second,
    // color: Color(0xffffffff),
    fontFamily: 'ACME',
  );
  static   TextStyle Title = TextStyle(
    fontSize: 30,
    color: TitleColor,
    // color: Color(0xff600505),
    fontFamily: 'ACME',
    fontWeight: FontWeight.bold,
  );
  static   TextStyle Title2 = TextStyle(
    fontSize: 16,
    color: TitleColor,
    // color: Color(0xff600505),
    fontFamily: 'ACME',
    fontWeight: FontWeight.bold,
  );

  static   TextStyle text = TextStyle(
    fontSize: 18,
    color: textColor,
    fontFamily: 'ABEL',

  );

  static   TextStyle text_select = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
    fontFamily: 'ABEL',

  );
  static   TextStyle text_title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textColor,
    fontFamily: 'ABEL',

  );
  static   TextStyle edit_text = TextStyle(
    fontSize: 20,
    color: edit_textColor,
    fontFamily: 'ABEL',
  );
  static   TextStyle small_text = TextStyle(
    fontSize: 15,
    color: small_textColor,
    fontFamily: 'ABEL',
    decoration: TextDecoration.underline,
  );
  static   TextStyle small_text2 = TextStyle(
    fontSize: 15,
    color: small_textColor,
    fontFamily: 'ABEL',
  );

  static   TextStyle small_text3 = TextStyle(
    fontSize: 15,
    color: edit_textColor,
    fontFamily: 'ABEL',
  );
  static   TextStyle small_text33 = TextStyle(
    fontSize: 15,
    color: Button_SecondColor,
    fontFamily: 'ABEL',
  );
  static Color textColor=Color(0xff600505);
  static Color TitleColor=Color(0xff600505);
  static Color edit_textColor=Color(0xff4A5043);
  static Color small_textColor=Color(0xff000000);
  //////////////////////////

}