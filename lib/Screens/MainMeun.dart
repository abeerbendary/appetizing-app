import 'dart:async';
import 'dart:convert';

import 'package:appetizing/Screens/Freez.dart';
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

class MainMeun extends StatefulWidget {
  MainMeun({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<MainMeun> {
  List _selectedIndex = [];
  List menu_types = [];
  List rate=[] ;

    List  favorite=[];
  //List<DataForItems>ChooseList;
  var valueChoose;
  // List<AdressCustomer> customer_address = [];
  List customer_address = [];
  List<DataForAllDays> ActiveDays = [];
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();
  bool is_visbale;
   List ChoosenDays = [];
  int count;
  int Address_index;
  List<MenuData> menues = [];
  bool _customTileExpanded = false;
  int selected = -1;
  final Data_User_Regist = GetStorage();
  List dataDate = [];
  DataForAllDays datamenu;
  List<Map<String, dynamic>> dataMenue = [];
  Map<String, String> dates = new Map();
  Map<String, dynamic> menu =new Map();

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
          "customer_id": "9",
           //"customer_id": Data_User_Regist.read("customer_id")
        }));
    var body;
    if (response.body.isNotEmpty) {
      body = jsonDecode(response.body);
    }

    print(body);
    // setState(() {
    //   //var tagObjsJson = body['data'] as List;
    //   customer_address = body.map((tagJson) => AdressCustomer.fromJson(tagJson)).toList();
    //   print(customer_address[2].note);
    //   //ActiveDays.addAll(body1['data'].where((o) => o['menu'].length==0).first['ondate']);
    //   //print(ActiveDays[0]['ondate'];
    //   //  lights.firstWhere((x) => x['id'] == searchId, orElse:() => {"color" : "Color Not found"})['color'];
    //   print(customer_address.length);
    // });
    // setState(() {
      customer_address.addAll(body);
    CurrentSubr.adreess.addAll(customer_address);
    // });
  }

  // List<DateTime> days = List.generate(
  //   int.parse(CurrentSubr.CurrentSub['day_count']), // 4weeks
  //       (index) => DateTime.parse(CurrentSubr.CurrentSub['start_date']).add(Duration(days: index + 1),),
  // );

  @override
  Future load_menu_types() async {
    //var CurrentSub = CurrentSubr.CurrentSub;

    var url =
        "https://appetizingbh.com/mobile_app_api/load_subscription_menu_types.php";
    http.Response response = await http.post(Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "api_token": "00QCRTl4MlV",
          "device_id": "F1BTPG3",
          "package_id": CurrentSubr.CurrentSub['package_id']
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
          "subscription_id": CurrentSubr.CurrentSub['id']
          //"subscription_id": "104"
        }));
    var body1;
    if (response1.body.isNotEmpty) {
      body1 = jsonDecode(response1.body);
    }
    setState(() {
      var tagObjsJson = body1['data'] as List;
      ActiveDays = tagObjsJson.map((tagJson) => DataForAllDays.fromJson(tagJson))
          .toList();
      if (_selectedIndex == null || _selectedIndex.isEmpty) {
        _selectedIndex = List.filled(ActiveDays.length, -1, growable: false);
      }
      print(ActiveDays);
      //ActiveDays.addAll(body1['data'].where((o) => o['menu'].length==0).first['ondate']);
      //print(ActiveDays[0]['ondate'];
      //  lights.firstWhere((x) => x['id'] == searchId, orElse:() => {"color" : "Color Not found"})['color'];
      print(ActiveDays.length);
    });
  }

  @override
  Future update_subscription_date(
      List<Map<String, dynamic>> dates, List<Map<String, dynamic>> menue) async {
    var url1 = "https://appetizingbh.com/mobile_app_api/update_subscription_date.php";
    print("******************");
    print(jsonEncode(<String, dynamic>{
      "api_token": "00QCRTl4MlV",
      "device_id": "F1BTPG3",
      "subscription_id":CurrentSubr.CurrentSub['id'],
      "package_id":CurrentSubr.CurrentSub['package_id'],
      "schedule_date":dates,
      "address_id":CurrentSubr.Address_id,
      "menu":menue
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
          "address_id": CurrentSubr.Address_id,
          "menu": menue
        }));
    var body1;
    if (response1.body.isNotEmpty) {
      body1 = jsonDecode(response1.body);
    }
    setState(() {
      CurrentSubr.Days_index=[];
      CurrentSubr.CurrentMenu=[];
      CurrentSubr.Address_index=-1;
      CurrentSubr.Address_id="-1";
      CurrentSubr.adreess=[];
      CurrentSubr.countitem=0;
      CurrentSubr.visublity=false;
      CurrentSubr.ChooseList=[];
      CurrentSubr.Days=[];
      CurrentSubr.Days_index=[];
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainMeun()));
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (BuildContext context) => super.widget));
    });
  }
