import 'package:image_picker/image_picker.dart';

import 'MenuData.dart';

class ImageList {
  String note="";
  String image="";
  String image_format="";
  XFile imagefile;

  //ImageList(this.imagefile);
  ImageList(this.note, this.image, this.image_format,this.imagefile);
  String get get_note {
    return note;
  }

  void set_note(String notes) {
    note = notes;
  }

  String get get_image {
    return image;
  }

  void set_image(String images) {
    image = images;
  }

  String get get_image_format {
    return image_format;
  }

  void set_image_format(String image_formats) {
    image_format = image_formats;
  }

  XFile get get_imagefile {
    return imagefile;
  }

  void set_imagefile(XFile imagefiles) {
    imagefile = imagefiles;
  }
  Map toJson() => {
    "note": note,
    "image": image,
    "image_format": image_format,
  };
}