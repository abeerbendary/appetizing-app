import 'dart:async';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'DeliveryAdd.dart';
import 'Design.dart';
import 'GetLocationForOrder.dart';
import 'Uitlits.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'load_customer_address.dart';

class mapViewing extends StatefulWidget {
  //subscription({  required Key key}) : super(key: key);

  @override
  _mapViewingState createState() => _mapViewingState();
}

final CameraPosition _kGooglePlex = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);
Completer<GoogleMapController> _controller = Completer();

class _mapViewingState extends State<mapViewing> {
  final Data_User_Regist = GetStorage();
  Map Resulte_=Map();
  // Data_User_Regist.write("block", lang);
  // Data_User_Regist.write("road", placemarks[0].street);
  // Data_User_Regist.write("building", placemarks[0].name);
  // Data_User_Regist.write("note", "");
  TextEditingController block=new TextEditingController();
  TextEditingController road=new TextEditingController();
  TextEditingController flat=new TextEditingController();
  TextEditingController building=new TextEditingController();
  TextEditingController note=new TextEditingController();
  _getBackgroundColor() {
    return Container(
      decoration: BoxDecoration(color:Design.Background),
    );
  }
  Future SendLocation() async {
     print(jsonEncode(
       {
         "api_token":"00QCRTl4MlV",
         "device_id":Data_User_Regist.read("device_id"),
         "customer_id":Data_User_Regist.read("customer_id"),
         "type":Data_User_Regist.read("type"),
         "block":Data_User_Regist.read("block"),
         "road":Data_User_Regist.read("road"),
         "flat":Data_User_Regist.read("flat"),
         "building":Data_User_Regist.read("building"),
         "note":Data_User_Regist.read("note"),
         "latitude":Data_User_Regist.read("lat"),
         "longitude":Data_User_Regist.read("lang")
       },
     ));
    http.Response response = await http.post(
      Uri.parse(
          "https://appetizingbh.com/mobile_app_api/new_customer_address.php"),
      body: jsonEncode(
         {
          // "api_token": "00QCRTl4MlV",
          // "otp": Data_User_Regist.read("otp"),
          // "otp_id": Data_User_Regist.read("otp_id"),
          // "device_id": Data_User_Regist.read("device_id"),
          // // "mobile_no":Data_User_Regist.read("mobile_no"),
          // "mobile_no": "01013975432",
          // "name": Data_User_Regist.read("name"),
          // "email": Data_User_Regist.read("email")
           "api_token":"00QCRTl4MlV",
           "device_id":Data_User_Regist.read("device_id"),
           "customer_id":Data_User_Regist.read("customer_id"),
           "type":Data_User_Regist.read("type"),
           "block":Data_User_Regist.read("block"),
           "road":Data_User_Regist.read("road"),
           "flat":Data_User_Regist.read("flat"),
           "building":Data_User_Regist.read("building"),
           "note":Data_User_Regist.read("note"),
           "latitude":Data_User_Regist.read("lat"),
           "longitude":Data_User_Regist.read("lang")
         },
      ),
      headers: {"Content-Type": "application/json"},
    );
    var parsed = jsonDecode(response.body);
    Map<String, dynamic> authfailed = {};

    if (parsed['status'] == 1) {
      Data_User_Regist.write("address_id", parsed['data']["address_id"]);
      print(parsed['data']["address_id"]);
      // AwesomeDialog(
      //     context: context,
      //     dialogType: DialogType.info,
      //     animType: AnimType.rightSlide,
      //     title: "Location Sended")
      //   ..show();

      // Data_User_Regist.write("customer_id", parsed['data']['customer_id']);
      //
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => ConfirmRegistration()),
      // );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(parsed['data']['message'])));
    }
  }

  _getContent() {
    return
      Container(
          height :  MediaQuery.of(context).size.height,
           width :  MediaQuery.of(context).size.width,
          // height: double.infinity,
          // width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height/28,
        ),

     //      SingleChildScrollView(
     //
     // child:
     Expanded(
          child: Column(
            children: <Widget>[
        Container(
          width: double.infinity,
          // padding:EdgeInsets.symmetric(horizontal: 15) ,
          // alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => load_customer_address()));
            },
            icon: Icon( // <-- Icon
              Icons.history,
              size: 20.0,
            ),
            label: Text('address',style: Design.Button_first,),
            style: ElevatedButton.styleFrom(
              backgroundColor: Design.Background_Button_first,
            ),// <-- Text
          ),
        ),
        // Container(
        //   // margin: EdgeInsets.symmetric(horizontal: 20),
        //   child: GoogleMap(
        //     mapType: MapType.normal,
        //     initialCameraPosition: _kGooglePlex,
        //     onMapCreated: (GoogleMapController controller) {
        //       _controller.complete(controller);
        //     },
        //   ),
        //   height: MediaQuery.of(context).size.height/6,
        //   width: double.infinity,
        //   decoration: BoxDecoration(color: Design.Background_Button_first),
        // ),

        Container(
            alignment: Alignment.centerLeft,
          //  padding:EdgeInsets.symmetric(horizontal: 15) ,
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Design.Background_Button_first,
                  ),
              child: Text('Current Location',
                style: Design.Button_first
              ),
              onPressed: () async {
                // Data_User_Regist.write("address_id", customer_address[i]['id']);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetLocationForOrder(),
                    ));
              },
            ),
        ),
        // Visibility(
        //     visible: Data_User_Regist.read("adress").toString().isNotEmpty,
        //
        //     child: Text(Data_User_Regist.read("adress"), style: Design.text)),
        Container(
            alignment: Alignment.centerLeft,
         //   margin: const EdgeInsets.only( top: 20),
        //    padding:EdgeInsets.symmetric(horizontal: 15) ,
            child:
            Text("Address type",
                style: Design.text_title)),

        Row(
            children:[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child:
                ElevatedButton.icon(
                  onPressed: () {
                    Data_User_Regist.write("type",'Home');
                  },
                  icon: Icon( // <-- Icon
                    Icons.home,
                    size: 15.0,
                  ),
                  label: Text('Home',style: Design.Button_first,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Design.Background_Button_first,
                  ),// <-- Text
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Data_User_Regist.write("type",'Office');
                  },
                  icon: Icon( // <-- Icon
                    Icons.local_post_office,
                    size: 15.0,
                  ),
                  label: Text('Office',style: Design.Button_first,),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Design.Background_Button_first,
                  ),// <-- Text
                ),
              ),
            ]

        ),

        // Container(
        //     alignment: Alignment.centerLeft,
        //     // margin: const EdgeInsets.only( top: 10),
        //   //  padding:EdgeInsets.symmetric(horizontal: 15) ,
        //     child: Text("Area",
        //         style:Design.text_title)),
        // Container(
        //    margin: const EdgeInsets.only(left: 15, right: 15,),
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(10),
        //         boxShadow: [
        //           BoxShadow(
        //               color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        //         ]),
        //     child: TextField(
        //       controller: area,
        //       keyboardType: TextInputType.text,
        //         decoration: InputDecoration(
        //             border: InputBorder.none,
        //             contentPadding: EdgeInsets.all(10),
        //            ),
        //         style:
        //             Design.edit_text,
        //             )),

        SizedBox(
          height: MediaQuery.of(context).size.height/100,
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 15),

                        child: Text("Building",
                            style: Design.text_title)),
                  ),
                  Expanded(
                    flex: 6,
                    child:  Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 15),
                        child: Text("Flat",
                            style: Design.text_title),
                  ),
                  )
                ],
              ),
            ),
          ],
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                        margin: const EdgeInsets.only(left: 15, right: 15,top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                            ]),
                        child: TextField(
                          controller: building,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            style: Design.edit_text)),
                  ),
                  Expanded(
                    flex: 6,
                    child:  Container(
                       margin: const EdgeInsets.only(left: 15, right: 15,top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                            ]),
                        child: TextField(
                          controller: flat,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                              ),
                            style:Design.edit_text)),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height/60,
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child: Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 15),

                        child: Text("Block",
                            style:  Design.text_title)),
                  ),
                  Expanded(
                    flex: 6,
                    child:  Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 15),
                        child: Text("Road",
                            style:Design.text_title)),
                  ),

                ],
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 6,
                    child:   Container(
                    margin: const EdgeInsets.only(left: 15, right: 15,top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                            ]),
                        child: TextField(
                          controller: block,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                ),
                            style: Design.edit_text)),
                  ),
                  Expanded(
                    flex: 6,
                    child:   Container(
                        margin: const EdgeInsets.only(left: 15, right: 15,top: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                            ]),
                        child: TextField(
                          controller: road,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                               ),
                            style: Design.edit_text)),
                  ),
                ],
              ),
            ),
          ],
        ),

        SizedBox(
          height: MediaQuery.of(context).size.height/60,
        ),

        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 15, right: 15),
            child: Text("Delivery Instructions",
                  style: Design.text_title)),
        Container(
             margin: const EdgeInsets.only(left: 20, right: 20,top: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
                ]),
            child: TextField(
              controller: note,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                   ),
               style: Design.edit_text)),

     ])
     ),
          // ),
        Container(
          margin: const EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 15),
          width: double.infinity,
          child:
          ElevatedButton(
            style:
            ElevatedButton.styleFrom(
              backgroundColor:Design.Background_Button_first,
            ),
            child:   Text('Save Address',
                style: Design.Button_first),
            onPressed: () async {
              // send Location
              if (block.text.isEmpty||road.text.isEmpty||flat.text.isEmpty
              ||building.text.isEmpty||note.text.isEmpty) {
                //  if (!WeightCorrect) {
                // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Complete Data Please")));

                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: "  Complete Data Please")
                  ..show();

                return;
                //  }
                //  return;
              }
              Data_User_Regist.write("block",block.text);
              Data_User_Regist.write("road",road.text);
             Data_User_Regist.write("flat",flat.text);
              Data_User_Regist.write("building",building.text);
              Data_User_Regist.write("note",note.text);
              SendLocation();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeliveryAdd(),
                  ));
            },
          ),
        ),
            // Container(
            //   margin: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
            //   width: double.infinity,
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor:Design.Background_Button_second,),
            //     child:   Text('Finish Subscription',
            //         style: Design.Button_first),
            //     onPressed: () async {
            //       new_subscription();
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => subscription()));
            //     },
            //   ),
            // ),
   ])     );
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
