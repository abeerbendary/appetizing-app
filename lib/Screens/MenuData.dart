class MenuData {
String id;
// String item_master_id;
 String item_master_package_id;
String item_en_name;
String item_ar_name;
String note;
String size_id;
String size_en_name;
String size_ar_name;
String calories;
String fat;
String protein;
String carbs;
String rate="0";
String favorite="0";
  MenuData(this.id,this.item_master_package_id,this.item_en_name,this.item_ar_name,this.note,this.size_id,
this.size_en_name,this.size_ar_name,this.calories,this.fat,this.protein,this.carbs,this.rate,this.favorite);
  String get get_rate {
    return rate;
  }
  void set_rate(String rates) {
    rate = rates;
  }
  String get get_favorite {
    return favorite;
  }
  void set_favorite(String favorites) {
    favorite = favorites;
  }
factory MenuData.fromJson(dynamic json) {
return MenuData(json['id'] as String ,json['item_master_package_id'] as String,json['item_en_name'] as String,
json['item_ar_name'] as String, json['note'] as String,json['size_id'] as String,
json['size_en_name'] as String, json['size_ar_name'] as String,
json['calories'] as String, json['fat'] as String,
    json['rate'] as String, json['favorite'] as String,
json['protein'] as String, json['carbs'] as String);
}

@override
String toString() {
return '{ ${this.carbs}, ${this.carbs} }';
}
}