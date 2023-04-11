import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'Account.dart';
import 'CurrentSubr.dart';
import 'DataForItems.dart';
import 'Design.dart';
import 'Login.dart';
import 'MainMeun.dart';
import 'MenuSelectionScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'OldSubscriptionData.dart';
import 'Uitlits.dart';
import 'ClientData.dart';

import 'catergory.dart';
import 'load_fitness.dart';

class subscription extends StatefulWidget {
  subscription({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}


 class _SignInState extends State<subscription> {

  List customer_subscriptions=[];
  final Data_User_Regist = GetStorage();
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?',style: Design.Title2),
        content: new Text('Do you want to logout an App',style: Design.text,),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style:Design.no),
          ),
          TextButton(
            onPressed: () async {
              SystemNavigator.pop();
            },
            child: new Text('Yes',style:Design.yes,),
          ),
        ],
      ),
    )) ?? false;
  }

  @override
  Future load_customer_subscriptions() async {

    var url = "https://appetizingbh.com/mobile_app_api/load_customer_subscriptions.php";
    http.Response response = await http.post(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(<String, String>{
      "api_token":"00QCRTl4MlV",
      "device_id": Data_User_Regist.read("device_id"),
      //"device_id": "hjhjhjhjh",
      "customer_id":"9",
      // "customer_id":Data_User_Regist.read("customer_id"),
    })
    );
    // "device_id": Data_User_Regist.read("device_id"),
    // "customer_id":Data_User_Regist.read("customer_id"),
    var body;
    if(response.body.isNotEmpty) {
      body =   jsonDecode(response.body);
    }

    print(body);
    setState(() {
      customer_subscriptions.addAll(body);
    });

  }

  @override
  void initState() {
    load_customer_subscriptions();
    super.initState();
    //remove data
    Data_User_Regist.remove("Subscribtion_name");
    Data_User_Regist.remove("BirthDay");
    Data_User_Regist.remove("dateTime");
    Data_User_Regist.remove("index_list_fitness");
   Data_User_Regist.remove("Gendar");
   Data_User_Regist.remove("Selected_value_Gender");
     Data_User_Regist.remove("lady_periodvalueChoose");
     Data_User_Regist.remove("index_package");
     Data_User_Regist.remove("type_package");
    Data_User_Regist.remove("id_list_fitness");
   Data_User_Regist.remove("Activity_id");
    Data_User_Regist.remove("Activity_index");
    Data_User_Regist.remove("plane_id");
    Data_User_Regist.remove("address_id");
    Data_User_Regist.remove("wight");
    Data_User_Regist.remove("hight");
    Data_User_Regist.remove("Target");
    Data_User_Regist.remove("package_id");
    Data_User_Regist.remove("start_date");
    Data_User_Regist.remove("delivery_time_id");
    Data_User_Regist.remove("week");
   Data_User_Regist.remove("non_eatable");
   Data_User_Regist.remove("_selectedIndex_NonEat");
    Data_User_Regist.remove("_load_chronic_diseasesIndex");
    Data_User_Regist.remove("load_chronic_diseases_ids");
    Data_User_Regist.remove("Consultation_id");
    Data_User_Regist.remove("Medicnes");
   Data_User_Regist.remove("medical_test");

  }

  _getBackgroundColor() {
    return Container(
        decoration: BoxDecoration(
            color: Design.Background
        )
    );
  }

  _getContent() {

    return
      Container(
        child: Column(
          children: [
            SizedBox(
              height: 50.0,
            ),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  Row(
                    children: [
                      Text("Subscription" , style: Design.Title,
                      ),

                    ],
                  ),
                  Container(
                  //  color: Colors.cyan,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:Design.Background_Button_first ,
                         // padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
                      ),
                      child:   Text('New' ,style: Design.Button_first,),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => load_fitness(),
                            ));
                      },
                    ),
                  )
                ],
              ),
            ),
             // style:

            Expanded(
     child: customer_subscriptions==null?
     Center(
       child: Text("Add New Subscription")
       // CircularProgressIndicator(),
     ):customer_subscriptions.isEmpty?
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
                                itemCount: customer_subscriptions.length,
                                itemBuilder: (context, i) => InkWell(
                                  onTap: () {
                                    setState(() {
                                     // print(customer_subscriptions[i].toString()+'------------');
                                      // CurrentSubr.CurrentObj= customer_subscriptions[i];
                                      CurrentSubr.CurrentSub= customer_subscriptions[i];
                                      List<DataForItems> data=null;
                                      CurrentSubr.Days_index=[];
                                      CurrentSubr.CurrentMenu=[];
                                      Navigator.push(
                                          context,

                                          MaterialPageRoute(
                                              builder: (context) => MainMeun(),

                                            settings: RouteSettings(
                                            arguments: data,
                                          ),
                                          )

                                      );
                                    });
  // Navigator.push(
  //                                         context,
  //                                         MaterialPageRoute(
  //                                             builder: (context) => OldSubscriptionData()));
  //                                   });

                                    },
                                  child: Container(
                                    //height: 60,
                                      decoration: BoxDecoration(
                                        // color: Color(0xfff000ff),
                                          boxShadow: [
                                            BoxShadow(
                                                color:Design.color_BoxShadow2.withOpacity(0.5), blurRadius: 10.0, offset: Offset(0.0, 0.75))
                                          ]
                                      ),
                                      width: 100,
                                      child: Card(
                                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              // height: 20,
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                              child: Column(
                                                children:[
                                                  //name
                                                  Row(
                                                  children: [
                                                    Text("Name: ",
                                                        style: Design.text,
                                                    ),
                                                    // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                                    Flexible(
                                                      child: Text(customer_subscriptions[i]['name'],
                                                        style: Design.text,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                  //package_en_name
                                                  Row(
                                                    children: [
                                                      Text("Package Name: ",
                                                          style: Design.text,
                                                        ),
                                                      // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                                      Flexible(
                                                        child: Text(customer_subscriptions[i]['package_en_name'],
                                                          style: Design.text,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  //plane_en_name
                                                  Row(
                                                    children: [
                                                      Text("Plane Name: ",
                                                        style: Design.text,
                                                      ),
                                                      // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                                      Flexible(
                                                        child: Text(customer_subscriptions[i]['plane_en_name'],
                                                          style: Design.text,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  //activity_en_name
                                                  Row(
                                                    children: [
                                                      Text("Activity Name: ",
                                                        style: Design.text,
                                                      ),
                                                      // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                                      Flexible(
                                                        child: Text(customer_subscriptions[i]['activity_en_name'],
                                                          style: Design.text,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  //fitness_en_name
                                                  Row(
                                                    children: [
                                                      Text("Fitness Name: ",
                                                        style: Design.text,
                                                      ),
                                                      // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                                      Flexible(
                                                        child: Text(customer_subscriptions[i]['fitness_en_name'],
                                                          style: Design.text,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  //cretaeddatetime
                                                  Row(
                                                    children: [
                                                      Text("Created date time: ",
                                                        style: Design.text,
                                                      ),
                                                      // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                                      Flexible(
                                                        child: Text(customer_subscriptions[i]['cretaeddatetime'],
                                                          style: Design.text,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),

                                              ),
                                          ],
                                        ),
                                      )),
                                )
                              ),

              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
              width: double.infinity,
              child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Design.Background_Button_first,
                         // padding:  const EdgeInsets.only(top: 0.0, bottom: 0.0)

                        ),
                        child:   Text('Subscript',
                          style: Design.Button_first,),
                        onPressed: () async {

                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Design.Background_Button_first,
                          // padding:  const EdgeInsets.only(top: 30.0, bottom: 30.0)
                        ),
                        child:   Text('Account',
                          style: Design.Button_first,),
                        onPressed: () async {
                          Data_User_Regist.write("customer_name",customer_subscriptions[0]['customer_name']);
                          // Data_User_Regist.write("birth_date",customer_subscriptions[0]['birth_date']);
                          // Data_User_Regist.write("gender",customer_subscriptions[0]['gender']);
                          // Data_User_Regist.write("current_weight",customer_subscriptions[0]['current_weight']);
                          // Data_User_Regist.write("current_height",customer_subscriptions[0]['current_height']);
                          // Data_User_Regist.write("target_weight",customer_subscriptions[0]['target_weight']);
                          //

                          ClientData.Name=customer_subscriptions[0]['customer_name'];
                          ClientData.birth_date=customer_subscriptions[0]['birth_date'];
                          ClientData.gender=customer_subscriptions[0]['gender'];
                          ClientData.current_weight=customer_subscriptions[0]['current_weight'];
                          ClientData.current_height=customer_subscriptions[0]['current_height'];
                          ClientData.target_weight=customer_subscriptions[0]['target_weight'];

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Account(),
                              ));


                        },
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5.0)),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Design.Background_Button_first,
                          // padding:  const EdgeInsets.only(top: 30.0, bottom: 30.0)
                        ),
                        child:   Text('Support',
                          style: Design.Button_first,),
                        onPressed: () async {

                        },
                      ),
                    )

                  ]
              ),

            ),

          ],
        ),
      );
  }
  // List<category> cat = Uitlits.getCat();


  @override
  Widget build(BuildContext context) {

   return new WillPopScope(
        onWillPop: _onWillPop,
        child:new Scaffold(
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
