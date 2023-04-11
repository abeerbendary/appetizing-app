import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

import 'Design.dart';
import 'NewSubscrip.dart';
import 'subscription.dart';

class load_fitness extends StatefulWidget {
  _fitnessState createState() => _fitnessState();
}

class _fitnessState extends State<load_fitness> {
  TextEditingController controller_Subscribtion_name =
      new TextEditingController();
  String id_list_fitness;
  int index_list_fitness = -1;
  final Data_User_Regist = GetStorage();
  List _load_fitness_List = [];

  @override
  Future fetchData1() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_fitness.php";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      setState(() {
        _load_fitness_List.addAll(body);
      });
    }
  }

  @override
  void initState() {
    fetchData1();
    super.initState();
    index_list_fitness = Data_User_Regist.read("index_list_fitness");
    controller_Subscribtion_name.text =
        Data_User_Regist.read("Subscribtion_name");
  }

  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
  }

  _getContent(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.0,
          ),
          //Center()
          //  Padding(padding: const EdgeInsets.symmetric(horizontal: 25)),

          Text(
            "New Subscrip",
            style: Design.Title,
          ),
          SizedBox(
            height: 25.0,
          ),
          TextField(
            controller: controller_Subscribtion_name,
            style: Design.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Please Enter Subscription Name',
              hintStyle: Design.edit_text,
              hintText: 'Subscription Name',
            ),
            autofocus: false,
          ),

          SizedBox(
            height: 15.0,
          ),
          Text("What is your fitness goals ?", style: Design.Title2),

          Expanded(
            child: _load_fitness_List==null||_load_fitness_List.isEmpty?
            Center(child: CircularProgressIndicator(),):
            ListView.separated(
                // physics: NeverScrollableScrollPhysics(),
                separatorBuilder: (context, i) {
                  return Divider(
                      // height: 20,
                      );
                },
                shrinkWrap: true,
                itemCount: _load_fitness_List.length,
                itemBuilder: (context, i) => InkWell(
                    onTap: () {
                      // setState(() {
                      //
                      // });
                      id_list_fitness = _load_fitness_List[i]["id"];
                      index_list_fitness = i;
                      final validCharacters = RegExp(r'[=@;$%&!#]');

                      if (controller_Subscribtion_name.text.toString().isEmpty||validCharacters.hasMatch(controller_Subscribtion_name.text)) {
                        // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Valid Name Please")));
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: "  Enter Valid Data Please")
                          ..show();
                        return;
                      }

                      Data_User_Regist.write(
                          "id_list_fitness", id_list_fitness);
                      Data_User_Regist.write(
                          "index_list_fitness", index_list_fitness);
                      Data_User_Regist.write("Subscribtion_name",
                          controller_Subscribtion_name.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewSubscrip()));
                    },
                    child: Container(
                        //height: 60,
                        decoration: BoxDecoration(
                            // color: Color(0xfff000ff),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      Design.color_BoxShadow2.withOpacity(0.5),
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 0.75))
                            ]),
                        //        width: double.infinity,

                        child: Card(
                          // margin: EdgeInsets.symmetric(horizontal: 20),
                          color: (index_list_fitness == i)
                              ? Design.color_BoxShadow2
                              : Design.Background,

                          child: Container(
                            // padding: EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                ListTile(
                                  leading: Image(
                                    image: NetworkImage(
                                        _load_fitness_List[i]['image_path']),
                                    width: 70.0,
                                    height: 70.0,
                                    // alignment: Alignment.center,
                                  ),
                                  title: Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Text(
                                      _load_fitness_List[i]['en_name'],
                                      style: Design.text_title,
                                    ),
                                  ),
                                  subtitle: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Flexible(
                                          child: Text(
                                        _load_fitness_List[i]['en_desc'],
                                        style: Design.text,
                                      ))),
                                ),
                              ],
                            ),
                          ),
                        )))),
          ),
          //with last apdate
          // Container(
          //   margin: const EdgeInsets.only(top: 15,left: 15,right: 15,bottom: 5),
          //   width: double.infinity,
          //   child:
          //   ElevatedButton(
          //     style:
          //     ElevatedButton.styleFrom(
          //       backgroundColor:Design.Background_Button_first,
          //     ),
          //     child:   Text('Next',
          //         style: Design.Button_first),
          //     onPressed: () async {
          //
          //       final validCharacters = RegExp(r'[=@;$%&!#]');
          //
          //       if(validCharacters.hasMatch( controller_Subscribtion_name.text)
          //       ){
          //         // ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text("Enter Valid Name Please")));
          //         AwesomeDialog(
          //             context: context,
          //             dialogType: DialogType.info,
          //             animType: AnimType.rightSlide,
          //             title: "  Enter Valid Data Please")
          //           ..show();
          //         return;
          //       }
          //       Data_User_Regist.write("id_list_fitness", id_list_fitness);
          //       Data_User_Regist.write("index_list_fitness",index_list_fitness);
          //       Data_User_Regist.write("Subscribtion_name", controller_Subscribtion_name.text);
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => NewSubscrip()));
          //     },
          //   ),
          // ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(15),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_second,
                // padding:  const EdgeInsets.only(top: 15.0, bottom: 15.0)
              ),
              child: Text(
                'Back',
                style: Design.Button_first,
              ),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => subscription()));
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
            _getContent(context),
          ],
        ),
      ),
    );
  }
}
