import 'package:appetizing/Screens/DataForItems.dart';
import 'package:appetizing/Screens/DataForItems.dart';
import 'package:appetizing/Screens/DataForItems.dart';
import 'package:appetizing/Screens/DataForItems.dart';
import 'package:appetizing/Screens/Design.dart';
import 'package:appetizing/Screens/MenuData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import 'CurrentSubr.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'DataForItems.dart';
import 'MainMeun.dart';
import 'SizeListItems.dart';
import "package:animated_popup_dialog/animated_popup_dialog.dart";

class OldSubscriptionData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OldSubscriptionDataState();
}

class _OldSubscriptionDataState extends State<OldSubscriptionData> {
//  List customer_subscriptions = [];
  final Data_User_Regist = GetStorage();
  List<DataForItems>DataForItemList;
  List<DataForItems>ChooseList=[];
  List _selectedIndex = [];
  var CurrentSub;
  int cuttentcount=0;
  SizeListItems selectedUser;
  String size_id;
 //int  pressvalue=-1;
 Map xmap=new Map();
  @override
  Future load_customer_subscriptions(String id) async {
      CurrentSub = CurrentSubr.CurrentMenu;

    var url = "https://appetizingbh.com/mobile_app_api/load_package_menu.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token":"00QCRTl4MlV",
          "device_id":"F1BTPG3",
          "subscription_id":CurrentSubr.CurrentSub['id'],
          "package_id":CurrentSubr.CurrentSub['package_id'],
          //"item_master_package_id":"1"
          "item_master_package_id":"${CurrentSub['id']}"
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }
    //   var tagObjsJson = body['data'] as List;
    //   DataForItemList = tagObjsJson.map((tagJson) => DataForItems.fromJson(tagJson)).toList();
    // //  List<SizeListItems> _tags = tagObjsJson.map((tagJson) => SizeListItems.fromJson(tagJson)).toList();
    //   print(DataForItemList);

