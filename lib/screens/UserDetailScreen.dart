import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zonezero/models/Doctor.dart';
import 'package:zonezero/screens/BuyPremiumScreen.dart';
import 'package:zonezero/screens/GetAppointmentScreen.dart';

class UserDetailScreen extends StatefulWidget{
  Doctor doctor;

  UserDetailScreen(this.doctor);

  @override
  State<StatefulWidget> createState() {
    return UserDetailScreenState(doctor);
  }

}

class UserDetailScreenState extends State{
  Doctor doctor;
  UserDetailScreenState(this.doctor);
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

  buildBody() {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, left: 29.0, right: 31.0),
      child: Column(
        children: [
          buildProfileContainer(),
          buildGetAppointmentButton(),
          buildBuyPremiumButton(),
        ],
      ),
    );
  }

  Widget buildProfileContainer(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 20.0),
            SizedBox(
              width: 83.0,
              height: 83.0,
              child: CircleAvatar(
                backgroundImage: NetworkImage(doctor.url),
              ),
            ),
            SizedBox(height: 6.38,),
            Text(doctor.full_name, style: TextStyle(color: Color(0xFF6A6A77), fontSize: 14.0, fontWeight: FontWeight.normal), textAlign: TextAlign.left,),
            Visibility(
                visible: (doctor.user_status == "premium"),
                child: Text("Premium", style: TextStyle(color: Color(0xFFFEAC02), fontSize: 12.0, fontWeight: FontWeight.normal), textAlign: TextAlign.left)
            ),
            SizedBox(height: 20.85,),
          ],
        ),
      ),
    );
  }

  Widget buildGetAppointmentButton(){
    return Visibility(
      visible: (doctor.user_status == "premium"),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListTile(
            title: Text("Randevu Al", style: TextStyle(color: Color(0xFF1C8E5D), fontSize: 12.0, fontWeight: FontWeight.w800),),
            trailing: Icon(Icons.arrow_forward_ios_rounded),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => GetAppointmentScreen()));
          },
        ),
      ),
    );
  }

  Widget buildBuyPremiumButton(){
    return Visibility(
      visible: !(doctor.user_status == "premium"),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: ListTile(
          title: Text("Premium Paket Al", style: TextStyle(color: Color(0xFF1C8E5D),fontSize: 12.0 , fontWeight: FontWeight.w800),),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF1C8E5D),),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => BuyPremiumScreen()));
          },
        ),
      ),
    );
  }

}