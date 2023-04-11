class SizeListItems {

  String size_master_id;
  String en_name;
  String ar_name;
  String calories;
  String fat;
  String protein;
  String carbs;

  SizeListItems(this.size_master_id, this.en_name,this.ar_name,this.calories,
      this.carbs,this.fat,this.protein);

  factory SizeListItems.fromJson(dynamic json) {
    return SizeListItems(json['size_master_id'] as String, json['en_name'] as String,
        json['ar_name'] as String, json['calories'] as String,
        json['carbs'] as String, json['fat'] as String,
        json['protein'] as String);
  }
  // String get get_en_name {
  //   return en_name;
  // }
  // String get get_protein {
  //   return protein;
  // }
  //
  // String get get_calories {
  //   return calories;
  // }
  //
  // String get get_fat{
  //   return fat;
  // }
  //
  // String get get_carbs{
  //   return carbs;
  // }

  @override
  String toString() {
    return '{ ${this.en_name}, ${this.carbs} }';
  }
}