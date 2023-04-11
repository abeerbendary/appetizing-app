import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' ;

class MenuSelectionScreen extends StatefulWidget {


  MenuState createState()=> MenuState();

}
class MenuState extends State<MenuSelectionScreen>{

  List PackList=[];

  @override
  Future  fetchData1() async {
    var url = "https://appetizingbh.com/mobile_app_api/load_packages.php";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      setState(() {
        PackList.addAll(body);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Menu Selection',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),



            // style:
            Expanded(
                child: ListView.builder(
                  itemCount: PackList.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    // return Container(
                    //   child: Text(cat[index].title),

                    // );
                    return new GestureDetector(
                      //You need to make my child interactive
                      // onTap: () {
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => MenuSelectionScreen(),
                      //       ));
                      // },
                      child: new Card(
                        //I am the clickable child
                        child: new Column(
                          children: <Widget>[
                            //new Image.network(video[index]),
                            new Padding(padding: new EdgeInsets.all(3.0)),
                            new Text(
                              PackList[index]['en_name'],
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            new Text(
                              PackList[index]['en_desc'],
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            ///////////////// insert image here
                          ],
                        ),
                      ),
                    );
                  },
                )),

            ElevatedButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Back'),
            ),
            ElevatedButton(
              onPressed: () {
                print("ddd");
              },
              child: Text('subscrip'),
            ),
            ElevatedButton(
              onPressed: () {
                print("ddd");
              },
              child: Text('Account'),
            ),
            ElevatedButton(
              onPressed: () {
                print("ddd");
              },
              child: Text('Support'),
            )
          ],
        ),
      ),
    );
  }
}
