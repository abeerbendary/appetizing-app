import 'dart:convert';
import 'dart:io';

import 'package:appetizing/Screens/load_chronic_diseases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'Design.dart';
import 'Medicines_Supplements.dart';

class Image_Analysis extends StatefulWidget {
  Image_Analysis({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignInState();
}
class _SignInState extends State<Image_Analysis> {
  List<XFile> _imageFileList;
  // List<String>comments;
  TextEditingController controller_Comment = new TextEditingController();
  List<TextEditingController> _controllers = new List();

  // List<TextEditingController> _controllers = new List();
  List<String>Comment=[];
  void _setImageFileListFromFile(XFile value) {
    _imageFileList = value == null ? null : <XFile>[value];
    //setState(() {
    //   _imageFileList = value == null ? null : <XFile>[value];
    // if(_imageFileList!=null){
    // comments=[""];}

    // });
  }
  dynamic _pickImageError;
  String _retrieveDataError;

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

  Widget _previewImages() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picker_example_picked_images',
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, i) {
              return Divider();
            },
            shrinkWrap: true,
            itemCount: _imageFileList.length,
            itemBuilder: (context, i) =>
                InkWell(
                    onLongPress: () {
                      print("Number of items before: ${_imageFileList.length}");
                      _imageFileList.removeAt(i);
                      //  comments.remove(0);
                      setState(() {
                        print(context);
                        print("Number of items after delete: ${_imageFileList.length}");
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
                                  // new TextField(
                                  //        // controller: _controllers[i],
                                  //        onChanged: (value) {
                                  //         comments.insert(i, value);
                                  //        },
                                  //        style: Design.text,
                                  //        decoration: InputDecoration(
                                  //          border: OutlineInputBorder(),
                                  //          labelText: 'Please Enter Comment',
                                  //          hintStyle: Design.edit_text,
                                  //          hintText: 'Comment',
                                  //        ),
                                  //        autofocus: false,
                                  //      ),
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

        }
      });
    } else {
      _retrieveDataError = response.exception.code;
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
                List<String> imagesbase = [];
                for (int x = 0; x < _imageFileList.length; x++) {
                  print("abeer  " + x.toString());
                  Uint8List uint8list = await XFile(_imageFileList[x].path)
                      .readAsBytes();
                  String base64String = base64Encode(
                      uint8list); // must be called in async method
                  // List<int> bytes = File(_imageFileList[x].path).readAsBytesSync();
                  print(base64String);
                  imagesbase.add(base64String);
                }
                print("abeer");
                print(imagesbase[0]);
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
    return new WillPopScope(
      //onWillPop: _onWillPop,
        child: new Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: <Widget>[

                _getContent(),
              ],
            ),
          ),
        ));
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
class Item {
  XFile imagefile;
  // final String comment;

  Item(this.imagefile);
}