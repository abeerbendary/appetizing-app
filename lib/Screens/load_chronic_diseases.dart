import 'dart:collection';

import 'package:appetizing/Screens/LoadNonEating.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Design.dart';
import 'Image_Analysis.dart';
import 'Image_Analysistwo.dart';
import 'Medicines_Supplements.dart';
import 'choosePlanPage.dart';
import 'load_activites.dart';

class load_chronic_diseases extends StatefulWidget {
  load_chronic_diseases({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<load_chronic_diseases> {
  List load_chronic_diseasesList = [];
  final Data_User_Regist = GetStorage();
  List<int> load_chronic_diseases_ids = [];
  List _load_chronic_diseasesIndex = [];
  bool isMultiSelectionEnabled = false;
  Map Resulte_otp = Map();

  Future fetchData() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_chronic_diseases.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
            // "device_id":"F1BTPG3"
          "device_id": Data_User_Regist.read("device_id")
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);
      Resulte_otp = body;
    setState(() {
      if (Resulte_otp['status'] == 1) {
        print(Resulte_otp['data']);

          load_chronic_diseasesList.addAll(Resulte_otp['data']);
          if (_load_chronic_diseasesIndex==null) {
            _load_chronic_diseasesIndex = List.filled(
                load_chronic_diseasesList.length, -1, growable: false);
          }

      }
    });
  }

  @override
  void initState() {
    _load_chronic_diseasesIndex=Data_User_Regist.read("_load_chronic_diseasesIndex");
      fetchData();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Container(
            // height: 80,
            margin: EdgeInsets.all(15),
            child: Text(
              'What is your Chronic Diseases ?',
              style: Design.text_title

            )),
        // Expanded(child:
        Container(
             height: 540,
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child:load_chronic_diseasesList==null||load_chronic_diseasesList.isEmpty?
            Center(child: CircularProgressIndicator(),):
            GridView.builder(
              shrinkWrap: true,
                itemCount: load_chronic_diseasesList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, i) => InkWell(
                      onTap: () {
                        setState(() {
                          if (_load_chronic_diseasesIndex[i] == i) {
                            _load_chronic_diseasesIndex[i] = -1;
                          } else {
                            _load_chronic_diseasesIndex[i] = i;
                          }
                        });

                      },
                      child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: _load_chronic_diseasesIndex.contains(i)
                                  ? Design.color_BoxShadow2:Design.Background,
                              border: Border.all(
                                color:Design.color_icon,
                                width: 0.3,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              !_load_chronic_diseasesIndex.contains(i)
                                  ? const SizedBox.shrink()
                                  :
                              Icon(Icons.check),

                              Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  padding:  EdgeInsets.symmetric(horizontal: 10),
                                  child:
                                  Text(load_chronic_diseasesList[i]['en_name'],
                                      style: Design.text
                                  )
                              )
                            ],
                          )

                          //
                          ),
                    ))),
        // ),

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
                  for(int i=0;i<_load_chronic_diseasesIndex.length;i++){
                    if (_load_chronic_diseasesIndex[i]!=-1){
                      load_chronic_diseases_ids.add(int.parse(load_chronic_diseasesList[i]["id"]));
                      // week.add(i+1);
                    }
                  }
                Data_User_Regist.write("load_chronic_diseases_ids", load_chronic_diseases_ids);
                  Data_User_Regist.write("_load_chronic_diseasesIndex",_load_chronic_diseasesIndex);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Image_Analysistwo()));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoadNonEating()));
            },
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