Future Scroleto() async {
    if(ActiveDays.length==0){
    }else {
      int index = ActiveDays.indexWhere((element) =>
      DateTime.parse(element.ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) == 0);
// _selectedIndex[index]=index;
      if(index==-1){
        index=ActiveDays.indexWhere((element) =>
        DateTime.parse(element.ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) > 0);
      }
      if(index==-1){
        index=0;
      }
      if (_selectedIndex != null || _selectedIndex.length > 0) {
        for (int x = 0; x < _selectedIndex.length; x++) {
          if (_selectedIndex[x] != -1) {
            index = _selectedIndex.indexWhere((element) => element != -1);
          //  is_visbale=true;
            break;
          }
        }
      }
    if(itemScrollController.isAttached) {
      itemScrollController.scrollTo(
          index: index,
          duration: Duration(seconds: 1),
          curve: Curves.ease);
    }else{
      Timer(Duration(milliseconds: 400), () => Scroleto());
    }
    }
}
  // void _scrollToBottom() {
  //   if (_scrollController.hasClients) {
  //     _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //         duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
  //   } else {
  //     Timer(Duration(milliseconds: 400), () => _scrollToBottom());
  //   }
  // }
  @override
  void initState() {
    setState(() {
      load_menu_types();
      load_customer_addess();
      load_ActiveDays();
      dataDate=CurrentSubr.Days;
      if(CurrentSubr.Days_index!=null||CurrentSubr.Days_index.length>0) {
        _selectedIndex = CurrentSubr.Days_index;
      }
      is_visbale=CurrentSubr.visublity;
    if(CurrentSubr.adreess!=null||CurrentSubr.adreess.length>0){
    Address_index = CurrentSubr.Address_index;
    if(Address_index!=-1) {
    valueChoose = CurrentSubr.adreess[Address_index]['note'];
    }}
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
                    child:
                      Text(
                        "Menu For "+"${CurrentSubr.CurrentSub['package_en_name']}",
                        style: Design.Title,
                      ),

                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(vertical: 20),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        customButton: Icon(
                          Icons.settings,
                          size: 30,
                          color: Design.color_icon,
                        ),
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
                         // MenuItems.onChanged(context, value as MenuItem);
                          setState(() {
                            switch (value) {
                              case MenuItems.Set_All:
                                int end=ActiveDays.length-1;
                                int start=ActiveDays.indexWhere((element) =>
                                DateTime.parse(element.ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)) >= 0);
                                dataDate.addAll(ActiveDays.sublist(start,end));
                                print(dataDate);
                                is_visbale=true;
                                 _selectedIndex=[];
                                 for(int x=0;x<=dataDate.length;x++){
                                  _selectedIndex.add(x);
                                 }

                                break;
                              case MenuItems.Freez:
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => FreezSCreen()));
                                break;
                              case MenuItems.History:
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => HistoryMenueDay()));
                                break;
                            }
                          //   selectedValue = value.key as String;
                          //   images = value.icon as String;
                          });
                        },
                        buttonHeight: MediaQuery.of(context).size.height / 15,
                        itemHeight: 30,
                        dropdownWidth: 100,
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
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            //design1
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              height: MediaQuery.of(context).size.height / 13,
              width: MediaQuery.of(context).size.width,
              child:
              ScrollablePositionedList.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  //shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: ActiveDays.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, i)
                  => InkWell(
                        onTap: () {
                          setState(() {
                            //
                            if (_selectedIndex[i] == i) {
                              _selectedIndex[i] = -1;
                              //dates['schedule_date'] = ActiveDays[i].ondate.toString();
                              dataDate.remove(ActiveDays[i].ondate.toString());

                             // ActiveDays.remove(ActiveDays[i]);
                            } else {
                              _selectedIndex[i] = i;
                             // ActiveDays.add(ActiveDays[i]);
                              //dates['schedule_date'] = ActiveDays[i].ondate.toString();
                              if(DateTime.parse(ActiveDays[i].ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))<0) {
                                _selectedIndex[i] = -1;
                              }else{
                                dataDate.add(ActiveDays[i].ondate.toString());
                              }
                            }
                            if(DateTime.parse(ActiveDays[i].ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))<0&&ActiveDays[i].menu.length==0){
                              is_visbale=false;
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: "not data for day"+"${ActiveDays[i].ondate}")
                                ..show();
                              return;
                            }
                            else if(DateTime.parse(ActiveDays[i].ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))<0&&ActiveDays[i].menu.length>0){
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: "to show data for "+"${ActiveDays[i].ondate}"+" go to history")
                                ..show();
                              return;
                            }   if(DateTime.parse(ActiveDays[i].ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))<0&&ActiveDays[i].menu.length==0){
                              is_visbale=false;
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.rightSlide,
                                  title: "not data for day"+"${ActiveDays[i].ondate}")
                                ..show();
                              return;
                            }
                            // handel hasmenue
                            // else if(dataDate.length>0||dataDate.contains(ActiveDays[i].ondate..menu.length==0)){
                            //   AwesomeDialog(
                            //       context: context,
                            //       dialogType: DialogType.info,
                            //       animType: AnimType.rightSlide,
                            //       title: "cant select two day has menu")
                            //     ..show();
                            //   return;
                            // }
                            //
                            else if(dataDate.length==0){
                              is_visbale=false;
                            }else{
                              is_visbale=true;
                              if(ActiveDays[i].menu.length>0){
                              CurrentSubr.ChooseList=ActiveDays[i].menu;}
                            }

                            // if(dataDate.length>0){
                            //   is_visbale=true;
                            // }else{
                            //   is_visbale=false;
                            // }
                          });
                        },
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              // width: MediaQuery.of(context).size.width / 2,
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Color(0xffececec),
                                //old
                                //  borderRadius: BorderRadius.circular(20.0),
                                //   color: _selectedIndex.contains(i)
                                //       ? Design.color_BoxShadow2
                                //       : Design.color_BoxShadow,
                                //////////////
                                border: Border(
                                  // right: BorderSide(width: 2.0, color:Design.color_icon),
                                  bottom: BorderSide(
                                      width: 3.0,
                                      color: _selectedIndex.contains(i)
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
                                            // : _selectedIndex.contains(i)
                                            //     ? Icon(Icons.check,
                                            //         size: 20,
                                            //         color: Design.color_icon)
                                                : SizedBox.shrink(),

                                    ////////////////
                                    Text(
                                      "${DateFormat('dd MMM EEEE').format(DateFormat('yyyy-MM-dd').parse(ActiveDays[i].ondate))}",
                                      //old
                                      // style: TextStyle(color: _selectedIndex.contains(i) ? Design.color_icon : Design.textColor,
                                      //
                                      // ),
                                      style: DateTime.parse(ActiveDays[i].ondate).compareTo(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day))<0 ?Design.small_text33:Design.text,
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                      )
              ),
            ),

            //

           Visibility(child:  _getContent(),
           visible: is_visbale,),
            // Visibility(child:  Text("Not have menu for this day", style: Design.Button_first),
            //   visible: !is_visbale,),
        Visibility(visible: is_visbale,child: Container(
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
                    // "menu":[{ "item_master_id":1, "size_id":2, "note":"ANY NOTES"},
                    // { "item_master_id":2, "size_id":1, "note":"ANY NOTES2"}];
                    // menues.addAll();
                    var menuesmap = CurrentSubr.ChooseList.map((e){
                      return {
                        "item_master_id": e.id,
                        "size_id": e.size_id,
                        "note": e.note,
                        "rate": e.rate,
                        "favorite":e.favorite
                      };
                    }).toList();
                    print(menuesmap);
                    var daysmap = dataDate.map((e){
                      return {
                        "schedule_date": e
                      };
                    }).toList();
                    // for (int v = 0; v < menues.length; v++) {
                    //   menu=new Map();
                    //   menu['item_master_id'] = menues[v].id;
                    //   menu['size_id'] = menues[v].size_id;
                    //   menu['note'] = menues[v].note;
                    //   menu['rate']=menues[v].rate;
                    //   menu['favorite']=menues[v].favorite;
                    //   dataMenue.add(menu);
                    // }
                    update_subscription_date(daysmap, menuesmap);

                    ///////
                  });
                },
              ),
            ),),
            Visibility(child:  Container(
              margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Design.Background_Button_second,
                ),
                child: Text('Back', style: Design.Button_first),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => subscription()));
                },
              ),
            ), visible: is_visbale,),
          ],
        ));
  }

  Widget _buildExpandableTile(item, List<MenuData> items, int index) {
    List colors = [Colors.red, Color(0xFFF8CB1B), Colors.blue];
    rate=List.filled(items.length, 0, growable: false);
    favorite =List.filled(items.length, 0, growable: false);
    //   int count=item[]
    return ExpansionTile(
      initiallyExpanded: index == selected,
      key: Key(selected.toString()),
      onExpansionChanged: (newState) {
        setState(() {
          selected = index;
        });
      },
      leading: ClipOval(
        child: Material(
          color: Design.Background_Button_first,
          child: InkWell(
            //splashColor:Colors.orange,
            //  splashColor: Design.Background_Button_first,
            onTap: () {
              if(items.length==int.parse(item['count'])){
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: "Remove Item To can Add")
                  ..show();
                return;
              }else{
              CurrentSubr.CurrentMenu = menu_types[index];
              CurrentSubr.Days=dataDate;
              CurrentSubr.Days_index = _selectedIndex;
              CurrentSubr.visublity=true;
              Map<String, String> data = {
                "Name": item['en_name'],
                "ar_name":item['ar_name'],
                 "Count": item['count'],
                //"Count": "2",
                "Id": menu_types[index]['id']
              };
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OldSubscriptionData(),
                    settings: RouteSettings(
                      arguments: data,
                    ),
                  ));}
            },

            child: Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
              // color: Colors.red,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                 "${item['en_name']}" ,
                  style: Design.Title2,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                     "${int.parse(item['count'])-items.length}" ,
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
                                        Container(
                                          // padding: EdgeInsets.symmetric(vertical: 20),
                                          child: ClipOval(
                                            child: Material(
                                              color: Design
                                                  .Background_Button_first,
                                              child: InkWell(
                                                //splashColor:Colors.orange,
                                                //  splashColor: Design.Background_Button_first,
                                                onTap: () {
                                                  setState(() {
                                                    // ChooseList.removeAt(ChooseList.indexWhere((element) => element.id==items[i].id));
                                                    CurrentSubr.ChooseList
                                                        .removeAt(CurrentSubr
                                                                .ChooseList
                                                            .indexWhere(
                                                                (element) =>
                                                                    element
                                                                        .id ==
                                                                    items[i]
                                                                        .id));
                                                  });
                                                },

                                                child: Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                  color: Colors.white,
                                                  // color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Flexible(
                                  //       child: Text(
                                  //         items[i].en_desc,
                                  //         style: Design.small_text3,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  Container(
                                    height: 30,
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    child:
                                    RatingBar.builder(
                                      initialRating: double.parse(items[i].rate.toString()),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        size: 30,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        items[i].set_rate(rating.toString());
                                        CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].set_rate(rating.toString());
                                        print(CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].get_rate);
                                      },
                                    )

                                    // ListView.separated(
                                    //     physics: NeverScrollableScrollPhysics(),
                                    //     scrollDirection: Axis.horizontal,
                                    //     separatorBuilder: (context, i) {
                                    //       return Divider(
                                    //           // height: 20,
                                    //           );
                                    //     },
                                    //     shrinkWrap: true,
                                    //     itemCount: 5,
                                    //     itemBuilder: (context, inrate) => InkWell(
                                    //           onTap: () {
                                    //             setState(() {
                                    //
                                    //              // ;; set to object
                                    //             });
                                    //           },
                                    //           child: Container(
                                    //               //width: MediaQuery.of(context).size.width / 2,
                                    //               margin: EdgeInsets.symmetric(
                                    //                   horizontal: 5),
                                    //               child: StarButton(
                                    //                 iconColor:
                                    //                     Color(0xFFF8CB1B),
                                    //                 iconSize: 30,
                                    //                 isStarred: false,
                                    //                 // iconDisabledColor: Colors.white,
                                    //                 valueChanged: (_isStarred) {
                                    //                   int x=rate[i];
                                    //                   print(
                                    //                       'Is Starred : $_isStarred');
                                    //                   if(_isStarred){
                                    //                     String x=items[i].get_rate;
                                    //                     int y=int.parse(x);
                                    //                     y=y+1;
                                    //                     items[i].set_rate(y.toString());
                                    //                     // rate[i]=x+1;
                                    //                      print("rate"+"${items[i].get_rate}");
                                    //                     CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].set_rate(items[i].get_rate);
                                    //                     print("cash"+"${CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].get_rate}");
                                    //                   }else{
                                    //                     String x=items[i].get_rate;
                                    //                     int y=int.parse(x);
                                    //                     y=y-1;
                                    //                     items[i].set_rate(y.toString());
                                    //                     // rate[i]=x+1;
                                    //                     print("rate"+"${items[i].get_rate}");
                                    //
                                    //                     CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].set_rate("${items[i].get_rate}");
                                    //                     print("cash"+"${CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].get_rate}");                                                      }
                                    //                 },
                                    //               )),
                                    //         )),
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
                                          // ListView.separated(
                                          // physics: NeverScrollableScrollPhysics(),
                                          // scrollDirection: Axis.horizontal,
                                          // separatorBuilder: (context, x) {
                                          // return Divider(
                                          // // height: 20,
                                          // );
                                          // },
                                          // shrinkWrap: true,
                                          // itemCount: 3,
                                          // itemBuilder: (context, x) {
                                          //   if (x == 0) {
                                          //     Row(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         mainAxisAlignment: MainAxisAlignment.start,
                                          //         children: [
                                          //           Icon(Icons.remove,
                                          //               size: 20, color: colors[x]),
                                          //           Text("0")
                                          //           // Text(
                                          //           //   //   "${formatter.format(days[i])} number:${days[i].day}",
                                          //           //   "Fat" + "${items[i].size_list
                                          //           //       .where((o) => o.size_master_id == items[i].get_size_id)
                                          //           //       .first
                                          //           //       .fat}",
                                          //           //
                                          //           // ),
                                          //         ]);
                                          //   }
                                          //   else if (x == 1) {
                                          //     Row(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         mainAxisAlignment: MainAxisAlignment.start,
                                          //         children: [
                                          //           Icon(Icons.remove,
                                          //               size: 20, color:colors[x]),
                                          //           Text("0")
                                          //           // Text(
                                          //           //   //   "${formatter.format(days[i])} number:${days[i].day}",
                                          //           //   "protein"+ "${items[i].size_list
                                          //           //       .where((o) => o.size_master_id == items[i].get_size_id)
                                          //           //       .first
                                          //           //       .protein}",
                                          //           //
                                          //           // ),
                                          //         ]);
                                          //   }
                                          //   else {
                                          //     Row(
                                          //         crossAxisAlignment: CrossAxisAlignment.start,
                                          //         mainAxisAlignment: MainAxisAlignment.start,
                                          //         children: [
                                          //           Icon(Icons.remove,
                                          //               size: 20, color: colors[x]),
                                          //           Text("1")
                                          //           // Text(
                                          //           //   //   "${formatter.format(days[i])} number:${days[i].day}",
                                          //           //   "carbs"+ "${items[i].size_list
                                          //           //       .where((o) => o.size_master_id == items[i].get_size_id)
                                          //           //       .first
                                          //           //       .carbs}",
                                          //           //
                                          //           // ),
                                          //         ]);
                                          //
                                          //   }
                                          // }
                                          // )
                                        ),
                                  Center(
                                    child: FavoriteButton(
                                      isFavorite: items[i].favorite=="1"?true:false,
                                      iconSize: 50,
                                      // iconDisabledColor: Colors.white,
                                      valueChanged: (_isFavorite) {
                                        if(_isFavorite){
                                          items[i].set_favorite("1");
                                          CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].set_favorite("${ 1}");
                                          print("cash"+"${CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].get_favorite}");
                                        }else{
                                          items[i].set_favorite("0");
                                          CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].set_favorite("${ 0}");
                                          print("cash"+"${CurrentSubr.ChooseList[CurrentSubr.ChooseList.indexWhere((element) => element.id==items[i].id)].get_favorite}");
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
        child: DropdownButtonHideUnderline(
          child:
          DropdownButton2(
            hint: Text(
              'Choose Address',
              style: Design.small_text3,
            ),
            items: customer_address
                .map((item) => DropdownMenuItem<String>(
                      value: item['note'],
                      child: Text(
                        item['note'],
                        style: Design.small_text3,
                      ),
                    ))
                .toList(),
            value: valueChoose,
            onChanged: (value) {
              setState(() {
                valueChoose = value as String;
                CurrentSubr.Address_index=customer_address.indexWhere((element) => element['note']==valueChoose);
                 CurrentSubr.Address_id=customer_address[CurrentSubr.Address_index]['id'];

                // print(delivery_time_id);
              });
            },
            buttonHeight: MediaQuery.of(context).size.height / 15,
            buttonWidth: 140,
            itemHeight: 50,
          ),
        ),
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
                  if (CurrentSubr.ChooseList != null ||
                      CurrentSubr.ChooseList.isEmpty) {
                    Spacifc.addAll(CurrentSubr.ChooseList.where((o) => o.item_master_package_id == menu_types[i]['id']));
                    //error
                    //  ChooseList.remove(ChooseList.where((o)=>o.id==Spacifc[0].id));
                    //  print(ChooseList.length);
                    //  Spacifc.removeAt(0);
                    //  print(Spacifc.length);
                  } else {
                    Spacifc = [];
                  }

                  return _buildExpandableTile(
                      menu_types[i], Spacifc, i);
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
    // if(ModalRoute.of(context).settings.arguments!=null) {
    //   CurrentSubr.ChooseList.addAll(ModalRoute
    //       .of(context)
    //       .settings
    //       .arguments);
    // }
    WidgetsBinding.instance.addPostFrameCallback((_) =>  Scroleto());

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

class MenuItem {
  final String text;

  const MenuItem({
    this.text,
  });
}

class MenuItems {
   static const List<MenuItem> firstItems = [Set_All, Freez, History];
 // static const List<MenuItem> firstItems = [Set_All, Freez];

  static const Set_All = MenuItem(text: 'Set All');
  static const Freez = MenuItem(text: 'Freez');
   static const History = MenuItem(text: 'History');
   static const ChangeDay = MenuItem(text: 'History');

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Text(
          item.text, style: Design.text,
          //         ),
        ),
      ],
    );
  }

  // static onChanged(BuildContext context, MenuItem item) {
  //
  // }
}
