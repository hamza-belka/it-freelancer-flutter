import 'package:flutter/material.dart';
import 'package:itfreelance/Employer/Viewfree.dart';

import 'package:http/http.dart' as http;
import 'package:itfreelance/Employer/detailapplied.dart';
import 'dart:convert';

import 'package:itfreelance/GeneralAdresse.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appliedfreelancer extends StatefulWidget {
  Appliedfreelancer( {Key key, this.index}) : super(key: key);
  final  int index;
  @override
  _AppliedfreelancerState createState() => _AppliedfreelancerState();
}

class _AppliedfreelancerState extends State<Appliedfreelancer> {
  static int id;
  List<Map<String, dynamic>> freelancers;
Future getid() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  id = preferences.getInt("userid");

}
  @override
  void initState() {
    super.initState();
    getid();
    print(id.toString());
    print(widget.index.toString());
    freelancers= new List<Map<String, dynamic>>();
    http.get(GeneralAdresse().Gadress + "/employerfreelancer/myapplicationsemp.php?id="+id.toString()+"&jobid="+widget.index.toString(),headers: {"content-type": "application/json"}).then((http.Response response) {
      //print("hello"+response.body.toString());
      // = json.decode(response.body);
      ////ligne la plus importante!!!!!!!!
      print((Utf8Codec().decode(response.bodyBytes)).toString());
      List<dynamic> l=json.decode( Utf8Codec().decode(response.bodyBytes));

      //  List<dynamic> l = map['joblist'];
      for (int i = 0; i < l.length; i++) {
        // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
        Map<String, dynamic> free = l[i];
        freelancers.add(free);
        print(free['title']);

        //myjobs.add(m);

      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Freelancers"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {

          return Viewfree(freelancers[index]["fullname"], freelancers[index]["profiletitle"], GeneralAdresse().Gadress+"uploads/"+freelancers[index]["usermail"]+".jpeg",freelancers[index]["location"],freelancers[index]["about"],freelancers[index]["skill"], widget.index.toString());
        },


        itemCount: freelancers.length,



      ),

      // body: ListView(
      //   children: [
      //     CarView("peugeot","208","Images/208.jpg"),
      //     CarView("peugeot","206","Images/bmw.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //     CarView("peugeot","208","Images/chery.jpg"),
      //   ],
      // ),
    );
  }
}

