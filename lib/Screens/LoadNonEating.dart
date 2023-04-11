import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Design.dart';
import 'choosePlanPage.dart';
import 'load_activites.dart';
import 'load_chronic_diseases.dart';

class LoadNonEating extends StatefulWidget {
  LoadNonEating({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<LoadNonEating> {
  List nonEatableList = [];
  final Data_User_Regist = GetStorage();
  List<int> non_eat_ids = [];
  List _selectedIndex = [];
  bool isMultiSelectionEnabled = false;
  HashSet selectItems = new HashSet();

  @override
  Future fetchData() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_non_eatable.php";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      setState(() {
        nonEatableList.addAll(body);
        if(_selectedIndex==null) {
          _selectedIndex =
              List.filled(nonEatableList.length, -1, growable: false);
        }

      });
    }
  }

  @override
  void initState() {
    _selectedIndex=Data_User_Regist.read("_selectedIndex_NonEat");
    print(_selectedIndex);
    fetchData();
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Container(
            // height: 80,
            margin: EdgeInsets.all(15),
            child: Text(
              'What do you not eat ?',
              style: Design.text_title

            )),
        // Expanded(child:
        Container(
             height: 540,
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child:nonEatableList==null||nonEatableList.isEmpty?
            Center(child: CircularProgressIndicator(),):
            GridView.builder(
              shrinkWrap: true,
                itemCount: nonEatableList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, i) => InkWell(
                      onTap: () {
                        setState(() {
                          if (_selectedIndex[i] == i) {
                            _selectedIndex[i] = -1;
                          } else {
                            _selectedIndex[i] = i;
                          }
                        });

                      },
                      child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: _selectedIndex.contains(i)
                                  ? Design.color_BoxShadow2:Design.Background,
                              border: Border.all(
                                color:Design.color_icon,
                                width: 0.3,
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              !_selectedIndex.contains(i)
                                  ? const SizedBox.shrink()
                                  :
                              Icon(Icons.check),

                              Image(
                                image: NetworkImage(
                                    nonEatableList[i]['image_path']),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(nonEatableList[i]['en_name'],
                                      style: Design.text
                                  )
                              )
                            ],
                          )

                          //
                          ),
                    ))),
        // ),
        // Spacer(),
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
                  for(int i=0;i<_selectedIndex.length;i++){
                    if (_selectedIndex[i]!=-1){
                      non_eat_ids.add(int.parse(nonEatableList[i]["id"]));
                      // week.add(i+1);
                    }
                  }
                Data_User_Regist.write("non_eatable", non_eat_ids);
                  Data_User_Regist.write("_selectedIndex_NonEat",_selectedIndex);
         print( Data_User_Regist.read("_selectedIndex_NonEat"));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>load_chronic_diseases()));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => load_activites()));
            },
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
