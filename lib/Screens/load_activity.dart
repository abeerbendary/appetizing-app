class load_activity {
  final int id;
  String en_name;
  String ar_name;

  load_activity({
    this.id,
    this.en_name,
    this.ar_name,
  });

  factory load_activity.fromJson(dynamic json) {
    return load_activity(
      id: json['id'] as int,
      en_name: json['en_name'],
      ar_name: json['ar_name'],
    );
  }
}