import 'dart:convert';
import 'ClientData.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ConfirmRegistration.dart';
import 'Design.dart';

class Register extends StatefulWidget {
  Register({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<Register> {
  String selectedValue = '+973';
  String images = "assets/images/bahrain.png";
  TextEditingController controller_phone = new TextEditingController();
  TextEditingController controller_Name = new TextEditingController();
  TextEditingController controller_Email = new TextEditingController();
  final Data_User_Regist = GetStorage();
  Map Resulte_otp = Map();
 var isdone;
  @override
  void initState() {
    super.initState();
  }

  _getBackgroundColor() {
    return Container(
        decoration: BoxDecoration(
            color: Design.Background
        )
    );
  }

  Future<bool> Get_MobileCheck(String phone) async {
    var url = "https://appetizingbh.com/mobile_app_api/check_mobile_no.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          "device_id": Data_User_Regist.read("device_id"),
          "mobile_no": phone
          //   "mobile_no":"97333388357"

        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);
    setState(() {
      Resulte_otp = body;
      if (Resulte_otp['status'] == 1) {
        isdone=true;
      } else {
        isdone=false;
      }
    });
    return isdone;
  }
  _getLoginButtons() {
    return <Widget>[
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
          child: Text("Please enter your mobile no.",
            style: Design.text,)),
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
    decoration: BoxDecoration(
    color: Design.color_BoxDecoration,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(
    color: Design.color_BoxShadow, blurRadius: 6, offset: Offset(0, 2))
    ]),
          child: Row(children: [
            Row(children: [
              Container(
                margin: EdgeInsets.only(left: 5),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    customButton: Row(children: [
                      Image(width: 30, height: 30, image: AssetImage(images)),
                      Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(selectedValue)),
                    ]),
                    customItemsHeights: [
                      ...List<double>.filled(MenuItems.firstItems.length, 48),
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
                    // itemHeight: 40,
                    // itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                    dropdownWidth: 250,
                    dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color:Design.Background_Menue,
                    ),
                    dropdownElevation: 8,
                    offset: const Offset(0, 8),
                  ),
                ),
              ),
              Container(
                width: 200,
                child: TextField(
                    controller: controller_phone,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10),
                    ),
                  style: Design.edit_text,),
              )
            ]),
          ])),
      SizedBox(
        height: 30,
      ),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Name",
            style: Design.text,)),
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
    decoration: BoxDecoration(
    color: Design.color_BoxDecoration,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(
    color: Design.color_BoxShadow, blurRadius: 6, offset: Offset(0, 2))
    ]),
          child: TextField(
              controller: controller_Name,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Design.color_icon,
                  )),
              style: Design.edit_text,)),
      SizedBox(
        height: 20,
      ),
      Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Text("Email",
            style: Design.text,)),
      Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
    decoration: BoxDecoration(
    color: Design.color_BoxDecoration,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(
    color: Design.color_BoxShadow, blurRadius: 6, offset: Offset(0, 2))
    ]),
          child: TextField(
              controller: controller_Email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(14),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Design.color_icon,
                  )),
              style: Design.edit_text)),
      Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Design.Background_Button_first,
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0)),
          child:  Text('Next',
              style: Design.Button_first),
          onPressed: () async {
            if (controller_Email.text.isEmpty ||
                controller_Name.text.isEmpty ||
                controller_phone.text.isEmpty) {
              // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(" Please Fill All Data")));
              AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  animType: AnimType.rightSlide,
                  title: "Please Fill All Data")
                ..show();

              return;
            }
            if(controller_phone.text.length<8){
    AwesomeDialog(
    context: context,
    dialogType: DialogType.info,
    animType: AnimType.rightSlide,
    title: "Please Right Mobile Num")
    ..show();

    return;
    }
            var mobile_no;
            if (controller_phone.text.contains("0", 0)) {
              mobile_no = controller_phone.text
                  .substring(1, controller_phone.text.length)
                  .trim();
            } else {
              mobile_no = controller_phone.text;
            }
            var s= selectedValue.substring(1, selectedValue.length).trim() +
                mobile_no;
            bool x= await Get_MobileCheck(s);
            ClientData.Name=controller_Name.text;
            setState(()  {
              x?{
              Data_User_Regist.write("phone", selectedValue + " " + controller_phone.text),
              Data_User_Regist.write("mobile_no",s),
              Data_User_Regist.write("icon_cantry", images),
              // Data_User_Regist.write("name", controller_Name.text),
              Data_User_Regist.write("email", controller_Email.text),
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ConfirmRegistration()))
              }: {
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(Resulte_otp['message'])))
              };
            });

          },
        ),
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
          "New Registration",
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
    MenuItem(text: 'Bahrain',icon:"assets/images/bahrain.png", key: '+973'),
    MenuItem(text: 'Saudi Arabia', icon:"assets/images/saudi-arabia.png", key: '+966'),
    MenuItem(text: 'United Arab Emirates', icon: "assets/images/united-arab-emirates.png", key: '+971'),
    MenuItem(text: 'Oman', icon: "assets/images/oman.png", key: '+968'),
    MenuItem(text: 'Qater', icon: "assets/images/qatar.png", key: '+974'),
    MenuItem(text: 'Kwait',icon: "assets/images/kwait.png", key: '+965')
  ];

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Image(width: 30, height: 30, image: AssetImage(item.icon)),
        const SizedBox(
          width: 10,
        ),
        Text(
          item.text,
          style: const TextStyle(
            color: Color(0xff600505),
          ),
        ),
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
