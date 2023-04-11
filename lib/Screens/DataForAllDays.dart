
import 'MenuData.dart';

class DataForAllDays {
  String id;
  String ondate;
  String address_id;
  String status;
  List<MenuData> menu;

  DataForAllDays(this.id, this.ondate, this.address_id,this.status,[this.menu]);
  // String get get_size_id {
  //   return size_id;
  // }
  //
  // void set_size_id(String id) {
  //   size_id = id;
  // }
  //
  // String get get_Comment {
  //   return Comment;
  // }
  //
  // void set_Comment(String note) {
  //   Comment = note;
  // }

  factory DataForAllDays.fromJson(dynamic json) {
    if (json['menu'] != null) {
      var ItemsObjsJson = json['menu'] as List;
      List<MenuData> menu_list = ItemsObjsJson.map((itemJson) => MenuData.fromJson(itemJson)).toList();
      return DataForAllDays(
          json['id'] as String,
          json['ondate'] as String,
          json['address_id'] as String,
          json['status'] as String,
          menu_list
      );
    } else {
      return DataForAllDays(
          json['id'] as String,
          json['ondate'] as String,
          json['address_id'] as String,
        json['status'] as String,
      );
    }
  }
  @override
  String toString() {
    return '{ ${this.ondate} ${this.menu} }';
  }


// @override
// String toString() {
//   return '{ ${this.name}, ${this.quantity} }';
// }
}