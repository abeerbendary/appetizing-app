import 'MenuData.dart';

class AdressCustomer {
String id;
String type;
String customer_id;
String name;
String block;
String road;
String flat;
String stampdatetime;
String building;
String note;
String latitude;
String longitude;


AdressCustomer(this.id, this.type, this.customer_id,this.name,
this.block, this.road, this.flat,this.stampdatetime,
this.building, this.note, this.latitude,this.longitude);

factory AdressCustomer.fromJson(dynamic json) {

return AdressCustomer(
json['id'] as String,
json['type'] as String,
json['customer_id'] as String,
json['name'] as String,
json['block'] as String,
json['road'] as String,
json['flat'] as String,
json['stampdatetime'] as String,
json['building'] as String,
json['note'] as String,
json['latitude'] as String,
json['longitude'] as String,
);

}
@override
String toString() {
return '{ ${this.name} ${this.note} }';
}


// @override
// String toString() {
//   return '{ ${this.name}, ${this.quantity} }';
// }
}
