import 'ImageList.dart';

class ClientData {
  ClientData._();
  // "fitness_goal_id": "1",
  // "activity_id": "1",
  // "plane_id": "2",
  // "address_id": "8",
  // "current_weight": "80",
  // "current_height": "120",
  // "target_weight": "80",
  // "package_id": "2",
  // "start_date": "2022-12-10",
  // "delivery_time_id": "2",
  // "week": [
  // "Monday",
  // "Tuesday",
  // "Wednesday"
  // ],
  // "non_eatable": [
  // 2,
  // 4
  // ],
  // "payment_method": "1",
  // "lady_period_id": "2",
  // "chronic_diseases": [
  // 2,
  // 3
  // ],
  // "medicines_supplements": "yesss",
  // "consultation_followup": "2",
  // "medical_test": [
  // {
  // "note": "",
  // "image": "",
  // "image_format": ""
  // }
  // ]
  static String Name="";
  static String birth_date="";
  static String gender="";
  static String fitness_goal_id="";
  static String activity_id;
  static String plane_id;
  static String address_id;
  static String current_weight;
  static String current_height;
  static String target_weight;
  // static String package_id;
  static String start_date;
  static String delivery_time_id;
  static List<String> week;
 // static String non_eatable;
  static String payment_method;
  static String lady_period_id;
  // static String chronic_diseases;
  static String medicines_supplements;
  static String consultation_followup;
  static List<Map<String, dynamic>> medical_test=[];
  //static String Email;
}
