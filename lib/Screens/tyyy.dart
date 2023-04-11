import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'Design.dart';
import 'mapViewing.dart';

import 'Uitlits.dart';
import 'catergory.dart';

class tyyy extends StatefulWidget {
  //subscription({  required Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<tyyy> {
  final Data_User_Regist = GetStorage();

  List<days> Days = [
    days(dayName: "Sat"),
    days(dayName: "Sun"),
    days(dayName: "Mon"),
    days(dayName: "Tue"),
    days(dayName: "Wed"),
    days(dayName: "Thru"),
    days(dayName: "Fri"),
  ];
  List AvaiTime = [];
  var valueChoose;
  var delivery_time_id="0";
  List<String> daysnameFull=["saturday","sunday","monday","tuesday","wednesday","thursday","friday"];
  List _selectedIndex = [-1,-1,-1,-1,-1,-1,-1];
  List<String> week=[];
  bool isPressed = false;
  TextEditingController dateInput = TextEditingController();


  @override
  Future fetchData1() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_delivery_time.php";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      setState(() {
        AvaiTime.addAll(body);
      });

      //  print(body);
      // List<Data1> data1=[];
      // for( var item in body){
      //   data1.add(Data1.fromJson(item));
      // }
      // return data1;
    }
  }

  @override
  void initState() {
    fetchData1();
    super.initState();
  }

  _getBackgroundColor() {
    return Container(
      decoration: BoxDecoration(color:Design.Background),
    );
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
              children: [
      SizedBox(
        height: MediaQuery.of(context).size.height/20,
      ),
      //Center()
          Expanded(child:Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "Days & Time",
              style: Design.Title,
            ),
          ),
        ],
      ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(15),
                  child: Text(
                    "Subscription Days",
                    style: Design.text_title,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height/50,

            ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
          height: MediaQuery.of(context).size.height/20,
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
                physics: ScrollPhysics(),
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, i) {
                  return Divider(
                      // height: 20,
                      );
                },
                shrinkWrap: true,
                itemCount: Days.length,
                itemBuilder: (context, i)=>InkWell(onTap: () {
                  setState(() {
                    if(_selectedIndex[i] == i){
                      _selectedIndex[i]= -1;
                    }else{
                      _selectedIndex[i]= i;
                    }
                  });

                },
                        child: Container(
                          width: MediaQuery.of(context).size.width/10,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),

                              color: _selectedIndex.contains(i)  ?
                              Design.color_BoxShadow2 :
                              Design.color_BoxShadow,
                              boxShadow: [
                                // BoxShadow(
                                //     color:  Design.color_BoxShadow2.withOpacity(0.5),
                                //     blurRadius: 10.0, offset: Offset(0.0, 0.75)
                                // )
                              ]),

                          child: Center(
                            child:Column(children: [
                              !_selectedIndex.contains(i)
                                  ? const SizedBox(
                                height: 8,
                              )
                                  :
                              Icon(Icons.check,size: 20,color: Design.color_icon ),
                              Text(
                                Days[i].dayName,
                                style: TextStyle(
                                    color:_selectedIndex.contains(i)  ?
                                    Design.color_icon :
                                    Design.textColor,
                                    ),
                              ),
                            ] ),
                          ),
                        ),

              ),
  )
      ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(14),
                  child: Text(
                    "5 Day Minimam",
                    style: Design.text,
                  ),
                ),
              ],
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height/50,
          ),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
         // padding: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          color:  Design.color_BoxShadow2,
           ),
          height: MediaQuery.of(context).size.height/15,
    padding: EdgeInsets.all(15),

    child: Center(
    child: TextField(
      style: Design.text,
    controller: dateInput,
    //editing controller of this TextField
    decoration: InputDecoration(
      border: InputBorder.none,
    icon: Icon(Icons.calendar_today,color: Design.color_icon), //icon of text field
      //label text of field
    ),
    readOnly: true,
    //set it true, so that user will not able to edit text
    onTap: () async {
    DateTime pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    //DateTime.now() - not to allow to choose before today.
    lastDate: DateTime(2025));

    if (pickedDate != null) {
    print(
    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    print(
    formattedDate); //formatted date output using intl package =>  2021-03-16
    setState(() {
    dateInput.text =
    formattedDate; //set output date to TextField value.
    });
    } else {}
    },
    ))),
          SizedBox(
            height: MediaQuery.of(context).size.height/15,
          ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 15),
              // padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color:  Design.color_BoxShadow2,
              ),
              height: MediaQuery.of(context).size.height/15,
              padding: EdgeInsets.all(15),
         child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              hint: Text('Choose Time Delivery',
                style: Design.small_text2,
              ),

              items: AvaiTime
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item['en_name'],
                    child: Text(
                      item['en_name'],
                      style: Design.small_text2,
                    ),
                  ))
                  .toList(),
              value: valueChoose,
              onChanged: (value) {
                setState(() {
                  valueChoose = value as String;

                  // print(delivery_time_id);
                });
              },
              buttonHeight:  MediaQuery.of(context).size.height/15,
              buttonWidth: 140,
              itemHeight: 50,
            ),
          ),
        ),
            SizedBox(
              height:  MediaQuery.of(context).size.height/20,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Text('you can alwaysyou can alwaysyou can alwaysyou can alwaysyou can alwaysyou can alwaysyou can always',
                  style: Design.text,),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                child:Text('Total Amount: 35 BHD',
                  style:Design.text_title) ) ],
          )),


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
                style: Design.Button_first
            ),
                  onPressed: () async {
                    Data_User_Regist.write("start_date",dateInput.text);
                    Data_User_Regist.write("delivery_time_id",delivery_time_id);
                    for(int i=0;i<_selectedIndex.length;i++){
                      if (_selectedIndex[i]!=-1){
                        week.add(daysnameFull[i]);
                      }
                    }
                    for(int x=0; x<AvaiTime.length;x++){
                      if(AvaiTime[x]['en_name']==valueChoose){
                        // print(x);
                        delivery_time_id=AvaiTime[x]['id'];
                        // print(delivery_time_id);
                      }
                    }

                    if(Data_User_Regist.read("start_date").toString().isEmpty||
                        Data_User_Regist.read("delivery_time_id").toString().isEmpty
                      ||week.isEmpty
                    ){
                      // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Complete Data Please")));

                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.rightSlide,
                          title: "  Complete Data Please")
                        ..show();
                      return;
                    }
                    Data_User_Regist.write("week",week);
                    Data_User_Regist.write("delivery_time_id", delivery_time_id);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => mapViewing()));
                  },
                ),
              ),

          /////////////////////////////////////////
    ]));

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

class days {
  String dayName;

  days({this.dayName});
}