    setState(() {
      var tagObjsJson = body['data'] as List;
      DataForItemList = tagObjsJson.map((tagJson) => DataForItems.fromJson(tagJson)).toList();
        _selectedIndex = List.filled(DataForItemList.length, -1, growable: false);

      //  List<SizeListItems> _tags = tagObjsJson.map((tagJson) => SizeListItems.fromJson(tagJson)).toList();
      print(DataForItemList);
      //customer_subscriptions.addAll(body['data']);
    });
  }

  @override
  void initState() {

    super.initState();
    load_customer_subscriptions(xmap["Id"]);
    //remove data
    // Data_User_Regist.remove("Subscribtion_name");
    // Data_User_Regist.remove("BirthDay");
    // Data_User_Regist.remove("dateTime");
    // Data_User_Regist.remove("index_list_fitness");
    // Data_User_Regist.remove("Gendar");
    // Data_User_Regist.remove("Selected_value_Gender");
    //   Data_User_Regist.remove("lady_periodvalueChoose");
    // Data_User_Regist.remove("index_package");
    // Data_User_Regist.remove("type_package");
    // Data_User_Regist.remove("id_list_fitness");
    // Data_User_Regist.remove("Activity_id");
    // Data_User_Regist.remove("Activity_index");
    // Data_User_Regist.remove("plane_id");
    // Data_User_Regist.remove("address_id");
    // Data_User_Regist.remove("wight");
    // Data_User_Regist.remove("hight");
    // Data_User_Regist.remove("Target");
    // Data_User_Regist.remove("package_id");
    // Data_User_Regist.remove("start_date");
    // Data_User_Regist.remove("delivery_time_id");
    // Data_User_Regist.remove("week");
    // Data_User_Regist.remove("non_eatable");
    // Data_User_Regist.remove("_selectedIndex_NonEat");
    // Data_User_Regist.remove("_load_chronic_diseasesIndex");
    // Data_User_Regist.remove("load_chronic_diseases_ids");
    // Data_User_Regist.remove("Consultation_id");
    // Data_User_Regist.remove("Medicnes");
  }

  _getBackgroundColor()

  {
    return Container(decoration: BoxDecoration(color: Design.Background));
  }
  _getContent() {
  xmap  =ModalRoute.of(context).settings.arguments as Map;
  int intTwoMark = int.parse(xmap['Count']);
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Menu For ${xmap["Name"]}",
                      //"Menu For ${CurrentSubr.CurrentMenu["en_name"]}",
                      style: Design.Title,
                    ),
                  ],
                ),
                // Container(
                //   //  color: Colors.cyan,
                //   child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor:Design.Background_Button_first ,
                //       // padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
                //     ),
                //     child:   Text('New' ,style: Design.Button_first,),
                //     onPressed: () {
                //       // Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(
                //       //       builder: (context) => load_fitness(),
                //       //     ));
                //     },
                //   ),
                // )
              ],
            ),
          ),
          // style:

          Expanded(
            child: DataForItemList == null
                ?
                // ||customer_subscriptions.isEmpty?
            Center(
                      child: CircularProgressIndicator(),
                    )
                : ListView.separated(
                    // physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, i) {
                      return Divider(
                          // height: 20,
                          );
                    },
                    shrinkWrap: true,
                    itemCount: DataForItemList.length,
                    itemBuilder: (context, i) => InkWell(
                          onTap: () {
                            // setState(() {
                            //   Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => OldSubscriptionData()));
                            // });

                            //nabila
                            // var currentSub1=CurrentSubr.CurrentSub;
                            //
                            // var currentItem=customer_subscriptions[i]['id'];
                            //   switch(int.parse(CurrentSub['id'])){
                            //     case 1:
                            //       CurrentSubr.CurrentMeal.add(currentItem);
                            //       AwesomeDialog(
                            //           context: context,
                            //           dialogType: DialogType.info,
                            //           animType: AnimType.rightSlide,
                            //           title: "${CurrentSubr.CurrentMeal.length}   ${currentSub1['meal']}")
                            //         ..show();
                            //       break;
                            //     case 2:
                            //       CurrentSubr.CurrentSalad.add(currentItem);
                            //       AwesomeDialog(
                            //           context: context,
                            //           dialogType: DialogType.info,
                            //           animType: AnimType.rightSlide,
                            //           title: "${CurrentSubr.CurrentSalad.length} ${currentSub1['salad']}")
                            //         ..show();
                            //
                            //       break;
                            //       case 3:
                            //         CurrentSubr.CurrentSnack.add(currentItem);
                            //         AwesomeDialog(
                            //             context: context,
                            //             dialogType: DialogType.info,
                            //             animType: AnimType.rightSlide,
                            //             title: "${CurrentSubr.CurrentSnack.length}  ${currentSub1['snack']}")
                            //           ..show();
                            //         break;
                            //   }

//nabila

                          },
                          child: Container(
                              //height: 60,
                              decoration: BoxDecoration(
                                  // color: Color(0xfff000ff),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Design.color_BoxShadow2
                                            .withOpacity(0.5),
                                        blurRadius: 10.0,
                                        offset: Offset(0.0, 0.75))
                                  ]),
                              width: 100,
                              child: Card(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      // height: 20,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        children: [
                                          //name
                                          Row(
                                            children: [
                                              // Text(
                                              //   "Name: ",
                                              //   style: Design.text,
                                              // ),
                                              // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                              Flexible(
                                                child: Text(
                                                  DataForItemList[i].en_name,
                                                  style: Design.Title2,
                                                ),
                                              )
                                            ],
                                          ),
                                          //package_en_name
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          Row(
                                            children: [
                                              // Text(
                                              //   "Description: ",
                                              //   style: Design.text,
                                              // ),
                                              // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                              Flexible(
                                                child: Text(
                                                  DataForItemList[i].en_desc,
                                                  style: Design.small_text2,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                         // Visibility(child:
                                         Column(
                                            children: createRadioListUsers(i),
                                          ),
                                         // visible:DataForItemList[i].size_list[0].en_name==null ),
                                          SizedBox(
                                            height: 10.0,
                                          ),
                                          // Center(
                                          //   child: ElevatedButton(
                                          //     style: ElevatedButton.styleFrom(
                                          //       backgroundColor: Design.Background_Button_first,
                                          //       //    padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
                                          //     ),
                                          //     child: Text('Add Details'),
                                          //     onPressed: () {
                                          //       Navigator.of(context).push(PageRouteBuilder(
                                          //         opaque: false, // needed for transparent background
                                          //         pageBuilder: (context, _, __) {
                                          //           return AnimatedPopupDialog.textfield(
                                          //             textFieldText: 'textFieldText',
                                          //             title: 'Details',
                                          //
                                          //           );
                                          //         },
                                          //       ));
                                          //     },
                                          //   ),
                                          // ),
                                          new TextField(
                                            autofillHints: Characters("add Details"),
                                            onChanged: (value) {
                                              DataForItemList[i].set_Comment(value);
                                            },
                                            style: Design.text,
                                            decoration: InputDecoration(
                                                hintStyle: Design.edit_text,

                                              border: OutlineInputBorder(),
                                                fillColor: Colors.cyanAccent,
                                                contentPadding:
                                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                                hintText: "Add Comment"),

                                            // InputDecoration(
                                            //   border: OutlineInputBorder(),
                                            //   labelText: 'Please Enter Comment',
                                            //   hintStyle: Design.edit_text,
                                            //   hintText: 'Comment',
                                            // ),
                                            autofocus: false,
                                          ),

                                          SizedBox(
                                            height: 10.0,
                                          ),

                            OutlinedButton(
                              onPressed: () {
                                 setState(() {
                                  // else{
                                    if (_selectedIndex[i] == i) {
                                      _selectedIndex[i] = -1;
                                      cuttentcount=cuttentcount-1;
                                      print("${cuttentcount}");
                                      print("${intTwoMark}");
                                    } else {
                                      _selectedIndex[i] = i;
                                      cuttentcount=cuttentcount+1;
                                      print("${cuttentcount}");
                                      print("${intTwoMark}");
                                    }
                                    //pressvalue = i;
                                    print(DataForItemList[i]);
                                    if(DataForItemList[i].get_Comment==null){
                                      DataForItemList[i].set_Comment("");
                                    }
                                    print(DataForItemList[i]);

                                    if(intTwoMark<cuttentcount){
                                      AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.info,
                                          animType: AnimType.rightSlide,
                                          title: "remove item to can add ")
                                        ..show();
                                      _selectedIndex[i] = -1;
                                      cuttentcount=cuttentcount-1;
                                      return;
                                    }else{
                                      if(selectedUser==null){
                                        CurrentSubr.ChooseList.add(new MenuData(DataForItemList[i].id, DataForItemList[i].item_master_package_id, DataForItemList[i].en_name, DataForItemList[i].ar_name, DataForItemList[i].Comment, DataForItemList[i].size_id,"" ,
                                            "", "", "", "","","0","0"));
                                      }else{
                                        CurrentSubr.ChooseList.add(new MenuData(DataForItemList[i].id, DataForItemList[i].item_master_package_id, DataForItemList[i].en_name, DataForItemList[i].ar_name, DataForItemList[i].Comment, DataForItemList[i].size_id,selectedUser.en_name ,
                                            selectedUser.ar_name, selectedUser.calories, selectedUser.fat, selectedUser.protein, selectedUser.carbs,"0","0"));
                                      }
                                      // cuttentcount=cuttentcount+1;
                                    }
                                  // }


                                 // CurrentSubr.ChooseList.add(DataForItemList[i]);
                                //  Activity_id= _load_activity[index]["id"];
                                 });
                              },
                              child: Text(
                                  "+ Choose",
                                 // style: (pressvalue == i) ?: Design.text
                                   style: TextStyle(color: _selectedIndex.contains(i)  ? Colors.white:Design.color_icon )
                              ),
                              style: OutlinedButton.styleFrom(
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  side: BorderSide(color: Design.color_icon),
                                  backgroundColor:
                                  _selectedIndex.contains(i) ? Design.color_icon: Color(0xffff),

                            )
                            )
                                          //plane_en_name
                                          // Row(
                                          //   children: [
                                          //     Text("Plane Name: ",
                                          //       style: Design.text,
                                          //     ),
                                          //     // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                          //     Flexible(
                                          //       child: Text(customer_subscriptions[i]['plane_en_name'],
                                          //         style: Design.text,
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          //activity_en_name
                                          // Row(
                                          //   children: [
                                          //     Text("Activity Name: ",
                                          //       style: Design.text,
                                          //     ),
                                          //     // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                          //     Flexible(
                                          //       child: Text(customer_subscriptions[i]['activity_en_name'],
                                          //         style: Design.text,
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          // //fitness_en_name
                                          // Row(
                                          //   children: [
                                          //     Text("Fitness Name: ",
                                          //       style: Design.text,
                                          //     ),
                                          //     // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                          //     Flexible(
                                          //       child: Text(customer_subscriptions[i]['fitness_en_name'],
                                          //         style: Design.text,
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                          // //cretaeddatetime
                                          // Row(
                                          //   children: [
                                          //     Text("Created date time: ",
                                          //       style: Design.text,
                                          //     ),
                                          //     // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                          //     Flexible(
                                          //       child: Text(customer_subscriptions[i]['cretaeddatetime'],
                                          //         style: Design.text,
                                          //       ),
                                          //     )
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        )),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
            width: double.infinity,
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Design.Background_Button_second,
              ),
              child:   Text('Back',
                  style: Design.Button_first),
              onPressed: () async {
                setState(() {
                  Navigator.push(
                      context,

                      MaterialPageRoute(
                        builder: (context) => MainMeun(),
                        settings: RouteSettings(
                          arguments: ChooseList,
                        ),
                      )

                  );
                });
              },
            ),
          ),
          // Center(
          //   child: Container(
          //     margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          //     width: double.infinity,
          //     child: Row(children: <Widget>[
          //
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Design.Background_Button_first,
          //         ),
          //         child: Text(
          //           'DashBoard',
          //           style: Design.Button_first,
          //         ),
          //         onPressed: () async {},
          //       ),
          //
          //       Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Design.Background_Button_first,
          //         ),
          //         child: Text(
          //           'Test Result',
          //           style: Design.Button_first,
          //         ),
          //         // onPressed: () async {
          //         //   Data_User_Regist.write("customer_name",customer_subscriptions[0]['customer_name']);
          //         //   // Data_User_Regist.write("birth_date",customer_subscriptions[0]['birth_date']);
          //         //   // Data_User_Regist.write("gender",customer_subscriptions[0]['gender']);
          //         //   // Data_User_Regist.write("current_weight",customer_subscriptions[0]['current_weight']);
          //         //   // Data_User_Regist.write("current_height",customer_subscriptions[0]['current_height']);
          //         //   // Data_User_Regist.write("target_weight",customer_subscriptions[0]['target_weight']);
          //         //   //
          //         //
          //         //   ClientData.Name=customer_subscriptions[0]['customer_name'];
          //         //   ClientData.birth_date=customer_subscriptions[0]['birth_date'];
          //         //   ClientData.gender=customer_subscriptions[0]['gender'];
          //         //   ClientData.current_weight=customer_subscriptions[0]['current_weight'];
          //         //   ClientData.current_height=customer_subscriptions[0]['current_height'];
          //         //   ClientData.target_weight=customer_subscriptions[0]['target_weight'];
          //         //
          //         //   Navigator.push(
          //         //       context,
          //         //       MaterialPageRoute(
          //         //         builder: (context) => Account(),
          //         //       ));
          //         //
          //         //
          //         // },
          //       ),
          //
          //       Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Design.Background_Button_first,
          //           // padding:  const EdgeInsets.only(top: 30.0, bottom: 30.0)
          //         ),
          //         child: Text(
          //           'Support',
          //           style: Design.Button_first,
          //         ),
          //         onPressed: () async {},
          //       ),
          //
          //     ]),
          //   ),
          // ),
        ],
      ),
    );
  }
  // List<category> cat = Uitlits.getCat();

  // Future<bool> _onWillPop() async {
  //   return (await showDialog(
  //     context: context,
  //     builder: (context) => new AlertDialog(
  //       title: new Text('Are you sure?',style: Design.Title2),
  //       content: new Text('Do you want to logout an App',style: Design.text,),
  //       actions: <Widget>[
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: new Text('No',style:Design.no),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             SystemNavigator.pop();
  //           },
  //           child: new Text('Yes',style:Design.yes,),
  //         ),
  //       ],
  //     ),
  //   )) ?? false;
  // }
  setSelectedSize(SizeListItems sizeListItems,int index) {
    setState(() {
      selectedUser = sizeListItems;
      DataForItemList[index].set_size_id(selectedUser.size_master_id);
    });
  }
  List<Widget> createRadioListUsers(int index) {
    List<Widget> widgets = [];

    for (SizeListItems sizes  in DataForItemList[index].size_list) {
      widgets.add(
        RadioListTile(
          value: sizes,
          groupValue: selectedUser,
          title: Text(sizes.en_name==null?"":sizes.en_name,style: Design.text,),
          subtitle: Container(child:
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Icon(Icons.remove,
                //     size: 20, color: colors[i]),
                Text(
                  "calories"+ sizes.calories ,style: Design.small_text33,
                ),
                Text(
                  "protein"+ sizes.protein+"  "+  "carbs"+ sizes.carbs+"  "+"fat"+ sizes.fat+"  ",style: Design.small_text33,
                ),
              ]),),
          onChanged: (currentsize) {
            print("Current User ${currentsize.en_name}");
            selectedUser=currentsize;
            setSelectedSize(currentsize,index);
          },
          selected: selectedUser == sizes,
          activeColor: Design.color_icon,
        ),
      );
    }
    return widgets;
  }
  @override
  Widget build(BuildContext context) {

    return new WillPopScope(
        //onWillPop: _onWillPop,
        child: new Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    ));
  }
}
