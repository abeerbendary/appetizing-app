import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'BirthDay.dart';
import 'Design.dart';
import 'NewSubscrip.dart';

class Target extends StatefulWidget {
  Target({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<Target> {
  TextEditingController controller_Target = new TextEditingController();
  final Data_User_Regist = GetStorage();
  bool WeightCorrect = true;

  @override
  void initState() {
    super.initState();
    controller_Target.text =Data_User_Regist.read("Target");

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
          SizedBox(
            height: 10.0,
          ),
          Text("New Subscrip", style: Design.Title),
          SizedBox(
            height: 15.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Target Weight", style: Design.text),
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
                        controller: controller_Target,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.all(14),
                            prefixIcon: Icon(
                              Icons.accessibility,
                              color: Design.color_icon,
                            )),
                        onChanged: (val) {
                          if (int.parse(val) < 30 || int.parse(val) > 300) {
                            print("weight not Real");
                            setState(() {
                              WeightCorrect = false;
                            });
                          }
                          else{
                            setState(() {
                              WeightCorrect = true;
                            });
                          }
                        },
                        style: Design.edit_text)),
                Center(
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                        // padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
                        ),
                    child: Text('Weight should be between 30 to 300 kg',
                        style: Design.small_text),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_first,
                //    padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
              ),
              child: Text('Next', style: Design.Button_first),
              onPressed: () async {
                if (!WeightCorrect) {
                  // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Weight not Real")));

                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: "Weight not Real")
                    ..show();

                  return;
                }
                if(controller_Target.text.isEmpty){
                  // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Complete Data Please")));
                  //
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: "  Complete Data Please")
                    ..show();
                  return;
                }
                Data_User_Regist.write("Target", controller_Target.text);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BirthDay()));
              },
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_second,
                //    padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
              ),
              child: Text('Back', style: Design.Button_first),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewSubscrip()));
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
