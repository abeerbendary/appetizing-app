import 'dart:async';

import 'package:appetizing/Screens/Image_Analysis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:get_storage/get_storage.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Design.dart';
import 'Image_Analysistwo.dart';
import 'Logins.dart';
import 'Register.dart';

class Login extends StatefulWidget {
  Login({ Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<Login> {
  VideoPlayerController _controller;
  bool _visible = false;
  final Data_User_Regist = GetStorage();
  // bool _visible = false;
  var percent=0;
  List _load_color=[];
  Color balck;
  Future getActivites() async {
    var response = await http.get(
        Uri.parse("https://appetizingbh.com/mobile_app_api/get_app_settings.php"),
        headers: {"Access-Control_Allow_Origin": "*"});

    var res = jsonDecode(response.body);
    _load_color.add(res);

/////////////////
    Design.Background= covertRgbaToColor(_load_color[0][0]['Background']);
    Design.Background_Menue= covertRgbaToColor(_load_color[0][0]['Background_Menue']);
    Design.color_icon= covertRgbaToColor(_load_color[0][0]['color_icon']);
    Design.color_BoxShadow= covertRgbaToColor(_load_color[0][0]['color_BoxShadow']);
    Design.color_BoxDecoration= covertRgbaToColor(_load_color[0][0]['color_BoxDecoration']);
    Design.Background_Button_first= covertRgbaToColor(_load_color[0][0]['Background_Button_first']);
    Design.Background_Button_second= covertRgbaToColor(_load_color[0][0]['Background_Button_second']);
    Design.Button_firstColor= covertRgbaToColor(_load_color[0][0]['Button_first']);
    Design.Button_SecondColor= covertRgbaToColor(_load_color[0][0]['Button_second']);
    Design.TitleColor= covertRgbaToColor(_load_color[0][0]['Title']);
    Design.textColor= covertRgbaToColor(_load_color[0][0]['text']);
    Design.edit_textColor= covertRgbaToColor(_load_color[0][0]['text']);
    Design.small_textColor= covertRgbaToColor(_load_color[0][0]['text']);
    Data_User_Regist.write("sms_sender", _load_color[0][0]['sms_sender']);
    Data_User_Regist.write("color", true);
////////////////

    //
    //Data_User_Regist.write("Background",covertRgbaToColor(_load_color[0]['color_BoxShadow']));

    // return _load_activity;
  }
  Color covertRgbaToColor(String colorStr){

    List rgbaList = colorStr.substring(5, colorStr.length - 1).split(",");
    return Color.fromRGBO(
        int.parse(rgbaList[0]), int.parse(rgbaList[1]), int.parse(rgbaList[2]), double.parse(rgbaList[3]));

  }
  @override
  void initState() {
     // Data_User_Regist.read("color");
    getUniqueDeviceId();
    super.initState();
      setState(() {
        getActivites();
      });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _controller = VideoPlayerController.asset("assets/videos/login.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(false); Timer timer;
      timer = Timer.periodic(Duration(milliseconds:100),(_){
        setState(() {
          _controller.play();
          _visible = true;
          percent+=1;
          //500
          if(percent >= 100){
            timer.cancel();
            Navigator.push(context,
             MaterialPageRoute(builder: (context) => Logins()));
              // MaterialPageRoute(builder: (context) => Image_Analysistwo()));
            // percent=0;
          }
        });
      });

      // Timer(Duration(milliseconds: 100), () {
      //   setState(() {
      //     _controller.play();
      //
      //     // _visible = true;
      //   });
      // });
    });

  }
// get device id
  Future getUniqueDeviceId() async {
    String uniqueDeviceId = '';

    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      uniqueDeviceId = '${iosDeviceInfo.identifierForVendor}'; // unique ID on iOS
    } else if(Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      uniqueDeviceId = '${androidDeviceInfo.id}' ; // unique ID on Android
    }
    Data_User_Regist.write("device_id", uniqueDeviceId);
    print(Data_User_Regist.read("device_id"));
  }
  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      // _controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(
      color: Color(0xffffffff).withAlpha(70),
    );
  }

  _getLoginButtons() {
    return <Widget
    >[
    //   Visibility(
    //     visible: _visible,
    //
    //      child:Container(
    //       margin: const EdgeInsets.only(left: 20, right: 20,top: 300),
    //       width: double.infinity,
    //       child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //          //  backgroundColor:Design.Background_Button_first ,
    //             backgroundColor:Color.fromRGBO(160, 10, 39, 0.95) ,
    //             padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
    //         ),
    //         child:   Text('Login',
    //           style: Design.Button_first,
    //         )
    //         ,
    //         onPressed: () async {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => Logins()),
    //           );
    //         },
    //       ),
    //     ),),
    // Visibility(
    // visible: _visible,
    //    child: Container(
    //       margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
    //       width: double.infinity,
    //       child: ElevatedButton(
    //         style: ElevatedButton.styleFrom(
    //           // backgroundColor:Color.fromARGB(120, 255, 0, 0),
    //             // backgroundColor:Design.Background_Button_second ,
    //             backgroundColor: Color.fromRGBO(228, 239, 11, 0.98),
    //             padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
    //         ),
    //         child:   Text(
    //           'Register New',
    //           style: Design.Button_first,
    //         ),
    //         onPressed: () async {
    //           Navigator.push(
    //             context,
    //             MaterialPageRoute(builder: (context) => Register()),
    //           );
    //         },
    //       ),
    //     ),
    // ),
    Container(
    margin: const EdgeInsets.only(bottom: 16, top: 20, left: 5, right: 5),
    width: MediaQuery.of(context).size.width/1.1,
    child:LinearPercentIndicator(
    barRadius: Radius.circular(50),
    width: MediaQuery.of(context).size.width/1.1,
    animation: true,
    lineHeight: 20.0,
    animationDuration: 10000,
    percent:1.0 ,
    center: Text( percent.toString() + "%",style: Design.Button_second,),
    linearStrokeCap: LinearStrokeCap.roundAll,
    progressColor: Color(0xff600505),
    )),
    ];
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[

        SizedBox(
          height: 100.0,
        ),
        Image(
          image: AssetImage("assets/images/logo.png"),
          width: 150.0,
        ),
        Spacer(),
        ..._getLoginButtons()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    );
  }
}
