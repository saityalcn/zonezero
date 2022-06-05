import 'package:flutter/material.dart';

class GetAppointmentScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFF1C8E5D),
    );
  }

  Widget buildBody(){
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 92, right: 127),
        child: Text("Randevu Ekranı", style: TextStyle(color: Color(0xFF6A6A77), fontSize: 21.0, fontWeight: FontWeight.w600),),
      ),
    );
  }

}