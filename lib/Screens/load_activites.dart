import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'Design.dart';
import 'GenderType.dart';
import 'LoadNonEating.dart';

class load_activites extends StatefulWidget {
  const load_activites({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<load_activites> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<load_activites> {
  List _load_activity = [];
  String Activity_id="";
  int Activity_index;
  final Data_User_Regist = GetStorage();
  int value=0;
  _getBackgroundColor() {
    return Container(
        decoration: BoxDecoration(
            color: Design.Background
        )
    );
  }

  _getContent() {
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0,
            ),
            //Center()

            Text(
              "New Subscrip",
              style:Design.Title,
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              "How Active Are You",
              style: Design.text_title
            ),

            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child:_load_activity==null||_load_activity.isEmpty?
                Center(child: CircularProgressIndicator(),):
                ListView.separated(
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, i) {
                    return Divider(
                    //  height: 20,
                    );
                  },
                  shrinkWrap: true,
                  itemCount: _load_activity.length,
                  itemBuilder: (context, i) {
                    return Container(
                      //height: 60,
                      // decoration: BoxDecoration(
                      //     // color: Color(0xfff000ff),
                      //     boxShadow: [
                      //       BoxShadow(
                      //           color: Color(0xffffffff).withOpacity(0.3),
                      //           blurRadius: 20.0,
                      //           spreadRadius: 4.0)
                      //     ]),
                        width: double.infinity,
                        height: 60,
                        child: CustomRadioButton(
                            "${_load_activity[i]["en_name"]}",i)
                    );
                  },
                ),
              ),
            ),
            //button
                Container(
                  margin: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 5),
                  width: double.infinity,
                  child:
                  ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                      backgroundColor:Design.Background_Button_first,
                    ),
                    child:  Text('Next',
                        style: Design.Button_first),
                    onPressed: () async {
                      // setState(() {
                      if(Activity_id.isEmpty||Activity_id=="0"){
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: "Choose Active")
                          ..show();
                        return;
                      }

                      Data_User_Regist.write("Activity_id", Activity_id);
                        Data_User_Regist.write("Activity_index", value);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoadNonEating())
                      );
                      // });

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
                child:  Text('Back',
                    style: Design.Button_first),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => GenderType()));
                },
              ),
            ),

            //list

          ],
        ));
  }

  Future getActivites() async {
    // var response = await http.get(urls,);
    // await http.get(
    //   Uri.parse("https://appetizingbh.com/mobile_app_api/load_activity.php"),
    // );

    var response = await http.get(
        Uri.parse("https://appetizingbh.com/mobile_app_api/load_activity.php"),
        headers: {"Access-Control_Allow_Origin": "*"});

    var res = jsonDecode(response.body);

    setState(() {
      _load_activity.addAll(res);
    });
    // return _load_activity;
  }

  @override
  void initState() {
    getActivites();
    super.initState();
    value=Data_User_Regist.read("Activity_index");
  }

  Widget CustomRadioButton(String text, int index) {
    return
      OutlinedButton(
      onPressed: () {
        setState(() {
          value = index;
          Activity_id= _load_activity[index]["id"];
        });
      },
      child: Text(
        text,
        style: (value == index) ? Design.Button_first: Design.text
      ),
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: BorderSide(color: Design.Background_Button_first),
          backgroundColor:
              (value == index) ? Design.Background_Button_first : Color(0xffff)),

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
