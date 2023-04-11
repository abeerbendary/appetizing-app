import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'Design.dart';
import 'subscription.dart';

class Account extends StatefulWidget {
  const Account({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<Account> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Account> {
  final Data_User_Regist = GetStorage();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Design.Background,
      body: Container(
          height: double.infinity,
          width: double.infinity,

            child: Column(children: [
              SizedBox(
                height: 50.0,
              ),
              //Center()
            //  Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.all(14),
                    child: Text(
                      "Account",
                      style: Design.Title,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Column(children: [
              Row(
                children: [
                  Container(
                    // height: 80,
                      margin: EdgeInsets.all(15),
                      child: Text(
                        "Hallo  "+"${Data_User_Regist.read('customer_name')}",
                        style:
                        Design.Title2,
                      )),
                ],
              ),
              Container(
              //  height: 500,
                margin: EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                decoration: BoxDecoration(
                  // color: Color(0xfff000ff),
                    boxShadow: [
                      BoxShadow(
                          color:Design.color_BoxShadow2.withOpacity(0.5), blurRadius: 10.0, offset: Offset(0.0, 0.75))
                    ]
                ),



                child:
                Card(
                    child: Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text("Birth Date: "+"${Data_User_Regist.read('birth_date')}",
                                style:
                                Design.text),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text("Gender: "+"${Data_User_Regist.read('gender')}",
                                style:
                                Design.text),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text("Current Weight: "+"${Data_User_Regist.read('current_weight')}",
                                style:
                                Design.text),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text("Current Height: "+"${Data_User_Regist.read('current_height')}",
                                style:
                                Design.text),
                          ),
                          Container(
                            margin: EdgeInsets.all(15),
                            child: Text("Target Weight: "+"${Data_User_Regist.read('target_weight')}",
                                style:
                                Design.text),
                          ),
                        ],
                      ),
                    )
                ),
              ),
]),


              ),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
                  Container(
                    margin: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:Design.Background_Button_second,
                      ),
                      child:  Text('Back',
                          style: Design.Button_first),
                      onPressed: () async {
                        Data_User_Regist.remove("customer_name");
                        Data_User_Regist.remove("birth_date");
                        Data_User_Regist.remove("gender");
                        Data_User_Regist.remove("current_weight");
                        Data_User_Regist.remove("current_height");
                        Data_User_Regist.remove("target_weight");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => subscription()));
                      },
                    ),
                  ),
              //   ],
              // )

             // ,
            ]
            ),

      )

    );
  }
}
