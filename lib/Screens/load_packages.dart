import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'Design.dart';
import 'choosePlanPage.dart';
import 'tyyy.dart';

class load_packages extends StatefulWidget {
  const load_packages({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<load_packages> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<load_packages> {
  List _load_packages = [];
  List _spacefic_packages = [];
  //int value = 1;
  int index_package=-1;
  int type_package=1;
  final Data_User_Regist = GetStorage();

  Widget CustomRadioButton(String text, int index, String details) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  type_package = index;
                  index_package=-1;
                }
                 );
                  if (type_package == 1) {
                  _spacefic_packages=[];
                  _spacefic_packages.addAll (_load_packages.where((i) {
                  return i['type'] == "Monthly";
                  }));
                  } else {
                  _spacefic_packages=[];
                  _spacefic_packages.addAll (_load_packages.where((i) {
                    return i['type'] == "Weekly";
                  }));

              }},
              child: Text(
                text,
                style: TextStyle(
                  color: (type_package == index) ? Colors.white : Colors.black,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    (type_package == index) ? Design.Background_Button_first : Colors.white,
              )),
          Text(
            "${details}",
            style:  Design.Button_,
          )
        ],
      ),
    );
  }

  Future getPackages() async {
    var response = await http.get(
        Uri.parse("https://appetizingbh.com/mobile_app_api/load_packages.php"),
        headers: {"Access-Control_Allow_Origin": "*"});

    var res = jsonDecode(response.body);

    // print(jsonDecode(response.body));
    setState(() {
      _load_packages.addAll(res);
      _spacefic_packages.addAll (_load_packages.where((i) {
        return i['type'] == "Monthly";
      }));
      // print(_spacefic_packages);
    });
    // return _load_activity;
  }

  @override
  void initState() {
    getPackages();

    super.initState();
    index_package=Data_User_Regist.read("index_package");
    print(index_package);
    type_package=Data_User_Regist.read("type_package");
    if(type_package==null){
      type_package=1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:Design.Background,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/20,
            ),
            //Center()
            Row(
              children: [
                Container(
                  child: Text(
                    "New Subscrip",
                    style: Design.Title,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/50,
            ),
            Row(
              children: [
                Container(
                    // height: 80,
                    child: Text(
                      "Your Plan",
                      style: Design.text_title
                    )),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/50,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomRadioButton("Monthly", 1, ""),
                  CustomRadioButton("Weekly", 0, ""),
                ],
              ),
            ),

            Expanded(

               child:   Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical: 15,horizontal: 8),
                    child:  _spacefic_packages==null||_spacefic_packages.isEmpty?
                    Center(child: CircularProgressIndicator(),):
                    ListView.separated(
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, i) {
                        return Divider(
                            // height: 20,
                            );
                      },
                      shrinkWrap: true,
                      itemCount: _spacefic_packages.length,
                      itemBuilder: (context, i) => InkWell(
                          onTap: () {
                            setState(() {
                              Data_User_Regist.write("package_id", _spacefic_packages[i]['id']);
                              index_package=i;
                              print(index_package);
                            });

                          },

                        child: Container(
                            //height: 60,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color:Design.color_BoxShadow2.withOpacity(0.5), blurRadius: 10.0, offset: Offset(0.0, 0.75))
                                ]),
                            width:  MediaQuery.of(context).size.width/1.4,
                            child: Card(
                                color: (index_package == i)? Design.color_BoxShadow2:Design.Background,
                                // margin: EdgeInsets.all(15),
                                child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding:EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Text(
                                          "${_spacefic_packages[i]["en_name"]}",
                                          style: Design.text_title,

                                      ),

                                    ],
                                  ),
                                ),
                                Center(
                                child:Image(
                                  height: MediaQuery.of(context).size.height/3,
                                    image: NetworkImage(
                                        _spacefic_packages[i]["image_path"]))),
                                Container(
                                  padding:EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Design.color_icon,
                                      ),
                                      Flexible(
                                        child: Text("${_spacefic_packages[i]["en_desc"]}",
                                            style: Design.text),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color:  Design.color_icon,
                                      ),
                                      Container(
                                        padding:EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            "${_spacefic_packages[i]["day_count"]}",
                                            style: Design.text,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${_spacefic_packages[i]["price"]}",
                                        style: Design.text_title
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ))))

                    ),
                  ),

            ),

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


                      if(Data_User_Regist.read("package_id").toString().isEmpty ){
                        // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Complete Data Please")));

                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: "  Complete Data Please")
                          ..show();
                        return;
                      }
                      Data_User_Regist.write("index_package", index_package);
                      Data_User_Regist.write("type_package", type_package);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => tyyy()));
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
                              builder: (context) => choosePlanPage()));
                    },
                  ),
                ),

          ],
        ),
      ),
      // new ListView.builder(
      //   itemCount: _load_packages.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Text("${_load_packages[index]["en_name"]}");
      //     // new Card(
      //     //   child: new Text(_load_activity[index].en_name),
      //     // );
      //   },
      // ),
    );
  }
}
