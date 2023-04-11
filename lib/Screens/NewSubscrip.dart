import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'Design.dart';
import 'Target.dart';
import 'load_fitness.dart';

class NewSubscrip extends StatefulWidget {
  NewSubscrip({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<NewSubscrip> {
  TextEditingController controller_wight = new TextEditingController();
  TextEditingController controller_hight = new TextEditingController();
  final Data_User_Regist = GetStorage();
  bool HeightCorrect = true, WeightCorrect = true;
  @override
  void initState() {
    super.initState();
    controller_wight.text =Data_User_Regist.read("wight");
     controller_hight.text = Data_User_Regist.read("hight");
  }

  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
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
            child: Image(
              image: AssetImage("assets/images/logo.png"),
              width: 150.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Center(
            child: Text(
              "New Subscrip",
              style: Design.Title,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Your Current Weight", style: Design.text),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2))
                        ]),
                    child: TextField(
                        controller: controller_wight,
                        onChanged: (val) {
                          if (int.parse(val) < 30 || int.parse(val) > 300) {
                            print("weight not Real");
                            setState(() {
                              WeightCorrect = false;
                            });
                          } else {
                            WeightCorrect = true;
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.all(14),
                            prefixIcon: Icon(
                              Icons.accessibility,
                              color: Design.color_icon,
                            )),
                        style: Design.edit_text)),
                Center(
                  child: TextButton(
                    child: Text('Weight should be between 30 to 300 kg',
                        style: Design.small_text),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Your Height", style: Design.text),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2))
                      ]),
                  child: TextField(
                      controller: controller_hight,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          // contentPadding: EdgeInsets.all(14),
                          prefixIcon: Icon(
                            Icons.accessibility,
                            color: Design.color_icon,
                          )),
                      onChanged: (val) {
                        if (int.parse(val) < 100 || int.parse(val) > 250) {
                          print("Height not Real");
                          setState(() {
                            HeightCorrect = false;
                          });
                        } else {
                          setState(() {
                            HeightCorrect = true;
                          });
                        }
                      },
                      style: Design.edit_text),
                ),
                Center(
                  child: TextButton(
                    child: Text('Height should be between 100 to 250 cm',
                        style: Design.small_text),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_first,
                //  padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
              ),
              child: Text(
                'Next',
                style: Design.Button_first,
              ),
              onPressed: () async {
                // setState(() {
                  if (!WeightCorrect) {
                   AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: "Weight not Real")
                      ..show();

                    return;
                  }
                  if (!HeightCorrect) {
                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title:"Height not Real")
                      ..show();

                    return;
                  }
                  if(controller_wight.text.toString().isEmpty ||  controller_hight.text.toString().isEmpty){
                    // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(" Complete Data Please")));

                    AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: "  Complete Data Please")
                      ..show();
                    return;
                  }
                  Data_User_Regist.write("wight", controller_wight.text);
                  Data_User_Regist.write("hight", controller_hight.text);
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Target()));
                // });




              },
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_second,
                //    padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
              ),
              child: Text('Back', style: Design.Button_first),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => load_fitness()));
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
