
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import 'Design.dart';
import 'GenderType.dart';
import 'Target.dart';

class BirthDay extends StatefulWidget {
  BirthDay({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}
class _SignInState extends State<BirthDay> {
  final Data_User_Regist = GetStorage();
  DateTime dateTime=DateTime.now();
  String Birthday_Date=DateFormat('yyyy-MM-dd').format(DateTime.now());
  DateTime getinite(){
    dateTime=Data_User_Regist.read("dateTime");
    if(dateTime==null) {
      dateTime = DateTime.now();
    }
    return dateTime;
  }
  @override
  void initState() {

    setState(() {
      dateTime=Data_User_Regist.read("dateTime");
      print(dateTime);
    });
    super.initState();


  }
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
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          Center(
            child:   Image(
              image: AssetImage("assets/images/logo.png"),
              width: 150.0,
            ),),

          SizedBox(
            height: 25.0,
          ),


         Expanded(child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
              children:[
                Text(
                  "When is your birthday ?",
                  style:Design.text_title,
                ),
                SizedBox(
                  height: 25.0,
                ),

                  Container(
                    margin: EdgeInsets.only(left: 15,right: 15),
                   color: Color(0xffD6D6D6).withOpacity(0.4),
                    child: CalendarDatePicker(
                        initialDate: getinite(),
                        firstDate: DateTime(1970, 1),
                        lastDate: DateTime(2100,12),
                        currentDate: dateTime,
                        onDateChanged: (newDate){
                          setState(() {
                            Birthday_Date=DateFormat('yyyy-MM-dd').format(newDate);
                            Data_User_Regist.write("dateTime", newDate);
                          });

                        }

                    ),
                  ),


              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 5),
            width: double.infinity,
            child:
            ElevatedButton(
              style:
              ElevatedButton.styleFrom(
                  backgroundColor:Design.Background_Button_first,
),
              child:   Text('Next',
                  style: Design.Button_first),
              onPressed: () async {
                setState(() {
                  Data_User_Regist.write("BirthDay", Birthday_Date);

                });
                if (DateTime.parse(Birthday_Date).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) == 0)
{
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: "enter right date")
                    ..show();

                  return;
                }
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GenderType()));
              },
            ),
          ),
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
                 if(   Data_User_Regist.read("BirthDay").toString().isEmpty){
                   // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Birthday Please")));

                   AwesomeDialog(
                       context: context,
                       dialogType: DialogType.info,
                       animType: AnimType.rightSlide,
                       title: "Enter Birthday Please")
                     ..show();
                   return;
                 }
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => Target()));
              },
            ),
          ),
        ],
      ),
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
