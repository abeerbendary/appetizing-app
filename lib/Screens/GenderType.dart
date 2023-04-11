import 'package:awesome_dialog/awesome_dialog.dart';
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
import 'load_activites.dart';

class GenderType extends StatefulWidget {
  GenderType({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<GenderType> {
  Gender Selected_value;
  String Gendertype;
  List lady_periodList = [];
  String lady_period_id;

  // int lady_periodIndex ;
  var valueChoose;
  bool isMultiSelectionEnabled = false;
  Map Resulte_otp = Map();
  bool femal = false;
  final Data_User_Regist = GetStorage();

  Future fetchData1() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_lady_period.php";
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
      lady_periodList.addAll(Resulte_otp['data']);
    });
  }

  @override
  void initState() {
      fetchData1();

      Selected_value = Data_User_Regist.read("Selected_value_Gender");
      if(Selected_value=="Female"){
        femal=true;
      }else{
        femal=false;
      }
      valueChoose = Data_User_Regist.read("lady_periodvalueChoose");
    super.initState();

  }

  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
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
          Center(
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              width: 150.0,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("What is your gender?", style: Design.text_title),
              Container(
                width: double.infinity,
                child: GenderPickerWithImage(
                  femaleImage: AssetImage("assets/images/famale.png"),
                  maleImage: AssetImage("assets/images/male.png"),
                  selectedGender: Selected_value,
                  onChanged: (value) {
                    setState(() {
                      Gendertype = value.name;
                      Selected_value = value as Gender;
                      if (value.name == "Female") {
                        femal = true;
                        print(femal);
                      } else {
                        femal = false;
                      }
                    });
                  },
                  showOtherGender: false,
                  verticalAlignedText: true,
                  selectedGenderTextStyle: Design.text,
                  unSelectedGenderTextStyle: Design.edit_text,
                  equallyAligned: true,
                  animationDuration: Duration(milliseconds: 300),
                  isCircular: true,
                  opacityOfGradient: 0.2,
                  size: 150,
                ),
              ),
              Visibility(
                visible: femal,
                child:
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
                        valueChoose==""||valueChoose==null?'Lady Period ':valueChoose,
                        style: Design.small_text2,
                      ),
                      items: lady_periodList
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

                          // print(delivery_time_id);
                        });
                      },
                      buttonHeight: MediaQuery.of(context).size.height / 15,
                      buttonWidth: 140,
                      itemHeight: 50,
                    ),
                  ),
                ),
              )
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
              child: Text('Next', style: Design.Button_first),
              onPressed: () async {
                // setState(() {
                  if(Gendertype.isEmpty||(femal&&valueChoose==null)){
    AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.rightSlide,
    title: "Choose Lady Period")
    ..show();
    return;
    }

                  Data_User_Regist.write("Gendar", Gendertype);
                  Data_User_Regist.write("Selected_value_Gender", Selected_value);
                  if (femal) {
                    Data_User_Regist.write("lady_periodvalueChoose", valueChoose);
                    for (int x = 0; x < lady_periodList.length; x++) {
                      if (lady_periodList[x]['en_name'] == valueChoose) {
                        print("id" +
                            lady_periodList[x]['id'] +
                            "/////////" +
                            x.toString());
                        Data_User_Regist.write(
                            "lady_period_id", lady_periodList[x]['id']);
                        // Data_User_Regist.write("lady_periodIndex", x);
                        // print(delivery_time_id);
                      }
                    }
                  }
                  // print(week);

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
                      MaterialPageRoute(builder: (context) => load_activites()));

                // });

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BirthDay()));
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
