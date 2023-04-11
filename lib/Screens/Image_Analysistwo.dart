import 'dart:convert';
import 'dart:io';

import 'package:appetizing/Screens/load_chronic_diseases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;


import 'ClientData.dart';
import 'Design.dart';
import 'ImageList.dart';
import 'Medicines_Supplements.dart';

class Image_Analysistwo extends StatefulWidget {
  Image_Analysistwo({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}
class _SignInState extends State<Image_Analysistwo> {
 // List<XFile> _imageFileList=[];
  List<ImageList> imagelist=[];
  List<String> Comment;
  TextEditingController controller_Comment = new TextEditingController();
  final Data_User_Regist = GetStorage();
  final ImagePicker _picker = ImagePicker();
  final picker = ImagePicker();

  Future getImageGallery() async {
    final List<XFile> pickedFileList = await _picker.pickMultiImage(
                maxWidth: 400,
                maxHeight: 500,
                imageQuality: 30,
              );

    setState(()  {
      if (pickedFileList != null) {
        for(int x=0;x<pickedFileList.length;x++){
         // List<int> imageBytes =  XFile(pickedFileList[x].path).readAsBytes();
          //String base64String = "data:image/png;base64," + base64Encode(imageBytes);
          imagelist.add(ImageList("", "", p.extension(pickedFileList[x].path), pickedFileList[x]));
        }
      //  _imageFileList = pickedFileList;
      } else {
        print('No image selected.');
      }
    });
  }
  Future getImage() async {
    final XFile pickedFile = await _picker.pickImage(
      source:  ImageSource.camera,
      maxWidth: 400,
      maxHeight: 500,
      imageQuality: 30,
    );
    setState(() {
      if (pickedFile != null) {
          imagelist.add(ImageList("", "", p.extension(pickedFile.path), pickedFile));
      } else {
        print('No image selected.');
      }
    });
  }


  _getContent() {
    return Container (
      padding: EdgeInsets.symmetric(horizontal: 15),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context) .size.height / 20,
          ),
          //Center()
          // height: 80,
          Text("Add Your Analysis", style: Design.Title),

          SizedBox(
            height: MediaQuery
                .of(context)
                .size
                .height / 50,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    getImageGallery();
                  },
                  child: const Icon(Icons.photo_library),
                ),
                ElevatedButton(
                  onPressed: () {
                    getImage();
                  },
                  child: const Icon(Icons.camera_alt),
                  // style: ElevatedButton.styleFrom(
                  //     backgroundColor: Design.Background_Button_first
                  //   // : Colors.white,
                  // )
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child:     ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, i) {
                      return Divider();
                    },
                    shrinkWrap: true,
                    itemCount: imagelist.length,
                    itemBuilder: (context, i) =>
                        InkWell(
                            onLongPress: () {
                              print("Number of items before: ${imagelist.length}");
                              imagelist.removeAt(i);
                              //Comment.removeAt(i);

                              setState(() {
                                print(context);
                                print("Number of items after delete: ${imagelist.length}");
                              });
                            },

                            child: Container(
                              //height: 60,
                                decoration: BoxDecoration(boxShadow: [
                                  BoxShadow(
                                      color: Design.color_BoxShadow2.withOpacity(0.5),
                                      blurRadius: 10.0,
                                      offset: Offset(0.0, 0.75))
                                ]),
                                width: MediaQuery.of(context).size.width / 1.4,
                                child:
                                Card(
                                    child:
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child:
                                      Column(
                                        mainAxisSize: MainAxisSize.min ,
                                        children: [
                                          // Center(
                                          // child: Semantics(
                                          //         label: 'image_picker_example_picked_image',
                                          //         child:
                                          Container(
                                              height: MediaQuery.of(context).size.height/2,
                                              width: double.infinity,
                                              child: Image.file(File(imagelist[i].imagefile.path))),
                                          // ),
                                          // ),
                                          new  TextField(
                                            //controller:_controllers[i],
                                            onChanged: (value) {
                                              setState(() {
                                                imagelist[i].note=value.toString();
                                                //Comment[i]=value.toString();
                                                //print(_imageFileList.length);
                                              //  print(Comment.length);
                                              });

                                            },
                                            style: Design.text,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                fillColor: Colors.cyanAccent,
                                                contentPadding:
                                                EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                                                hintText: "Add Comment"
                                            ),
                                            autofocus: false,
                                          ),
                                        ],
                                      ),
                                    ))))


                ),
            )
          ),

          Container(
            margin: const EdgeInsets.only(
                top: 5, left: 15, right: 15, bottom: 5),
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Design.Background_Button_first,
              ),
              child: Text('Next', style: Design.Button_first),
              onPressed: ()  async {
                 // setState(() async {
                if(imagelist.length>0){
                  for (int x = 0; x < imagelist.length; x++) {
                    imagelist[x].image=("data:image/png;base64," + base64Encode(await XFile(imagelist[x].imagefile.path).readAsBytes()));
                  }
                  // String jsonUser = jsonEncode(imagelist);
                  // print(jsonUser);
                  Data_User_Regist.write("medical_test", imagelist);
                  // ClientData.medical_test
                }else {
                  print("abeer");
                  List<ImageList> tags = [ImageList("", "", "", null)];
                  // String jsonUser = jsonEncode(tags);
                  // print(jsonUser);
                  Data_User_Regist.write("medical_test", tags);
                }

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Medicines_Supplements()));
                // });

              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
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
                        builder: (context) => load_chronic_diseases()));
              },
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[

            _getContent(),
          ],
        ),
      ),
    );
  }

}
