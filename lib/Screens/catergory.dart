class category{


  String name;
  String PackageName;
  // String icon;
  // Color color;
  String StartDate;
  String EndDate;
  String imageName;

  List<category> subCat;
  category({ this.PackageName, this.name, this.imageName, this.subCat, this.StartDate, this.EndDate});
// category({required this.name,required this.icon,required this.color,required this.imageName,required this.subCat});


}