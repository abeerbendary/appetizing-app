import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Design.dart';

class ConfirmRegistration extends StatefulWidget {
  ConfirmRegistration({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<ConfirmRegistration> {
  final Data_User_Regist = GetStorage();
  bool resent = false;
  bool isDisabled = true;

  // TextEditingController text_Otp=new TextEditingController();
  Timer _timer;
  int _start = 60;
  var otp_id_Api;
  var otp_Api;
  Map Resulte_otp = Map();
  OtpFieldController text_Otp = new OtpFieldController();
  String otp;
  Telephony telephony = Telephony.instance;
  String sender;
  OtpFieldController otpbox = OtpFieldController();

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _start = 60;
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            resent = true;
            // _start=10;
            timer.cancel();
          });
        } else {
          setState(() {
            resent = false;
            _start--;
          });
        }
      },
    );
  }

  @override
  Future Get_otp() async {
    var url = "https://appetizingbh.com/mobile_app_api/send_otp.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          "device_id": Data_User_Regist.read("device_id"),
          "mobile_no": Data_User_Regist.read("mobile_no")
          // "device_id":Data_User_Regist.read("device_id"),
          // "mobile_no": '01013971432'
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);
    setState(() {
      Resulte_otp = body;
      if (Resulte_otp['status'] == 1) {
        otp_id_Api = Resulte_otp['data']["otp_id"];
        otp_Api = Resulte_otp['data']["otp"];
        // resent = false;
        // Data_User_Regist.write("otp_id", Resulte_otp['data']["otp_id"]);
        // Data_User_Regist.write("otp", Resulte_otp['data']["otp"]);
        // setState(() {
        //   isDisabled = false;
        // }
        //);
      } else {
        // resent = true;
        // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(Resulte_otp['message'])));
      }
    });
  }

  Future RegisterUser() async {
    http.Response response = await http.post(
      Uri.parse(
          "https://appetizingbh.com/mobile_app_api/register_new_customer.php"),
      body: jsonEncode(
        {
          "api_token": "00QCRTl4MlV",
          "otp": Data_User_Regist.read("otp"),
          "otp_id": Data_User_Regist.read("otp_id"),
          "device_id": Data_User_Regist.read("device_id"),
          "mobile_no": Data_User_Regist.read("mobile_no"),
          "name": Data_User_Regist.read("name"),
          "email": Data_User_Regist.read("email")
        },
      ),
      headers: {"Content-Type": "application/json"},
    );
    var parsed = jsonDecode(response.body);
    Map<String, dynamic> authfailed = {};

    if (parsed['status'] == 1) {
      Data_User_Regist.write("customer_id", parsed['data']['customer_id']);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConfirmRegistration()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(parsed['data']['message'])));
    }
  }

  @override
  void initState() {
    sender=Data_User_Regist.read("sms_sender");
    print(sender);
    Get_otp();
    startTimer();

    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.address); //+977981******67, sender nubmer
        print(message.body); //Your OTP code is 34567
        print(message.date); //1659690242000, timestamp
        String sms = message.body.toString(); //get the message
        // Your OTP is 6342. It expires within 60 seconds. Please do not share this code with anyone else
        // sender name is : APPETIZING
        if (message.address == sender) {
          //verify SMS is sent for OTP with sender number
          String otpcode = sms.replaceAll(new RegExp(r'[^0-9]'), '');

          //prase code from the OTP sms
          text_Otp.set(otpcode.split(""));

          setState(() {
            //refresh UI
          });
        } else {
          print("Normal message.");
        }
      },
      listenInBackground: false,
    );
    super.initState();
  }

  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
  }

  _getLoginButtons() {
    return <Widget>[
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Text("your mobile no.", style: Design.text)),
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          child: Container(
            margin:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(children: [
              Image(
                  width: 30,
                  height: 30,
                  image: AssetImage(Data_User_Regist.read("icon_cantry"))),
              Text(Data_User_Regist.read("phone"),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Design.textColor,
                      wordSpacing: 1))
            ]),
          )),
      SizedBox(
        height: 30,
      ),
      Text(
        _start.toString(),
        style: Design.Button_second,
      ),

      //code
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Mobile Verify Code", style: Design.text)),

      Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.circular(10),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
        //     ]),
        child: OTPTextField(
          controller: text_Otp,
          length: 4,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 50,
          style: TextStyle(fontSize: 17),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.box,
          onCompleted: (pin) {
            otp = pin;
            print("Entered OTP Code: $pin");
          },
        ),
        // Resulte_otp.isEmpty
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : Resulte_otp['status'] == 1 ?
        //     TextField(
        //                 controller: text_Otp,
        //                 keyboardType: TextInputType.number,
        //                 enabled: true,
        //                 decoration: InputDecoration(
        //                     border: InputBorder.none,
        //                     contentPadding: EdgeInsets.all(14),
        //                     ),
        //                 style:Design.edit_text)
        //             // : Center(
        //             //     child: TextButton(
        //             //       child:  Text(
        //             //         'Resend Code',
        //             //         style: Design.small_text,
        //             //       ),
        //             //       onPressed: () {
        //             //         resent = false;
        //             //         Get_otp();
        //             //       },
        //             //     ),
        //             //   )
      ),

      resent
          ? Center(
              child: TextButton(
                child: Text(
                  'Resend Code',
                  style: Design.small_text,
                ),
                onPressed: () {
                  setState(() {
                    // resent = false;
                    startTimer();
                    Get_otp();
                  });
                },
              ),
            )
          : Center(),

      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_first,
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0)),
            child: Text('Confirm & Login', style: Design.Button_first),
            onPressed: () {
              setState(() {
                if(otp==null){
                  // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Birthday Please")));
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: "wait for Otp Code ...")
                    ..show();
                  return;
                }
                if (otp == otp_Api) {
                  Data_User_Regist.write("otp_id", otp_id_Api);
                  Data_User_Regist.write("otp", otp_Api);
                  resent = false;
                  _timer.cancel();
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(Resulte_otp['message'])));
                  RegisterUser();
                } else {
                  // resent = true;
                  // _timer.cancel();
                  text_Otp.set(["","","",""]);
                  otp="";
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(Resulte_otp['message'])));
                }
              });
            },
          )

          // if (isDisabled == true) { return; }
          // setState(() {
          //   RegisterUser();
          // }
          // );

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(builder: (context) => subscription()));
          // },
          // ),
          ),
    ];
  }

  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Image(
          image: AssetImage("assets/images/logo.png"),
          width: 150.0,
        ),
        Text(
          "Login",
          style: Design.Title,
        ),
        // _getDataForLogin(),
        // Spacer(),
        ..._getLoginButtons()
      ],
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
