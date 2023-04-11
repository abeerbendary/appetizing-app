// update_subscription_date
// class update_subscription_date {
//   String api_token;
//   String en_name;
//   String ar_name;
//   String en_desc;
//   String ar_desc;
//   String item_master_package_id;
//   String size_id;
//   String Comment="";
//   List<SizeListItems> size_list;
//   DataForItems(this.id, this.en_name,this.ar_name,this.en_desc, this.ar_desc,this.item_master_package_id,this.size_id,[this.size_list]){
//
//   }
//
//   // String get get_size_id {
//   //   return size_id;
//   // }
//   // void set_size_id(String id) {
//   //   size_id = id;
//   // }
//   // String get get_Comment {
//   //   return Comment;
//   // }
//   //
//   // void set_Comment(String note) {
//   //   Comment = note;
//   // }
//   factory update_subscription_date.fromJson(dynamic json) {
//     if (json['size_list'] != null) {
//       var ItemsObjsJson = json['size_list'] as List;
//       List<SizeListItems> size_list = ItemsObjsJson.map((itemJson) => SizeListItems.fromJson(itemJson)).toList();
//       return update_subscription_date(
//           json['id'] as String,
//           json['en_name'] as String,
//           json['ar_name'] as String,
//           json['en_desc'] as String,
//           json['ar_desc'] as String,
//           json['item_master_package_id'] as String,
//           json['size_id'] as String,
//           size_list
//       );
//     } else {
//       return update_subscription_date(
//         json['id'] as String,
//         json['en_name'] as String,
//         json['ar_name'] as String,
//         json['en_desc'] as String,
//         json['ar_desc'] as String,
//         json['item_master_package_id'] as String,
//         json['size_id'] as String,
//       );
//     }
//   }
//   @override
//   String toString() {
//     return '{ ${this.en_name}, ${this.en_desc},${this.size_id},${this.Comment}, ${size_list} }';
//   }
//
//
// // @override
// // String toString() {
// //   return '{ ${this.name}, ${this.quantity} }';
// // }
// }