import 'package:appetizing/Screens/DataForItems.dart';

import 'MenuData.dart';

class CurrentSubr{
  static var CurrentObj;
  static var CurrentSub;
  static var CurrentMenu;
  static int countitem;
  static bool visublity=false;
  static List<MenuData> ChooseList=[];
  static List Days=[];
  static List Days_index=[];
  static var Address_id="-1";
  static var Address_index=-1;
  static List adreess=[];

}
// CurrentSubr.CurrentObj = {_InternalLinkedHashMap} size = 43
// 0 = {map entry} "id" -> "20"
// 1 = {map entry} "name" -> "Subscription Name"
// 2 = {map entry} "customer_id" -> "5"
// 3 = {map entry} "customer_name" -> "ALAA GOMAA"
// 4 = {map entry} "birth_date" -> "2022-11-10"
// 5 = {map entry} "gender" -> "Male"
// 6 = {map entry} "fitness_goal_id" -> "1"
// 7 = {map entry} "fitness_en_name" -> "Lose Weight"
// 8 = {map entry} "fitness_ar_name" -> "تخسيس الوزن"
// 9 = {map entry} "activity_id" -> "1"
// 10 = {map entry} "activity_en_name" -> "Little or no exercise"
// 11 = {map entry} "activity_ar_name" -> "خفيف بدون حركه"
// 12 = {map entry} "plane_id" -> "1"
// 13 = {map entry} "plane_en_name" -> "BALANCED"
// 14 = {map entry} "plane_ar_name" -> "وجبات متوازنة"
// 15 = {map entry} "address_id" -> "1"
// 16 = {map entry} "current_weight" -> "65"
// 17 = {map entry} "current_height" -> "173"
// 18 = {map entry} "target_weight" -> "75"
// 19 = {map entry} "cretaeddatetime" -> "2022-11-17 10:10:06"
// 20 = {map entry} "status" -> "H"
// 21 = {map entry} "package_id" -> "1"
// 22 = {map entry} "package_en_name" -> "BREAKFAST,LUNCH & DINNER"
// 23 = {map entry} "package_ar_name" -> "وجبة افطار , افطار , عشاء"
// 24 = {map entry} "start_date" -> "2022-11-10"
// 25 = {map entry} "delivery_time_id" -> "1"
// 26 = {map entry} "delivery_en_name" -> "7AM TO 11AM(MORNING)"
// 27 = {map entry} "delivery_ar_name" -> "7AM TO 11AM(الصباح)"
// 28 = {map entry} "payment_method_id" -> "0"
// 29 = {map entry} "payment_en_name" -> null
// 30 = {map entry} "payment_ar_name" -> null
// 31 = {map entry} "lady_period_id" -> "0"
// 32 = {map entry} "lady_period_en_name" -> null
// 33 = {map entry} "lady_period_ar_name" -> null
// 34 = {map entry} "chronic_diseases" -> ""
// 35 = {map entry} "medicines_supplements" -> ""
// 36 = {map entry} "medical_test" -> "[]"
// 37 = {map entry} "meal" -> "2"
// 38 = {map entry} "salad" -> "1"
// 39 = {map entry} "snack" -> "1"
// 40 = {map entry} "day_count" -> "35"
// 41 = {map entry} "server_date" -> "2022-11-28"
// 42 = {map entry} "end_date" -> "2022-12-15"