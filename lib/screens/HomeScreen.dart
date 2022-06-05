import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zonezero/data/Api.dart';
import 'package:zonezero/models/Doctor.dart';
import 'package:zonezero/screens/UserDetailScreen.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }

}

class HomeScreenState extends State{
  TextEditingController _searchController = new TextEditingController();
  bool isMale = false;
  bool isFemale = false;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: buildAppBar(),
        body: buildBody()
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      backgroundColor: Color(0xFF1C8E5D),
    );
  }

  Widget buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          buildSearchBar(),
          buildFilterBoxesContainer(),
          SizedBox(height: 25.0,),
          buildDoctorsList(),
          SizedBox(height: 32.0,),
        ],
      ),
    );
  }

  Widget buildSearchBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
          color: Color(0xFFFFFFFF),
        ),
        child: TextFormField(
          onChanged: (text) {
            setState(() {

            });
          },
          decoration: InputDecoration(
            hintText: "Klinik ara...",
            hintStyle: TextStyle(color: Color(0xFFAEAEB4), fontSize: 12.0, fontWeight: FontWeight.w600),
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
            controller: _searchController,
        ),
      ),
    );
  }

  Widget buildFilterBoxesContainer(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: Color(0xFFFFFFFF),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildFilterBoxFemale(),
          buildFilterBoxMale(),
        ],
      ),
    );
  }

  Widget buildFilterBoxMale(){
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Checkbox(
              value: isMale,
              onChanged:(bool value){
                setState(() {
                  isMale = value;
                  isFemale = false;
                });
          },
          ),
        ),
        SizedBox(width: 15.0,),
        Text("Erkek", style: TextStyle(color: Color(0xFFAEAEB4), fontSize: 12.0, fontWeight: FontWeight.w600),)
      ],
    );
  }

  Widget buildFilterBoxFemale(){
    return Row(
      children: [
        Checkbox(
            value: isFemale,
            onChanged:(bool value){
              setState(() {
                isFemale = value;
                isMale = false;
              });
            }
            ),
        SizedBox(width: 15.0,),
        Text("Kadın", style: TextStyle(color: Color(0xFFAEAEB4), fontSize: 12.0, fontWeight: FontWeight.w600),)
      ],
    );
  }

  Widget buildDoctorsList() {
    return Container(
        child: FutureBuilder(
          future: getDoctorList(),
          builder: (BuildContext context, AsyncSnapshot<List<Doctor>> snapshot){
            if(!snapshot.hasData)
              return CircularProgressIndicator();

            else if(snapshot.data.isEmpty)
              return buildEmptyListPage();

            else{
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                    borderRadius: BorderRadius.circular(7.0)
                  ),
                  child: ListView.builder(
                    shrinkWrap: false,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    itemBuilder: (BuildContext context, int index){
                      return buildDoctorsListItem(snapshot.data[index]);
                    },
                    itemCount: snapshot.data.length,
                  ),
                ),
              );
            }
          },
        ),
      );
  }

  Widget buildDoctorsListItem(Doctor doctor) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Color(0xFFE3E3E3)),
        ),
        color: Color(0xFFFFFFFF)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListTile(
          leading: SizedBox(
            width: 38.0,
            height: 38.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(doctor.url),
            ),
          ),
          title: Text((doctor.full_name == null) ? "" : doctor.full_name, style: TextStyle(fontSize: 12.0, color: Color(0xFF6A6A77),fontWeight: FontWeight.w600)),
          trailing: SizedBox(
              width: 7.0,
              child: Icon(Icons.arrow_forward_ios, color: Color(0xFFAEAEB4),)
          ),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailScreen(doctor)));
          },
        ),
      ),
    );
  }

  Widget buildEmptyListPage() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 119.0,),
          SizedBox(
            width: 136.79,
            height: 136.79,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person_outline, size: 60.0,color: Color(0xFFAEAEB4),),
            ),
          ),
          SizedBox(height: 17.61,),
          Text("Kullanıcı bulunamadı. ", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),),

        ]
      ),
    );
  }

  Future<List<Doctor>> getDoctorList(){
    Api api = new Api();
    if(isMale)
      return api.getMaleDoctors(_searchController.text);

    else if(isFemale)
        return api.getFemaleDoctors(_searchController.text);

    else
      return api.getDoctors(_searchController.text);
  }

}