import 'dart:convert';
import 'dart:io';

import 'package:appetizing/Screens/load_chronic_diseases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;


import 'Design.dart';
import 'ImageList.dart';
import 'Medicines_Supplements.dart';

class Image_Analysis extends StatefulWidget {
  Image_Analysis({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}
class _SignInState extends State<Image_Analysis> {
  List<XFile> _imageFileList;
  List<ImageList> imagelist=[];
  List<String> Comment;
  // List<String>comments;
  TextEditingController controller_Comment = new TextEditingController();
 // List<TextEditingController> _controllers = new List();

   List<TextEditingController> _controllers = [];
 // List<String>Comment=[];
  void _setImageFileListFromFile(XFile value) {
    setState(() {
    _imageFileList = value == null ? null : <XFile>[value];
    if(_imageFileList!=null){
      Comment=List.filled(_imageFileList.length, "", growable: false);
      _controllers=new List(5);
    }
    //setState(() {
   //   _imageFileList = value == null ? null : <XFile>[value];
      // if(_imageFileList!=null){
      // comments=[""];}

    });
  }
  dynamic _pickImageError;
  String _retrieveDataError;
  final Data_User_Regist = GetStorage();
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext context, bool isMultiImage = false}) async {
    if (isMultiImage) {
      try {
        //setState(() async {
          final List<XFile> pickedFileList = await _picker.pickMultiImage(
            maxWidth: 400,
            maxHeight: 500,
            imageQuality: 40,
          );
          setState(() {
            _imageFileList = pickedFileList;
            if(_imageFileList!=null){
              Comment=List.filled(_imageFileList.length, "", growable: false);
              _controllers=new List(5);
            }
          });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
        //});
      }

    } else {
      try {

          final XFile pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: 400,
            maxHeight: 500,
            imageQuality: 40,
          );
          setState(() async {
          _setImageFileListFromFile(pickedFile);
        });
      } catch (e) {
        setState(() {
          _pickImageError = e;
        });
      }
    }
  }
  // Future<void> retrieveLostData() async {
  //   final LostDataResponse response = await _picker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     if (response.type == RetrieveType.video) {
  //       isVideo = true;
  //       await _playVideo(response.file);
  //     } else {
  //       isVideo = false;
  //       setState(() {
  //         if (response.files == null) {
  //           _setImageFileListFromFile(response.file);
  //         } else {
  //           _imageFileList = response.files;
  //         }
  //       });
  //     }
  //   } else {
  //     _retrieveDataError = response.exception!.code;
  //   }
  // }

  Widget _previewImages() {
    final Text retrieveError = _getRetrieveErrorWidget();

    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      //      for(int x=0;x<_imageFileList.length;x++){
      //   imagelist.add(ImageList("", "", "", _imageFileList[x]));
      // }

      return Semantics(
        label: 'image_picker_example_picked_images',
        child:
        ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, i) {
              return Divider();
            },
            shrinkWrap: true,
            itemCount: _imageFileList.length,
            itemBuilder: (context, i) =>
                InkWell(
                onLongPress: () {
                  print("Number of items before: ${imagelist.length}");
                  _imageFileList.removeAt(i);
                  Comment.removeAt(i);

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
                              child: Image.file(File(_imageFileList[i].path))),
                                // ),
                          // ),
                    new  TextField(
                             controller:_controllers[i],
                            onChanged: (value) {
                               setState(() {
                                 Comment[i]=value.toString();
                                 print(_imageFileList.length);
                                 print(Comment.length);
                               });

                              // imagelist[i].set_note(value.toString());
                              // print(imagelist.length.toString());
                              // print(imagelist[i]);
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
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _imageFileList = response.files;
          if(_imageFileList!=null){
            Comment=List.filled(_imageFileList.length, "", growable: false);
            _controllers=new List(5);
          }

        }
      });
    } else {
      _retrieveDataError = response.exception.code;
      print("${_retrieveDataError}");
    }
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
                      _onImageButtonPressed(
                        ImageSource.gallery,
                        context: context,
                        isMultiImage: true,
                      );
                    },
                    child: const Icon(Icons.photo_library),
                    // style: ElevatedButton.styleFrom(
                    //   backgroundColor: Design.Background_Button_first // : Colors.white,
                    // )
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _onImageButtonPressed(ImageSource.camera,
                          context: context);
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
                  child: FutureBuilder<void>(
                    future: retrieveLostData(),
                    builder:
                        (BuildContext context, AsyncSnapshot<void> snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return const Text(
                            'You have not yet picked an image.',
                            textAlign: TextAlign.center,
                          );
                        case ConnectionState.done:
                          return _handlePreview();
                        default:return const Text(
                            'You have not yet picked an image.',
                            textAlign: TextAlign.center,
                          );
                      }
                    },
                  )),
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
                onPressed: () async {
                   // setState(() async {
                     if(_imageFileList!=null||_imageFileList.length>0){
                     //   for (int x = 0; x < imagelist.length; x++) {
                     for (int x = 0; x < _imageFileList.length; x++) {
                       imagelist.add(ImageList("", "", "", _imageFileList[x]));
                       print("abeer  " + x.toString());
                       List<int> imageBytes = await XFile(
                           _imageFileList[x].path)
                           .readAsBytes();
                       print(imageBytes);
                       String base64String = "data:image/png;base64," +
                           base64Encode(
                               imageBytes); // must be called in async method
                       print(base64String);
                       imagelist[x].set_image(base64String);

                       imagelist[x].set_image_format(
                           p.extension(imagelist[x].imagefile.path)); // '.dart'

                     }
                     var medical_test = imagelist.map((e) {
                       return {
                         "note": e.note,
                         "image": e.image,
                         "image_format": e.image_format,
                       };
                     }).toList();
                      String stringmedical_test = json.encode(medical_test);
                      print(stringmedical_test);
                     Data_User_Regist.write("medical_test", medical_test);

                     }else {
                       print("abeer");
                       List imagelistaa = [1];
                       var medical_test = imagelistaa.map((e) {
                         return {
                           "note": "",
                           "image": "",
                           "image_format": "",
                         };
                       }).toList();
                       String stringmedical_test = json.encode(medical_test);
                       Data_User_Regist.write("medical_test", stringmedical_test);
                     }
                   // });
                   // });
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
      // new ListView.builder(
      //   itemCount: _load_packages.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return Text("${_load_packages[index]["en_name"]}");
      //     // new Card(
      //     //   child: new Text(_load_activity[index].en_name),
      //     // );
      //   },
      // ),



  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //         child: FutureBuilder<void>(
  //           future: retrieveLostData(),
  //           builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
  //             switch (snapshot.connectionState) {
  //               case ConnectionState.none:
  //               case ConnectionState.waiting:
  //                 return const Text(
  //                   'You have not yet picked an image.',
  //                   textAlign: TextAlign.center,
  //                 );
  //               case ConnectionState.done:
  //                 return _handlePreview();
  //               default:
  //                   return const Text(
  //                     'You have not yet picked an image.',
  //                     textAlign: TextAlign.center,
  //                   );
  //
  //             }
  //           },
  //         )
  //     ),
  //     floatingActionButton: Column(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: <Widget>[
  //         // Semantics(
  //         //   label: 'image_picker_example_from_gallery',
  //         //   child:
  //         //   FloatingActionButton(
  //         //     onPressed: () {
  //         //       _onImageButtonPressed(ImageSource.gallery, context: context);
  //         //     },
  //         //     heroTag: 'image0',
  //         //     tooltip: 'Pick Image from gallery',
  //         //     child: const Icon(Icons.photo),
  //         //   ),
  //         // ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 16.0),
  //           child: FloatingActionButton(
  //             onPressed: () {
  //               _onImageButtonPressed(
  //                 ImageSource.gallery,
  //                 context: context,
  //                 isMultiImage: true,
  //               );
  //             },
  //             heroTag: 'image1',
  //             tooltip: 'Pick Multiple Image from gallery',
  //             child: const Icon(Icons.photo_library),
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(top: 16.0),
  //           child: FloatingActionButton(
  //             onPressed: () {
  //               _onImageButtonPressed(ImageSource.camera, context: context);
  //             },
  //             heroTag: 'image2',
  //             tooltip: 'Take a Photo',
  //             child: const Icon(Icons.camera_alt),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
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


  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}
