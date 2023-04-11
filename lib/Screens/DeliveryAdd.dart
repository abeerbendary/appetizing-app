import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:group_radio_button/group_radio_button.dart';

import 'Design.dart';
import 'Uitlits.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'subscription.dart';

class DeliveryAdd extends StatefulWidget {
  //subscription({  required Key key}) : super(key: key);

  @override
  _DeliveryAddState createState() => _DeliveryAddState();
}

class _DeliveryAddState extends State<DeliveryAdd> {
  bool status = false;
  final Data_User_Regist = GetStorage();
  Map Resulte_ = Map();
  List Payment_method_List = [];
  var valueChoose;
  var Payment_method = "0";
  bool isCredet = false;
  Map Resulte_otp = Map();
  String _singleValue = "Text alignment right";
  String _verticalGroupValue = "Pending";

  Future fetchData() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_payment_method.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          // "device_id": "F1BTPG3"
          "device_id": Data_User_Regist.read("device_id")
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }
    print(body);
    Resulte_otp = body;
    setState(() {
      Payment_method_List.addAll(Resulte_otp['data']);
    });
    // if (Resulte_otp['status'] == 1) {
    //   print(Resulte_otp['data']);
    //   Payment_method_List.addAll(Resulte_otp['data']);
    //   // lady_periodIndex = List.filled(lady_periodList.length,-1,growable: false);
    // }
  }

  Future new_subscription() async {
    print(   jsonEncode(<String, dynamic>{
      "api_token":"00QCRTl4MlV",
      "device_id":Data_User_Regist.read("device_id"),
      "mobile_no":Data_User_Regist.read("mobile_no"),
      "customer_id":Data_User_Regist.read("customer_id"),
      //"customer_id": "5",
      "name":Data_User_Regist.read("Subscribtion_name"),
      "birth_date":Data_User_Regist.read("BirthDay"),
      "gender":Data_User_Regist.read("Gendar"),
      "fitness_goal_id":Data_User_Regist.read("id_list_fitness"),
      "activity_id":Data_User_Regist.read("Activity_id"),
      "plane_id":Data_User_Regist.read("plane_id"),
      "address_id":Data_User_Regist.read("address_id"),
      "current_weight":Data_User_Regist.read("wight"),
      "current_height":Data_User_Regist.read("hight"),
      "target_weight":Data_User_Regist.read("Target"),
      "package_id":Data_User_Regist.read("package_id"),
      "start_date":Data_User_Regist.read("start_date"),
      "delivery_time_id":Data_User_Regist.read("delivery_time_id"),
      "week":Data_User_Regist.read("week"),
      "non_eatable":Data_User_Regist.read("non_eatable"),
      "payment_method":Payment_method,
      "lady_period_id":Data_User_Regist.read("lady_period_id"),
      "chronic_diseases":Data_User_Regist.read("load_chronic_diseases_ids"),
      "medicines_supplements":Data_User_Regist.read("Medicnes"),
      "consultation_followup":Data_User_Regist.read("Consultation_id"),
    "medical_test":Data_User_Regist.read("medical_test")
    }));
    // http.Response response = await http.post(
    //   Uri.parse("https://appetizingbh.com/mobile_app_api/new_subscription.php"),
    //   body:
    //   jsonEncode(<String, dynamic>{
    //     "api_token":"00QCRTl4MlV",
    //     "device_id":Data_User_Regist.read("device_id"),
    //     "mobile_no":Data_User_Regist.read("mobile_no"),
    //     "customer_id":Data_User_Regist.read("customer_id"),
    //     //"customer_id": "5",
    //     "name":Data_User_Regist.read("Subscribtion_name"),
    //     "birth_date":Data_User_Regist.read("BirthDay"),
    //     "gender":Data_User_Regist.read("Gendar"),
    //     "fitness_goal_id":Data_User_Regist.read("id_list_fitness"),
    //     "activity_id":Data_User_Regist.read("Activity_id"),
    //     "plane_id":Data_User_Regist.read("plane_id"),
    //     "address_id":Data_User_Regist.read("address_id"),
    //     "current_weight":Data_User_Regist.read("wight"),
    //     "current_height":Data_User_Regist.read("hight"),
    //     "target_weight":Data_User_Regist.read("Target"),
    //     "package_id":Data_User_Regist.read("package_id"),
    //     "start_date":Data_User_Regist.read("start_date"),
    //     "delivery_time_id":Data_User_Regist.read("delivery_time_id"),
    //     "week":Data_User_Regist.read("week"),
    //     "non_eatable":Data_User_Regist.read("non_eatable"),
    //     "payment_method":Payment_method,
    //     "lady_period_id":Data_User_Regist.read("lady_period_id"),
    //     "chronic_diseases":Data_User_Regist.read("load_chronic_diseases_ids"),
    //     "medicines_supplements":Data_User_Regist.read("Medicnes"),
    //     "consultation_followup":Data_User_Regist.read("Consultation_id"),
    //     "medical_test":Data_User_Regist.read("medical_test")
    //   }),
    //   headers: {"Content-Type": "application/json"},
    // );
    // // print(body);
    // var bodys;
    // if (response.body.isNotEmpty) {
    //   bodys = jsonDecode(response.body);
    // }
    // print(bodys);
    // setState(() {
    //   Resulte_ = bodys;
    //   print(Resulte_['status']);
    //   if (Resulte_['status'] == 1) {
    //     Data_User_Regist.write("subscription_id", Resulte_['data']["subscription_id"]);
    //   } else {}
    // });
  }



  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
  }

  _getContent() {
    return Container(
        child: Column(children: [
      SizedBox(
        height: 50.0,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Payment",
                  style: Design.Title,
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Expanded(
          child: Column(children: [
        Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Total Amount: 35 BHD', style: Design.Title2)),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Text("Payment Method", style: Design.text_title),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              // padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Design.color_BoxShadow2,
              ),
              height: MediaQuery.of(context).size.height / 15,
              padding: EdgeInsets.all(15),
              child: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  hint: Text(
                    'Choose Payment Method ',
                    style: Design.small_text2,
                  ),
                  items: Payment_method_List
                      .map((item) => DropdownMenuItem<String>(
                    value: item['en_name'],
                    child: Text(
                      item['en_name'],
                      style: Design.small_text2,
                    ),
                  ))
                      .toList(),
                  value: valueChoose,
                  onChanged: (value) {
                    setState(() {
                      valueChoose = value as String;
                      if (_verticalGroupValue == "Credit Card") {
                        isCredet = true;
                      } else {
                        isCredet = false;
                      }
                      // print(delivery_time_id);
                    });
                  },
                  buttonHeight: MediaQuery.of(context).size.height / 15,
                  buttonWidth: 140,
                  itemHeight: 50,
                ),
              ),
            ),
        SizedBox(
          height: 10,
        ),
        Visibility(
            visible: isCredet,
            child: Container(
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 14, left: 14, top: 14),
                        child: Text(
                          "credit card Details",
                          style: Design.text_title,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "credit card Number: *********",
                          style: Design.text,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        child: Text(
                          "credit card password: ********",
                          style: Design.text,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ])),
      Container(
        margin: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Design.Background_Button_first,
          ),
          child: Text('Continue', style: Design.Button_first),
          onPressed: () async {
            for (int x = 0; x < Payment_method_List.length; x++) {
              if (Payment_method_List[x]['en_name'] == valueChoose) {
                // print(x);
                Payment_method = Payment_method_List[x]['id'];
                // print(delivery_time_id);
              }
            }
            // print(week);
            Data_User_Regist.write("payment_method", Payment_method);
            new_subscription();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => subscription()));
          },
        ),
      ),

      /////////////////////////////////////////
    ]));
  }

  @override
  void initState() {
    // setState(() {
    fetchData();
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    );
  }
}
