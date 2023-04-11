import 'dart:async';
import 'dart:convert';

import 'package:appetizing/Screens/Freez.dart';
import 'package:appetizing/Screens/MainMeun.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'AdressCustomer.dart';
import 'HistoryMenueDay.dart';
import 'CurrentSubr.dart';
import 'DataForAllDays.dart';
import 'DataForItems.dart';
import 'Design.dart';
import 'MenuData.dart';
import 'OldSubscriptionData.dart';
import 'subscription.dart';

class HistoryMenueDay extends StatefulWidget {
  HistoryMenueDay({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<HistoryMenueDay> {
  //List _selectedIndex = [];
 int _selectedIndex=-1;
  List menu_types = [];
  List rate = [];

  List favorite = [];

  //List<DataForItems>ChooseList;
  var valueChoose;

  // List<AdressCustomer> customer_address = [];
  List customer_address = [];
  List<DataForAllDays> ActiveDays = [];
 DataForAllDays datamenu;
  List<DataForAllDays> All = [];
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  bool is_visbale=false;
  List ChoosenDays = [];
  int count;
  int Address_id;
  String AddressNam="";
  List<MenuData> menues = [];
  int selected = -1;
  final Data_User_Regist = GetStorage();
  List dataDate = [];
  List<Map<String, dynamic>> dataMenue = [];
  Map<String, String> dates = new Map();
  Map<String, dynamic> menu = new Map();

  @override
  Future load_customer_addess() async {
    var url =
        "https://appetizingbh.com/mobile_app_api/load_customer_address.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          "device_id": Data_User_Regist.read("device_id"),
            //"customer_id": "5",
          "customer_id": Data_User_Regist.read("customer_id")
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);
     setState(() {
    customer_address.addAll(body);

     });
  }

  @override
  Future load_menu_types() async {
    var url =
        "https://appetizingbh.com/mobile_app_api/load_subscription_menu_types.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          "device_id": "F1BTPG3",
          "package_id": "1"
          //   "package_id": CurrentSubr.CurrentSub['package_id']
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);
    setState(() {
      menu_types.addAll(body['data']);
    });
  }

  @override
  Future load_ActiveDays() async {
    var url1 =
        "https://appetizingbh.com/mobile_app_api/load_subscription_all_days.php";
    http.Response response1 = await http.post(Uri.parse(url1),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          "device_id": "F1BTPG3",
          //"subscription_id": CurrentSubr.CurrentSub['id']
          "subscription_id": "104"
        }));
    var body1;
    if (response1.body.isNotEmpty) {
      body1 = jsonDecode(response1.body);
    }
    setState(() {
      var tagObjsJson = body1['data'] as List;

      All = tagObjsJson
          .map((tagJson) => DataForAllDays.fromJson(tagJson))
          .toList();
      ActiveDays.addAll(All.where((element) =>
          DateTime.parse(element.ondate).compareTo(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) <
          0));
      // if (_selectedIndex == null || _selectedIndex.isEmpty) {
      //   _selectedIndex = List.filled(ActiveDays.length, -1, growable: false);
      // }

      print(ActiveDays);
      //ActiveDays.addAll(body1['data'].where((o) => o['menu'].length==0).first['ondate']);
      //print(ActiveDays[0]['ondate'];
      //  lights.firstWhere((x) => x['id'] == searchId, orElse:() => {"color" : "Color Not found"})['color'];
      print(ActiveDays.length);
    });
  }

  @override
  Future update_subscription_date(List<Map<String, dynamic>> dates,
      List<Map<String, dynamic>> menue) async {
    var url1 =
        "https://appetizingbh.com/mobile_app_api/update_subscription_date.php";
    print("******************");
    print(jsonEncode(<String, dynamic>{
      "api_token": "00QCRTl4MlV",
      "device_id": "F1BTPG3",
       "subscription_id": CurrentSubr.CurrentSub['id'],
       "package_id": CurrentSubr.CurrentSub['package_id'],
      "schedule_date": dates,
      "address_id":Address_id,
      "menu": menue
    }));
    http.Response response1 = await http.post(Uri.parse(url1),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "api_token": "00QCRTl4MlV",
          "device_id": "F1BTPG3",
          "subscription_id": CurrentSubr.CurrentSub['id'],
          "package_id": CurrentSubr.CurrentSub['package_id'],
          "schedule_date": dates,
          "address_id":Address_id,
          "menu": menue
        }));
    var body1;
    if (response1.body.isNotEmpty) {
      body1 = jsonDecode(response1.body);
    }
  }

  @override
  void initState() {
    setState(() {
      load_menu_types();
      load_customer_addess();
      load_ActiveDays();
    });
    super.initState();
  }

  _getBackgroundColor() {
    return Container(decoration: BoxDecoration(color: Design.Background));
  }

  _getAppBar() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      // "Menu",
                       "History for "+"${CurrentSubr.CurrentSub['package_en_name']}",
                      style: Design.Title,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            //design1
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: MediaQuery.of(context).size.height / 15,
              width: MediaQuery.of(context).size.width,
              child:ActiveDays==null||ActiveDays.isEmpty?
              Center(child: Text("No dayes history")):
              ScrollablePositionedList.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ActiveDays.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          setState(() {
                            //
                            if (_selectedIndex == i) {
                              _selectedIndex = -1;
                              dataDate.removeAt(0);
                            } else {
                              _selectedIndex = i;
                              dataDate.insert(0,ActiveDays[i].ondate.toString());
                              datamenu=ActiveDays[i];
                              Address_id=int.parse(ActiveDays[i].address_id);
                              AddressNam=customer_address[customer_address.indexWhere((element) => element['id'] ==Address_id.toString())]['note'];
                            }
                              if (dataDate.length > 0) {
                                is_visbale = true;
                              } else {
                                is_visbale = false;
                              }

                          });
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // width: MediaQuery.of(context).size.width / 2,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xffececec),
                                border: Border(
                                  // right: BorderSide(width: 2.0, color:Design.color_icon),
                                  bottom: BorderSide(
                                      width: 3.0,
                                      color: _selectedIndex==i
                                          ? Design.color_icon
                                          : Colors.white),
                                ),
                              ),
                              child: Center(
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                    //old
                                    // !_selectedIndex.contains(i)
                                    ActiveDays[i].status == "freez"
                                        ? Icon(Icons.question_mark,
                                            size: 15, color: Design.color_icon)
                                        : ActiveDays[i].status == "active" &&
                                                ActiveDays[i].menu.length > 0
                                            ? Icon(Icons.check,
                                                size: 20,
                                                color: Design.color_icon)

                                            : SizedBox.shrink(),

                                    ////////////////
                                    Text(
                                      "${DateFormat('dd MMM EEEE').format(DateFormat('yyyy-MM-dd').parse(ActiveDays[i].ondate))}",
                                      style:
                                          DateTime.parse(ActiveDays[i].ondate)
                                                      .compareTo(DateTime(
                                                          DateTime.now().year,
                                                          DateTime.now().month,
                                                          DateTime.now().day)) <
                                                  0
                                              ? Design.small_text33
                                              : Design.text,
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                      )),
            ),

            //

            Visibility(
              child: _getContent(),
              visible: is_visbale,
            ),
            // Visibility(child:  Text("Not have menu for this day", style: Design.Button_first),
            //   visible: !is_visbale,),
            Visibility(
              visible: is_visbale,
              child: Container(
                margin: const EdgeInsets.only(
                    top: 15, left: 15, right: 15, bottom: 5),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Design.Background_Button_first,
                  ),
                  child: Text('Save', style: Design.Button_first),
                  onPressed: () async {
                    setState(() {
                      var menuesmap = datamenu.menu.map((e) {
                        return {
                          "item_master_id": e.id,
                          "size_id": e.size_id,
                          "note": e.note,
                          "rate": e.rate,
                          "favorite": e.favorite
                        };
                      }).toList();
                      print(menuesmap);
                      print(dataDate.length);
                      var daysmap = dataDate.map((e) {
                        return {"schedule_date": e};
                      }).toList();
                      update_subscription_date(daysmap, menuesmap);
                    });
                  },
                ),
              ),
            ),
            Visibility(
              child: Container(
                margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Design.Background_Button_second,
                  ),
                  child: Text('Back', style: Design.Button_first),
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainMeun()));
                  },
                ),
              ),
              visible: is_visbale,
            ),
          ],
        ));
  }

  Widget _buildExpandableTile(item, List<MenuData> items, int index) {
    List colors = [Colors.red, Color(0xFFF8CB1B), Colors.blue];
    rate = List.filled(items.length, 0, growable: false);
    favorite = List.filled(items.length, 0, growable: false);
    //   int count=item[]
    return ExpansionTile(
      initiallyExpanded: index == selected,
      key: Key(selected.toString()),
      onExpansionChanged: (newState) {
        setState(() {
          selected = index;
        });
      },
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "${item['en_name']}",
                  style: Design.Title2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                  //  "${int.parse(item['count']) - items.length}",
                    "${items.length}",
                    style: Design.Title2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      trailing: Container(
        width: 25,
        height: 25,
        alignment: Alignment.centerRight,
        child: Icon(
          Icons.keyboard_arrow_down,
          color: Design.color_icon,
        ),
      ),
      children: <Widget>[
        items == null || items.isEmpty
            ? Center(child: Text("No item")
                // CircularProgressIndicator(),
                )
            : Container(
                color: Color(0xffffffff),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, i) => InkWell(
                        onTap: () {
                          setState(() {
                            // .removeAt(index);
                          });
                        },
                        child: Container(
                          //height: 60,
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                    color: Design.color_BoxShadow2
                                        .withOpacity(0.5),
                                    blurRadius: 10.0,
                                    offset: Offset(0.0, 0.75))
                              ]),
                          width: 100,
                          child: Card(
                            color: Color(0xffececec),
                            //  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                //tileColor:covertRgbaToColor(_loadchoosePlanPageList[i]['back_color']),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            items[i].item_en_name,
                                            style: Design.Title2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      height: 30,
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      child: RatingBar.builder(
                                        initialRating: double.parse(
                                            items[i].rate.toString()),
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          size: 15.0,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          items[i].set_rate(rating.toString());
                                          datamenu.menu[datamenu.menu.indexWhere((element) => element.id == items[i].id)]
                                              .set_rate(rating.toString());
                                          print(datamenu.menu[datamenu.menu
                                                  .indexWhere((element) =>
                                                      element.id ==
                                                      items[i].id)]
                                              .get_rate);
                                        },
                                      )
                                      ),
                                  items[i].size_id == "0"
                                      ? SizedBox.shrink()
                                      : Row(
                                          children: [
                                            Text(
                                              "Size: ",
                                              style: Design.text_title,
                                            ),
                                            Text(
                                              "${items[i].size_en_name}",
                                              style: Design.small_text3,
                                            ),
                                          ],
                                        ),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Note: ",
                                          style: Design.text_title,
                                        ),
                                        Flexible(
                                          child: Text(
                                            items[i].note,
                                            style: Design.small_text3,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      items[i].size_id == "0"
                                          ? SizedBox.shrink()
                                          : Row(
                                              children: [
                                                Text(
                                                  "Calories: ",
                                                  style: Design.text_title,
                                                ),
                                                Text(
                                                  "${items[i].calories}",
                                                  style: Design.small_text3,
                                                )
                                              ],
                                            ),
                                    ],
                                  ),
                                  items[i].size_id == "0"
                                      ? SizedBox.shrink()
                                      : Container(
                                          height: 50,
                                          width: 350,
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(Icons.remove,
                                                      size: 20,
                                                      color: colors[0]),
                                                  Text(
                                                    "protein" +
                                                        "${items[i].protein}" +
                                                        " ",
                                                    style: Design.small_text3,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.remove,
                                                      size: 20,
                                                      color: colors[1]),
                                                  Text(
                                                      "carbs" +
                                                          "${items[i].carbs}" +
                                                          "  ",
                                                      style:
                                                          Design.small_text3),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Icon(Icons.remove,
                                                      size: 20,
                                                      color: colors[2]),
                                                  Text(
                                                      "fat" +
                                                          "${items[i].fat}" +
                                                          " ",
                                                      style:
                                                          Design.small_text3),
                                                ],
                                              ),
                                            ],
                                          ),

                                        ),
                                  Center(
                                    child: FavoriteButton(
                                      isFavorite: items[i].favorite == "1"
                                          ? true
                                          : false,
                                      iconSize: 50,
                                      // iconDisabledColor: Colors.white,
                                      valueChanged: (_isFavorite) {
                                        if (_isFavorite) {
                                          items[i].set_favorite("1");
                                          datamenu.menu[
                                          datamenu.menu
                                                      .indexWhere((element) =>
                                                          element.id ==
                                                          items[i].id)]
                                              .set_favorite("${1}");
                                          print("cash" +
                                              "${datamenu.menu[datamenu.menu.indexWhere((element) => element.id == items[i].id)].get_favorite}");
                                        } else {
                                          items[i].set_favorite("0");
                                          datamenu.menu[
                                          datamenu.menu
                                                      .indexWhere((element) =>
                                                          element.id ==
                                                          items[i].id)]
                                              .set_favorite("${0}");
                                          print("cash" +
                                              "${datamenu.menu[datamenu.menu.indexWhere((element) => element.id == items[i].id)].get_favorite}");
                                        }
                                        print('Is Favorite : $_isFavorite');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              //  ],
                            ),
                          ),
                        ))),
              )
      ],
    );
  }

  _getContent() {
    //ChooseList=ModalRoute.of(context).settings.arguments as List<DataForItems>;
    return Expanded(
        child: ListView(children: [

              Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Design.color_BoxShadow2,
              ),
              height: MediaQuery.of(context).size.height / 17,
              padding: EdgeInsets.all(15),
            child: Text("${AddressNam}")
          ),

      SizedBox(
        height: 25.0,
      ),
      Column(children: [
        menu_types == null
            ?
            // ||menu_types.isEmpty?
            Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                separatorBuilder: (context, i) {
                  return Divider(
                      // height: 20,
                      );
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: menu_types.length,
                itemBuilder: ((context, i) {

                  List<MenuData> Spacifc = [];
                  if (datamenu.menu.length>0) {
                    Spacifc.addAll(datamenu.menu.where((o) =>
                        o.item_master_package_id == menu_types[i]['id']));
                  } else {
                    Spacifc = [];
                  }

                  return _buildExpandableTile(menu_types[i], Spacifc, i);
                })),
      ]),
      // ),
    ]));
  }

  //multi select calender
  // Widget getDateRangePicker() {
  //   return Container(
  //       height: 300,
  //      width: 250,
  //           child:
  //
  //           SfDateRangePicker(
  //
  //             view: DateRangePickerView.month,
  //   selectionMode: DateRangePickerSelectionMode.multiple,
  //   minDate: DateTime.parse(CurrentSubr.CurrentSub['start_date']),
  //             //onSelectionChanged: selectionChanged,
  //           ));
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Stack(
          children: <Widget>[
            _getBackgroundColor(),
            _getAppBar(),
            //  _getContent(),
          ],
        ),
      ),
    );
  }
}
