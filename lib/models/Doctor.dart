import 'dart:convert' as convert;

class Doctor{
  String full_name;
  String user_status;
  String gender;
  String url;

  Doctor(){}

  Doctor.fromJson(dynamic json){
    full_name = json["full_name"];
    user_status = json["user_status"];
    gender = json["gender"];
    url = json["image"]["url"];
    print(full_name);
    print(url);
  }


}