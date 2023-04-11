import 'dart:async';
import 'dart:convert';

import 'package:appetizing/Screens/MainMeun.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'CurrentSubr.dart';
import 'Design.dart';

class FreezSCreen extends StatefulWidget {
  FreezSCreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<FreezSCreen> {
  TextEditingController FromInput = TextEditingController();
  TextEditingController ToInput = TextEditingController();
  int main_Count = 0;
  final now = DateTime.now();
  DateTime tomorrow;
  String formattedDate;
  final Data_User_Regist = GetStorage();
  // bool freezeright=false;
  @override
  void initState() {
    tomorrow = DateTime(now.year, now.month, now.day + 1);
    main_Count = daysBetween(
        tomorrow, DateTime.parse(CurrentSubr.CurrentSub['end_date']));
    super.initState();
  }

  Future new_Freeze(String FromDate, String ToDate) async {
    // print("******************");
    // print(jsonEncode({
    //   "api_token": "00QCRTl4MlV",
    //   // "device_id": Data_User_Regist.read("device_id"),
    //   "device_id": "hhjjjj",
    //   "customer_id": "5",
    //   "subscription_id": CurrentSubr.CurrentSub['id'],
    //   "from_date": FromDate,
    //   "to_date": ToDate,
    // }));
    //sendserver
    http.Response response = await http.post(
      Uri.parse(
          "https://appetizingbh.com/mobile_app_api/update_freez_date.php"),
      body: jsonEncode({
        "api_token": "00QCRTl4MlV",
         "device_id": Data_User_Regist.read("device_id"),
        //"device_id": "hhjjjj",
       // "customer_id": "5",
        //"subscription_id": "104",
        "customer_id": "${Data_User_Regist.read("customer_id").toString()}",
        "subscription_id": CurrentSubr.CurrentSub['id'],
        "from_date": FromDate,
        "to_date": ToDate,
      }),
      headers: {"Content-Type": "application/json"},
    );
    // print(body);
    var bodys;
    if (response.body.isNotEmpty) {
      bodys = jsonDecode(response.body);
    }
    print(bodys);
    setState(() {
      if (bodys['status'] == 1) {
        // freezeright=true;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainMeun()));
      } else {
        // freezeright=false;
        AwesomeDialog(
            context: context,
            dialogType: DialogType.info,
            animType: AnimType.rightSlide,
            title: bodys['message'])
          ..show();
        return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(bodys['message'])));
      }
    });
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
  }

  _getContent() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Text(
            "Freez",
            style: Design.Title,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  "From Date",
                  style: Design.text_title,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  // padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Design.color_BoxShadow2,
                  ),
                  height: MediaQuery.of(context).size.height / 15,
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child: TextField(
                    style: Design.edit_text,
                    controller: FromInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today,
                          color: Design.color_icon), //icon of text field
                      //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: tomorrow,
                          firstDate: tomorrow,
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2025));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          FromInput.text =
                              formattedDate; //set output date to TextField value.
                          //main_Count=daysBetween(pickedDate,DateTime.parse(CurrentSubr.CurrentSub['end_date']));
                        });
                      } else {}
                    },
                  ))),

              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: Text(
                  "To Date",
                  style: Design.text_title,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  // padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Design.color_BoxShadow2,
                  ),
                  height: MediaQuery.of(context).size.height / 15,
                  padding: EdgeInsets.all(15),
                  child: Center(
                      child: TextField(
                    style: Design.edit_text,
                    controller: ToInput,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today,
                          color: Design.color_icon), //icon of text field
                      //label text of field
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          initialDate: tomorrow,
                          firstDate: tomorrow,
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2025));

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          ToInput.text =
                              formattedDate; //set output date to TextField value.
                          //main_Count=daysBetween(pickedDate,DateTime.parse(CurrentSubr.CurrentSub['end_date']));
                        });
                      } else {}
                    },
                  ))),

              // Container(
              //   margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
              //   decoration: BoxDecoration(
              //     //color: Design.color_BoxDecoration,
              //       color: Colors.white,
              //       borderRadius: BorderRadius.circular(10),
              //       boxShadow: [
              //         BoxShadow(
              //           // color: Design.color_BoxShadow,
              //             color: Colors.amber,
              //             blurRadius: 6,
              //             offset: Offset(0, 2))
              //       ]),
              //   width: 200,
              //   child: TextField(
              //     controller: count_day,
              //     keyboardType: TextInputType.number,
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       contentPadding: EdgeInsets.all(10),
              //     ),
              //     style: Design.edit_text,
              //   ),
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 100,
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.all(15),
                  child: Text(
                    "Count day Freeze  " + "${main_Count}",
                    style: Design.small_text,
                  ),
                ),
              ),
            ],
          )),
          Container(
            margin:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_first,
              ),
              child: Text('Save', style: Design.Button_first),
              onPressed: () async {
                // ClientData.activity_id=Activity_id;
                //
                // Data_User_Regist.write("Activity_index", value);

                setState(() {
                  if (FromInput.text.toString().isEmpty ||
                      ToInput.text.toString().isEmpty) {
                    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Birthday Please")));
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: "Please Enter Data")
                      ..show();
                    return;
                  } else {
                    new_Freeze(
                        FromInput.text.toString(), ToInput.text.toString());
                  }
                });
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_second,
              ),
              child: Text('Back', style: Design.Button_first),
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MainMeun()));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            // _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    );
  }
}
