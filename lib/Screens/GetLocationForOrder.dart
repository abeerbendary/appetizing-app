import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get_storage/get_storage.dart';

import 'Design.dart';
import 'mapViewing.dart';

class GetLocationForOrder extends StatefulWidget {
  //const GetLocationForOrder({Key? key}) : super(key: key);
  @override
  _CurrentLocationScreenState createState() => _CurrentLocationScreenState();
}

class _CurrentLocationScreenState extends State<GetLocationForOrder> {
  Position CurrentLocation;
  CameraPosition _kGooglePlex;
  var lat, lang;
  Set<Marker> _set = {};
  final Data_User_Regist = GetStorage();

  // Completer<GoogleMapController> _controller = Completer();
  GoogleMapController googleMapController;
  Future getPermission() async {
    bool services;
    services = await Geolocator.isLocationServiceEnabled();
    LocationPermission per;
    if (!services) {
      // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Service Not Enabled")));

      AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Service Not Enabled')
        ..show();
    }

    per = await Geolocator.checkPermission();

    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();
      if (per != LocationPermission.denied) {
        // getLatAndLang();
      }
    }
    return per;
  }

  @override
  void initState() {
    // TODO: implement initState
    getPermission();
    getLatAndLang();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
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


     Expanded(child:Column(
       children: [   _kGooglePlex == null
              ? SizedBox( height: MediaQuery.of(context).size.height/1.5,
            width: double.infinity,)
              : Container(

                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: _set,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      // _controller.complete(controller);
                      googleMapController = controller;
                    },
                  ),
            height: MediaQuery.of(context).size.height/1.5,
            width: double.infinity,
                ),
          Container(
            alignment: Alignment.centerLeft,
             margin:EdgeInsets.symmetric(horizontal: 15) ,
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_first,
              ),
              child:  Text(
                'CurrentLocation',
                  style: Design.Button_first
              ),
              onPressed: () async {
                // //  CurrentLocation = await getLatAndLang();
                // //  LatLng latLng=new LatLng(21.422390,30.722958);
                // LatLng latLng = new LatLng(CurrentLocation.latitude, CurrentLocation.longitude);
                //   // print("***************************** ${latLng}");
                // _set.add(Marker(
                //     draggable: true,
                //     onDragEnd: (LatLng lay) {
                //       print("Drag End ${lay}");
                //     },
                //     markerId: MarkerId("1"),
                //     infoWindow: InfoWindow(
                //         title: "CurrentLocation",
                //         onTap: () {
                //           print("currentLocation");
                //         }),
                //     position: LatLng(CurrentLocation.latitude, CurrentLocation.longitude)));
                // googleMapController.animateCamera(CameraUpdate.newLatLng(latLng));
                //  List<Placemark> placemarks = await placemarkFromCoordinates(CurrentLocation.latitude, CurrentLocation.longitude);
                // // print("${placemarks[0].street} ${placemarks[0].name} ");
                // AwesomeDialog(
                //     context: context,
                //     dialogType: DialogType.info,
                //     animType: AnimType.rightSlide,
                //     title: "${placemarks[0].street} ${placemarks[0].name} ")..show();
                //
                // // CurrentLocation = await getLatAndLang();
                // // print("=================");
                // // print(CurrentLocation.latitude);
                // // print(CurrentLocation.longitude);
                // //
                // // List<Placemark> placemarks = await placemarkFromCoordinates(
                // //     CurrentLocation.latitude, CurrentLocation.longitude);
                // //
                // // print("=================");
                // // print("${placemarks[0].street} ${placemarks[0].name} ");
                // // print(CurrentLocation.longitude);
                //
                // // Navigator.push(
                // //     context,
                // //     MaterialPageRoute(builder: (context) => Target()));

                getLatAndLang();
              },
            ),
          ),

  ])),



          Container(
            margin: const EdgeInsets.only(left: 15,right: 15,bottom: 5),
            width: double.infinity,
            child:
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:Design.Background_Button_second,),
              child:  Text('Back',
                  style: Design.Button_first),
              onPressed: () async {

                if(   Data_User_Regist.read("lat").toString().isEmpty && Data_User_Regist.read("lang").toString().isEmpty){

                  // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Complete Data Please")));

                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: "  Complete Data Please")
                    ..show();
                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => mapViewing()));
              },
            ),


          ),

        ],
      ),
    );
  }

  // on load and on current location pressed
  Future getLatAndLang() async {
    CurrentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = CurrentLocation.latitude;
    lang = CurrentLocation.longitude;


    // String name = placeMark.name;
    // String subLocality = placeMark.subLocality;
    // String locality = placeMark.locality;
    // String administrativeArea = placeMark.administrativeArea;
    // String postalCode = placeMark.postalCode;
    // String country = placeMark.country;
    // String address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";
    //

    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lang);
    Data_User_Regist.write("lat", lat);
    Data_User_Regist.write("lang", lang);


    AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: "${placemarks[0].street} ${placemarks[0].name} ")
      ..show();
    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${placemarks[0].street} ${placemarks[0].name} ")));

    // _set.add(Marker(
    //     draggable: true,
    //     onDragEnd: (LatLng lay) {
    //       print("Drag End ${lay}");
    //     },
    //     markerId: MarkerId("1"),
    //     infoWindow: InfoWindow(
    //         title: "CurrentLocation",
    //         onTap: () {
    //           print("currentLocation");
    //         }),
    //     position: LatLng(lat, lang)));
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, lang),
      zoom: 25.25,
    );

    _set.add(Marker(
        draggable: true,
        onDragEnd: (LatLng lay) async {
          print("Drag End ${lay}");

          Data_User_Regist.write("Lat", lay.latitude);
          Data_User_Regist.write("Lang", lay.longitude);
          List<Placemark> placemarks =
              await placemarkFromCoordinates(lay.latitude, lay.longitude);

          AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: "${placemarks[0].street} ${placemarks[0].name} ")
            ..show();
          // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("${placemarks[0].street} ${placemarks[0].name}  ")));
            Data_User_Regist.write("adress", "${placemarks[0].street} ${placemarks[0].name}  ");
        },
        markerId: MarkerId("1"),
        infoWindow: InfoWindow(
            title: "CurrentLocation",
            onTap: () {
              print("currentLocation");
            }),
        position: LatLng(CurrentLocation.latitude, CurrentLocation.longitude)));
    setState(() {});
    //return await Geolocator.getCurrentPosition().then((value) => value);
  }
}
