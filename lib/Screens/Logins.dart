import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:telephony/telephony.dart';
import 'Design.dart';
import 'Register.dart';
import 'subscription.dart';

class Logins extends StatefulWidget {
  Logins({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<Logins> {
  final Data_User_Regist = GetStorage();
  bool resent = false;
  bool isDisabled = true;
  String selectedValue = '+973';
  String images = "assets/images/bahrain.png";
  TextEditingController mobile = new TextEditingController();
  OtpFieldController text_Otp = new OtpFieldController();
  // TextEditingController text_Otp = new TextEditingController();
  Timer _timer;
  int _start = 60;
  var otp_id_Api;
  var otp_Api;
  var isvisbletime = false;
  var isvisbleSend = true;
  Map Resulte_otp = Map();
 String otp;
 String sender;
  Telephony telephony = Telephony.instance;
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
          //  "mobile_no":"01013971432"
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

  Future loginUser() async {
//
// var c=Data_User_Regist.read("otp_id");
// var cc=Data_User_Regist.read("otp");

    http.Response response = await http.post(
      Uri.parse("https://appetizingbh.com/mobile_app_api/customer_login.php"),
      body: jsonEncode(
        {
          "api_token": "00QCRTl4MlV",
          "otp": Data_User_Regist.read("otp"),
          "otp_id": Data_User_Regist.read("otp_id"),
          "device_id": Data_User_Regist.read("device_id"),
          "mobile_no": Data_User_Regist.read("mobile_no")
          // "mobile_no":"01013971432"
        },
      ),
      headers: {"Content-Type": "application/json"},
    );
    var parsed = jsonDecode(response.body);
    Map<String, dynamic> authfailed = {};
    if (parsed['status'] == 1) {
      Data_User_Regist.write('customer_id', parsed['data']['id']);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => subscription()),
      );
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(parsed['message'])));
    }
  }

  @override
  void initState() {
    sender=Data_User_Regist.read("sms_sender");
    print(sender);
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
      Expanded(
          child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Please enter your mobile no.",
                style: Design.text,
              ),
              Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  decoration: BoxDecoration(
                      color: Design.color_BoxDecoration,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Design.color_BoxShadow,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ]),
                  child: Row(children: [
                    Row(children: [
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            customButton: Row(children: [
                              Image(
                                  width: 30,
                                  height: 30,
                                  image: AssetImage(images)),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                    selectedValue,
                                    style: Design.edit_text,
                                  )),
                            ]),
                            customItemsHeights: [
                              ...List<double>.filled(
                                  MenuItems.firstItems.length, 48),
                            ],
                            items: [
                              ...MenuItems.firstItems.map(
                                (item) => DropdownMenuItem<MenuItem>(
                                  value: item,
                                  child: MenuItems.buildItem(item),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.key as String;
                                images = value.icon as String;
                              });
                            },
                            // itemHeight: 30,
                            // itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                            dropdownWidth: 250,
                            dropdownPadding:
                                const EdgeInsets.symmetric(vertical: 6),
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: Design.Background_Menue,
                            ),
                            dropdownElevation: 8,
                            offset: const Offset(0, 8),
                          ),
                        ),
                      ),
                      Container(
                        width: 200,
                        child:
                        TextField(
                          controller: mobile,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          style: Design.edit_text,
                        ),
                      )
                    ]),
                  ])),
              // SizedBox(
              //   height: 30,
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Visibility(
            visible: isvisbleSend,
            child: Center(
              child: TextButton(
                child: Text(
                  "Send Code",
                  style: Design.small_text,
                ),
                onPressed: () {
                  // print(text_Otp.toString());
                  if(mobile.text.isEmpty||mobile.text.length<8){
                    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Birthday Please")));
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: "Enter Mobile Num")
                      ..show();
                    return;
                  }
                  var mobile_no;
                  if (mobile.text.contains("0", 0)) {
                    mobile_no =
                        mobile.text.substring(1, mobile.text.length).trim();
                  } else {
                    mobile_no = mobile.text;
                  }
                Data_User_Regist.write("mobile_no", "01013971432");
               //    Data_User_Regist.write("mobile_no", selectedValue.substring(1,selectedValue.length).trim()+ mobile_no);
                  print(Data_User_Regist.read("mobile_no"));
                  setState(() {
                    Get_otp();
                    isvisbletime = true;
                    isvisbleSend = false;
                    startTimer();
                  });
                },
              ),
            )),
        Visibility(
          visible: isvisbletime,
          child: Text(
            _start.toString(),
            style: Design.text,
          ),
        ),
        //code
        Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              "Mobile Verify Code",
              style: Design.text,
            )),

        Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            // decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(10),
            //     boxShadow: [
            //       BoxShadow(
            //           color: Colors.black26,
            //           blurRadius: 6,
            //           offset: Offset(0, 2))
            //     ]),
            child:
            OTPTextField(
              controller: text_Otp,
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              style: Design.edit_text,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                otp=pin;
                print("Entered OTP Code: $pin");
              },
            ),
            // : Center(
            //     child: TextButton(
            //       child:  Text(
            //         'Resend Code',
            //         style: Design.small_text,
            //       ),
            //       onPressed: () {
            //         resent = false;
            //         Get_otp();
            //       },
            //     ),
            //   )
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
                print(otp);
                // print(text_Otp.toString());
                setState(() {
                  if(mobile.text.isEmpty){
                    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Birthday Please")));
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: "Enter Mobile Num")
                      ..show();
                    return;
                  }
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
                    loginUser();
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
      ])),
      TextButton(
        child: Text(
          "Create New Account",
          style: Design.small_text,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Register()),
          );
        },
      )
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

class MenuItem {
  final String text;
  final String icon;
  final String key;

  const MenuItem({
    this.text,
    this.icon,
    this.key,
  });
}

class MenuItems {
  static const List<MenuItem> firstItems = [
    MenuItem(text: 'Bahrain', icon: "assets/images/bahrain.png", key: '+973'),
    MenuItem(
        text: 'Saudi Arabia',
        icon: "assets/images/saudi-arabia.png",
        key: '+966'),
    MenuItem(
        text: 'United Arab Emirates',
        icon: "assets/images/united-arab-emirates.png",
        key: '+971'),
    MenuItem(text: 'Oman', icon: "assets/images/oman.png", key: '+968'),
    MenuItem(text: 'Qater', icon: "assets/images/qatar.png", key: '+974'),
    MenuItem(text: 'Kwait', icon: "assets/images/kwait.png", key: '+965')
  ];

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Image(width: 30, height: 30, image: AssetImage(item.icon)),
        const SizedBox(
          width: 10,
        ),
        Text(item.text, style: Design.text),
      ],
    );
  }

// static onChanged(BuildContext context, MenuItem item) {
//   switch (item) {
//     case MenuItems.home:
//       //Do something
//       break;
//     case MenuItems.settings:
//       //Do something
//       break;
//     case MenuItems.share:
//       //Do something
//       break;
//     case MenuItems.logout:
//       //Do something
//       break;
//   }
// }
}
