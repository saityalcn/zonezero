import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:zonezero/models/Doctor.dart';

class Api{
  var url = Uri.parse('https://www.mobillium.com/android/doctors.json');

  Future<List<Doctor>> getDoctors(String name) async{
    List<Doctor> doctors = [];
    int i = 0;
    final response = await http.get(url);
    var jsonResponse = convert.json.decode(convert.utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    try {
      while(jsonResponse['doctors'][i] != null){
        if(jsonResponse['doctors'][i]['full_name'].toUpperCase().contains(name.toUpperCase()))
          doctors.add(new Doctor.fromJson(jsonResponse['doctors'][i]));
        i++;
      }
    } catch(e){
      return doctors;
    }
    return doctors;
  }

  Future<List<Doctor>> getMaleDoctors(String name) async{
    List<Doctor> doctors = [];
    int i = 0;
    final response = await http.get(url);
    var jsonResponse = convert.json.decode(convert.utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    try {
      while(jsonResponse['doctors'][i] != null){
        if(jsonResponse['doctors'][i]['gender'] == "male" && jsonResponse['doctors'][i]['full_name'].toUpperCase().contains(name.toUpperCase()))
          doctors.add(new Doctor.fromJson(jsonResponse['doctors'][i]));

        i++;
      }
    } catch(e){
      return doctors;
    }
    return doctors;
  }

  Future<List<Doctor>> getFemaleDoctors(String name) async{
    List<Doctor> doctors = [];
    int i = 0;
    final response = await http.get(url);
    var jsonResponse = convert.json.decode(convert.utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    try {
      while(jsonResponse['doctors'][i] != null){
        if(jsonResponse['doctors'][i]['gender'] == "female" && jsonResponse['doctors'][i]['full_name'].toUpperCase().contains(name.toUpperCase()))
          doctors.add(new Doctor.fromJson(jsonResponse['doctors'][i]));
        i++;
      }
    } catch(e){
      return doctors;
    }
    return doctors;
  }

}