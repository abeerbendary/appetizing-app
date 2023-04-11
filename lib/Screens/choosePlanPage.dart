import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'Design.dart';
import 'LoadNonEating.dart';
import 'load_packages.dart';

class choosePlanPage extends StatefulWidget {
  _choosePlanPageState createState() => _choosePlanPageState();
}

class _choosePlanPageState extends State<choosePlanPage> {
  List _loadchoosePlanPageList = [];
  final Data_User_Regist = GetStorage();
  int value = 0;
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

            Text(
              "New Subscrip",
              style: Design.Title,
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Choose your Dietart Plan ?',
              style:Design.text_title,

            ),
            //list
            Expanded(
                child:_loadchoosePlanPageList==null||_loadchoosePlanPageList.isEmpty?
                Center(child: CircularProgressIndicator(),):
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, i) {
                      return Divider(
                   //     height: 20,
                      );
                    },
                    shrinkWrap: true,
                    itemCount: _loadchoosePlanPageList.length,
                    itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          Data_User_Regist.write("plane_id", _loadchoosePlanPageList[i]['id']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => load_packages()));
                        },
                        child: Container(
                          //height: 60,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color:Design.color_BoxShadow2.withOpacity(0.5), blurRadius: 10.0, offset: Offset(0.0, 0.75))
                              ]),
                         width: double.infinity,
                          child:  Card(
                            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),

                            child: Container(
                              // padding: EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                             //   crossAxisAlignment:CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  ListTile(
                                    tileColor:covertRgbaToColor(_loadchoosePlanPageList[i]['back_color']),
                                    leading: Image(

                                      image: NetworkImage(
                                          _loadchoosePlanPageList[i]['image_path']),
                                      width: 70.0,
                                      height: 70.0,
                                      alignment: Alignment.center,
                                    ),
                                    title:   Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        _loadchoosePlanPageList[i]['en_name'],
                                        style: Design.text_title,
                                      ),
                                    ),
                                    subtitle: Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Text(_loadchoosePlanPageList[i]['en_desc'],style: Design.text,)),
                                  ),
                                ],
                              ),
                            ),
                          ))
                        ))),
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


                  if(   Data_User_Regist.read("plane_id").toString().isEmpty){
                    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Complete Data Please")));

                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: "Complete Data Please")
                      ..show();
                    return;
                  }


                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoadNonEating()));
                },
              ),
            ),
          ],
        ));
  }

  @override
  Future fetchData1() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_plane.php";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      setState(() {
        _loadchoosePlanPageList.addAll(body);
      });

      //  print(body);
      // List<Data1> data1=[];
      // for( var item in body){
      //   data1.add(Data1.fromJson(item));
      // }
      // return data1;
    }
  }
  Color covertRgbaToColor(String colorStr){

    List rgbaList = colorStr.substring(5, colorStr.length - 1).split(",");
    return Color.fromRGBO(
        int.parse(rgbaList[0]), int.parse(rgbaList[1]), int.parse(rgbaList[2]), double.parse(rgbaList[3]));

  }
  @override
  void initState() {
    fetchData1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),

      // Expanded(
      //     child: ListView.builder(
      //       itemCount: nonEatableList.length,
      //       itemBuilder: (BuildContext ctx, int index) {
      //         return new GestureDetector(
      //           child: new Card(
      //             //I am the clickable child
      //             child: new Column(
      //               children: <Widget>[
      //
      //                 //new Image.network(video[index]),
      //                 new Padding(padding: new EdgeInsets.all(3.0)),
      //                 new Text(
      //                   nonEatableList[index]['en_name'],
      //                   style: new TextStyle(
      //                       fontWeight: FontWeight.bold, color: Colors.black),
      //                 ),
      //
      //               ],
      //             ),
      //           ),
      //         );
      //       },
      //     )),
    );
  }
}
