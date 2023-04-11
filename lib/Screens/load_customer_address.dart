import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'DeliveryAdd.dart';
import 'Design.dart';
import 'MenuSelectionScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Uitlits.dart';
import 'mapViewing.dart';

class load_customer_address extends StatefulWidget {
  load_customer_address({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<load_customer_address> {
  final Data_User_Regist = GetStorage();
  List customer_address = [];
  @override
  Future load_customer_addess() async {
    var url =
        "https://appetizingbh.com/mobile_app_api/load_customer_address.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          "device_id": Data_User_Regist.read("device_id"),
         // "customer_id": "5",
           "customer_id": Data_User_Regist.read("customer_id")
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);
    setState(() {
      customer_address.addAll(body);
    });
  }

  @override
  void initState() {
    load_customer_addess();
    super.initState();
  }

  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
  }

  _getContent() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "History Address",
                      style: Design.Title,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // style:
          Expanded(
            child: customer_address==null||customer_address.isEmpty?
            Center(child: CircularProgressIndicator(),):
            ListView.separated(
                // physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, i) {
                  return Divider(
                      // height: 20,
                      );
                },
                shrinkWrap: true,
                itemCount: customer_address.length,
                itemBuilder: (context, i) => InkWell(
                    onTap: () {
                      Data_User_Regist.write("address_id", customer_address[i]['id']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryAdd(),
                          ));
                      
                    },
                    child: Container(
                        //height: 60,
                        decoration: BoxDecoration(
                            // color: Color(0xfff000ff),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Design.color_BoxShadow2.withOpacity(0.5),
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 0.75))
                            ]),
                        width: double.infinity,
                        child: Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
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
                                        Text(
                                          "Name: ",
                                          style: Design.text,
                                        ),
                                        // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                        Text(
                                          customer_address[i]['name'],
                                          style: Design.text,
                                        )
                                      ],
                                    ),
                                    //block
                                    Row(
                                      children: [
                                        Text(
                                          "Block: ",
                                          style: Design.text,
                                        ),
                                        // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                        Text(
                                          customer_address[i]['block'],
                                          style: Design.text,
                                        )
                                      ],
                                    ),
                                    //road
                                    Row(
                                      children: [
                                        Text(
                                          "Road: ",
                                          style: Design.text,
                                        ),
                                        // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                        Text(
                                          customer_address[i]['road'],
                                          style: Design.text,
                                        )
                                      ],
                                    ),
                                    //building
                                    Row(
                                      children: [
                                        Text(
                                          "Building: ",
                                          style: Design.text,
                                        ),
                                        // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                        Text(
                                          customer_address[i]['building'],
                                          style: Design.text,
                                        )
                                      ],
                                    ),
                                    //flat
                                    Row(
                                      children: [
                                        Text(
                                          "flat: ",
                                          style: Design.text,
                                        ),
                                        // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                        Text(
                                          customer_address[i]['flat'],
                                          style: Design.text,
                                        )
                                      ],
                                    ),
                                    //stampdatetime
                                    Row(
                                      children: [
                                        Text(
                                          "Stamp DateTime: ",
                                          style: Design.text,
                                        ),
                                        // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                        Text(
                                          customer_address[i]['stampdatetime'],
                                          style: Design.text,
                                        )
                                      ],
                                    ),
                                    //note
                                    Row(
                                      children: [
                                        Text(
                                          "note: ",
                                          style: Design.text,
                                        ),
                                        // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                        Text(
                                          customer_address[i]['note'],
                                          style: Design.text,
                                        )
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Text("Name: ",
                                    //       style: Design.text,
                                    //     ),
                                    //     // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                    //     Text(customer_subscriptions[i]['name'],
                                    //       style: Design.text,
                                    //     )
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text("Name: ",
                                    //       style: Design.text,
                                    //     ),
                                    //     // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                    //     Text(customer_subscriptions[i]['name'],
                                    //       style: Design.text,
                                    //     )
                                    //   ],
                                    // ),
                                    // Row(
                                    //   children: [
                                    //     Text("Name: ",
                                    //       style: Design.text,
                                    //     ),
                                    //     // Padding(padding: EdgeInsets.symmetric(horizontal: 20)),
                                    //     Text(customer_subscriptions[i]['name'],
                                    //       style: Design.text,
                                    //     )
                                    //   ],
                                    // ),
                                    ////////
                                    // Row(
                                    //   children:[ Column(
                                    //      children: <Widget>[
                                    //        //Padding(padding: EdgeInsets.all(20.0)),
                                    //        Text("StartDate",
                                    //          style: Design.text,
                                    //        ),
                                    //        // Padding(padding: EdgeInsets.all(20.0)),
                                    //        Text("EndDate",
                                    //          style: Design.text,
                                    //        )
                                    //      ],
                                    //    ),]
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )))),
////////
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_second,
                // padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
              ),
              child:   Text('Back' ,style: Design.Button_first,),
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => mapViewing()));
              },
            ),
          ),
        ],
      ),
    );
  }

  // List<category> cat = Uitlits.getCat();

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
