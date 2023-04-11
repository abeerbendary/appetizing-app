import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'Design.dart';
import 'choosePlanPage.dart';
import 'load_activites.dart';
import 'load_packages.dart';
import 'load_result.dart';

class load_resultes extends StatefulWidget {
  const load_resultes({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<load_resultes> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<load_resultes> {

  List<load_result> _load_result = [
    load_result(id: "56", en_name: "protine", ar_name: "20-100"),
    load_result(id: "99g", en_name: "carbs", ar_name: "20-100"),
    load_result(id: "70g", en_name: "Fat", ar_name: "20-100"),

  ];

  Future getResultes() async {
    var response = await http.get(
        Uri.parse("https://appetizingbh.com/mobile_app_api/load_packages.php"),
        headers: {"Access-Control_Allow_Origin": "*"});

    var res = jsonDecode(response.body);

    print(jsonDecode(response.body));

    setState(() {
      // _load_packages.addAll(res);
    });
    // return _load_activity;
  }

  @override
  void initState() {
    // getResultes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Design.Background,
        body:
        Container(
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height/20,
                      ),
                      //Center()
                      Text(
                          "New Subscrip",
                          style: Design.Title
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/50,
                      ),
                      Text(
                          "Your Resultes",
                          style: Design.text_title
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/50,
                      ),
                      Expanded(

                        //height: 500,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              Card(

                                child: Container(
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color:Design.color_BoxShadow2.withOpacity(0.5), blurRadius: 10.0, offset: Offset(0.0, 0.75))
                                      ]),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.all(15),

                                        child:
                                        Text(
                                            "ncnf fmfnmdsnnfd nfmnfsmnfdmsnfmsn fnmnfmdnfmdmkerekjkrkejrekkejr",
                                            style: Design.text),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 150,
                                        child: Center(
                                            child: SfRadialGauge(
                                              axes: <RadialAxis>[
                                                RadialAxis(
                                                  showLabels: true,
                                                  showTicks: false,
                                                  startAngle: 180,
                                                  endAngle: 0,
                                                  radiusFactor: 1,
                                                  canScaleToFit: true,
                                                  axisLineStyle: AxisLineStyle(
                                                    thickness: 0.2,
                                                    color: const Color.fromARGB(
                                                        30, 0, 169, 180),
                                                    thicknessUnit: GaugeSizeUnit
                                                        .factor,
                                                    cornerStyle: CornerStyle
                                                        .startCurve,
                                                  ),

                                                  pointers: <GaugePointer>[
                                                    RangePointer(
                                                        value: 60.0,
                                                        width: 0.2,
                                                        sizeUnit: GaugeSizeUnit
                                                            .factor,
                                                        cornerStyle: CornerStyle
                                                            .bothCurve)
                                                  ],

                                                )
                                              ],

                                            )
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          "Target Macronutrients Range:",
                                          style:
                                          Design.text_title,
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context).size.height/8,
                                            margin: EdgeInsets.all(15),

                                            child: ListView.separated(
                                              // physics: NeverScrollableScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              separatorBuilder: (context, i) {
                                                return Divider(
                                                  // height: 20,
                                                );
                                              },
                                              shrinkWrap: true,
                                              itemCount: _load_result.length,
                                              itemBuilder: (context, i) {
                                                return Container(
                                                  //height: 60,
                                                   // width: double.,

                                                    decoration: BoxDecoration(

                                                        boxShadow: [
                                                          BoxShadow(
                                                              color:Design.color_BoxShadow2.withOpacity(0.5), blurRadius: 10.0, offset: Offset(0.0, 0.75))
                                                        ]),
                                                    child: Card(
                                                        color: Design.color_BoxShadow2,
                                                        child: Column(
                                                        // mainAxisSize: MainAxisSize.max,
                                                          children: [
                                                            Text(
                                                              "${_load_result[i]
                                                                  .id}",
                                                              style: Design.text_title,
                                                            ),
                                                    //        SizedBox(height: 15,),
                                                            Text(
                                                              "${_load_result[i]
                                                                  .en_name}",
                                                              style: Design.text,
                                                            ),
                                                            Text(
                                                                "${_load_result[i]
                                                                    .ar_name}",
                                                                style: Design.edit_text
                                                            ),

                                                          ],
                                                        )));
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("if you change resulte click on edite",
                                          style: Design.text),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        highlightColor: Design.color_icon,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      load_activites()));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]
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
                                  style: Design.Button_second),
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => load_packages()));
                              }
                          )),
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
                                    builder: (context) => choosePlanPage()));
                          },
                        ),
                      ),

                    ])
            )));
  }
}