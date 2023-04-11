import 'package:appetizing/Screens/Image_Analysis.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'BirthDay.dart';
import 'Design.dart';
import 'Image_Analysistwo.dart';
import 'choosePlanPage.dart';
import 'load_activites.dart';
import 'load_chronic_diseases.dart';


class Medicines_Supplements extends StatefulWidget {
  Medicines_Supplements({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<Medicines_Supplements> {
  List consultation_followup_List = [];
  TextEditingController controller_Medicines_supplements=new TextEditingController();
  var valueChoose;
  var Consultation_id="0";
  bool isMultiSelectionEnabled = false;
  Map Resulte_otp = Map();
  final Data_User_Regist = GetStorage();
  Future fetchData() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_consultation_followup.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          // "device_id":"F1BTPG3"
          "device_id": Data_User_Regist.read("device_id"),

        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);

    Resulte_otp = body;
    setState(() {
      consultation_followup_List.addAll(Resulte_otp['data']);
    });
  }


  @override
  void initState() {
    // setState(() {
    fetchData();
    // });
    super.initState();
  }

  _getBackgroundColor() {
    return Container(
        decoration: BoxDecoration(
            color: Design.Background
        )
    );
  }

  _getContent() {
    var values;
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
          Text("What is your Consultation Followup?",
              style: Design.text_title),
          SizedBox(
            height: 15.0,
          ),
          Container(
            width: double.infinity,
            // margin: EdgeInsets.symmetric(horizontal: 15),
            // padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color:  Design.color_BoxShadow2,
            ),
            height: MediaQuery.of(context).size.height/15,
            padding: EdgeInsets.all(5),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text('Choose Consultation Followup ',
                  style: Design.small_text2,
                ),

                items: consultation_followup_List
                    .map((item) =>
                    DropdownMenuItem<String>(
                      value: item['en_name'],
                      child: Container(
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child:
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['en_name'],
                                          style: Design.small_text2,
                                        ),
                                        Text("price:"+
                                            item['price'],
                                          style: Design.small_text3,
                                        )
                                      ]
                                  )
                              ),
                            ]
                        ),
                      )
                      ,
                    )).toList(),
                value: valueChoose,
                onChanged: (value) {
                  setState(() {
                    valueChoose = value as String;
                  });
                },
                buttonHeight:  MediaQuery.of(context).size.height/15,
                buttonWidth: double.infinity,
                //   itemHeight: 50,
              ),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Expanded(
              child:
              TextField(
                maxLines: 8,
                controller: controller_Medicines_supplements,
                style: Design.text_title,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Please Enter Medicines Supplements',
                  hintStyle: Design.edit_text,

                  hintText: 'Medicines Supplements',
                ),
                autofocus: false,
              ),



          )
          ,
          Container(
            margin: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 5),
            width: double.infinity,
            child:
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(
                backgroundColor:Design.Background_Button_first,
              ),
              child:   Text('Next',
                  style: Design.Button_first),
              onPressed: () async {
                for(int x=0; x<consultation_followup_List.length;x++){
                  if(consultation_followup_List[x]['en_name']==valueChoose){
                    // print(x);
                    Consultation_id=consultation_followup_List[x]['id'];
                    // print(delivery_time_id);
                  }
                }
                // print(week);
                Data_User_Regist.write("Consultation_id", Consultation_id);
               Data_User_Regist.write("Medicnes", controller_Medicines_supplements.text);
                // if(   Data_User_Regist.read("plane_id").toString().isEmpty){
                //   AwesomeDialog(
                //       context: context,
                //       dialogType: DialogType.info,
                //       animType: AnimType.rightSlide,
                //       title: "Enter Birthday Please")
                //     ..show();
                //   return;
                // }
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => choosePlanPage()));
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Design.Background_Button_second,
              ),
              child:   Text('Back',
                  style: Design.Button_first),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Image_Analysistwo()));
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
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    );
  }
}
