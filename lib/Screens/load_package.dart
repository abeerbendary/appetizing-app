class load_package {
  final int id;
  int package_id;
  String en_name;
  String en_desc;
  String ar_name;
  String ar_desc;
  double price;
  String image_path;
   int day_count;
  String type;

  load_package({
   this.id,
    this.package_id,
    this.en_name,
    this.en_desc,
    this.ar_name,
    this.ar_desc,
    this.price,
    this.image_path,
    this.day_count,
    this.type,

  });

  factory load_package.fromJson(dynamic json) {
    return load_package(
      id: json['id'] as int,
      package_id: json['package_id'],
      en_name: json['en_name'],
      en_desc: json['en_desc'],
      ar_name: json['ar_name'],
      ar_desc: json['ar_desc'],
      price: json['price'],
      image_path: json['image_path'],
      day_count: json['day_count'],
      type: json['type'],

    );
  }
}