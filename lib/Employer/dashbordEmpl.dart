import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itfreelance/Employer/myjobs.dart';
import 'package:itfreelance/Employer/profilemp.dart';
import 'package:itfreelance/GeneralAdresse.dart';
import 'package:itfreelance/LoginRegister/Login.dart';
import 'package:itfreelance/LoginRegister/Role.dart';
import 'package:itfreelance/LoginRegister/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/constants.dart';
import 'acceuilempl.dart';
import 'package:http/http.dart' as http;

import 'listfreelancer.dart';


class Dashbordempl extends StatefulWidget {


  Dashbordempl({Key key, this.value}) : super(key: key);
  final int value;




  @override
  _DashbordemplState createState() => _DashbordemplState();



}

Future<void> getpreferd() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('emailuser');
  var role = preferences.getString('roleuser');
  var id = preferences.getInt('iduser');
  print(id);
print(role);
print(email);



}

class _DashbordemplState extends State<Dashbordempl> {
  List<job> jobs = [];




    int _currentIndex = 0;
    final List<Widget> _children = [
      Listfreelancer(),
      MyJobList(),
      UserProfilePage()
    ];

  @override
  Widget build(BuildContext context) {
    getpreferd();
    //listjobs();
    var image=GeneralAdresse().Gadress+"uploads/hatem@.jpeg";
    return Scaffold(
      appBar: AppBar(
        title: Text('ItFreelancer'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'profile','Logout' }.map((String choice) {

                return PopupMenuItem<String>(
                  value: choice,
                  child: ListTile(
                leading: IconButton(
                icon:  choice=="profile"? CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffFDCF09),
                  child: image!= null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child:  Image.network(
                      image,
                      height: 100,
                      width: 100,



                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,

                  ),
                ) : Icon(Icons.logout),
                ),
                  trailing: Text(choice),));
              }).toList();
            },
          ),
        ],
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [

          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            title: Text('Freelancers'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text('Jobs')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

    });
  }




  Future<Widget> handleClick(String value) async {
    switch (value) {
      case 'Logout':
        {SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {

              return  new LoginScreen();})
        );
        }
        break;
      case 'profile':{

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {

            return  new UserProfilePage();})
      );}
        break;
    }
  }
}
class job {
  int  jobid;
  String title;
  String description;
  String datepost;
  String budget;
  String budgettype;
  String skills;
  String jobstatus;
  String postermail;
  String posterid;
  String full_name;





  job(this.title, this.datepost,this.jobstatus);
}