import 'package:flutter/material.dart';
import 'MenuSelectionScreen.dart';
import 'Uitlits.dart';
import 'catergory.dart';
import 'load_fitness.dart';

class UserSubPage extends StatefulWidget{

  _USerSubPageState createState()=>_USerSubPageState();

}
class _USerSubPageState extends State<UserSubPage>{
  List<category> cat = Uitlits.getCat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => load_fitness(),
                    ));
              },
              child: Text('new'),
            ),
            Text(
              'sss',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
            // style:
            Expanded(
                child: ListView.builder(
                  itemCount: cat.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return
                      new GestureDetector(
                      //You need to make my child interactive
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuSelectionScreen(),
                            ));
                      },
                      child: new Card(
                        //I am the clickable child
                        child: new Column(
                          children: <Widget>[
                            //new Image.network(video[index]),
                            new Padding(padding: new EdgeInsets.all(3.0)),
                            new Text(
                              cat[index].name,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            new Text(
                              cat[index].PackageName,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            new Text(
                              cat[index].StartDate,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),new Text(
                              cat[index].EndDate,
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                    // return Container(
                    //   child: Text(cat[index].name),
                    // );
                  },
                )),

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