import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itfreelance/Employer/DetailsJobs.dart';
import 'package:itfreelance/Employer/addjobs.dart';
import 'package:itfreelance/GeneralAdresse.dart';
import 'package:itfreelance/LoginRegister/Login.dart';
import 'package:itfreelance/LoginRegister/Role.dart';
import 'package:itfreelance/LoginRegister/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utilities/constants.dart';
import 'acceuilempl.dart';
import 'package:http/http.dart' as http;

class MyJobList extends StatefulWidget {
  MyJobList({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyJobListState createState() =>

  _MyJobListState();

}

class _MyJobListState extends State<MyJobList> {
  List<Map<String, dynamic>> myjobs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myjobs= new List<Map<String, dynamic>>();
    http.get(GeneralAdresse().Gadress + "/employerfreelancer/myjobs.php?id=70",headers: {"content-type": "application/json"}).then((http.Response response) {
      //print("hello"+response.body.toString());
      // = json.decode(response.body);
      ////ligne la plus importante!!!!!!!!
      print((Utf8Codec().decode(response.bodyBytes)).toString());
      List<dynamic> l=json.decode( Utf8Codec().decode(response.bodyBytes));

    //  List<dynamic> l = map['joblist'];
      for (int i = 0; i < l.length; i++) {
       // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
        Map<String, dynamic> job = l[i];
        myjobs.add(job);
        print(job['title']);
        //myjobs.add(m);
      }
      setState(() {});
    });
  }

 /* Future  listjobs() async {
    int id=70;
    var url = GeneralAdresse().Gadress + "myjobspost.php?userid="+id.toString();
    myjobs= new List<Map<String, dynamic>>();
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    /*request.add(utf8.encode(json.encode(<String, dynamic>{
      'userid': 70,})));*/
   /* HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);

    httpClient.close();
    Map<String, dynamic>map = json.decode(reply);


    List<dynamic> l = map['joblist'];
    for (int i = 0; i < l.length; i++) {
      Map<String, dynamic> m = l[i] as Map<String, dynamic>;
      print(m['title']);
      myjobs.add(m);
    }


  }*/
*/





  @override
  Widget build(BuildContext context) {
    //listjobs();
    //print("jobs numbers= "+myjobs.length.toString());
    if(myjobs.isEmpty==true) {
     // listjobs();
    }else{

    }



    return Scaffold(

      body: _buildsListView(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) {

                return new addjobs();})
          );
        },
        child: Icon(Icons.plus_one),
        backgroundColor: Colors.green,
      ),
    );
  }

  ListView _buildsListView(BuildContext context){


    return ListView.builder(itemCount: myjobs.length,
      itemBuilder: (BuildContext ctxt,index){
        return Card(
            child:ListTile(
              title: Text( myjobs[index]['title'].toString() ,style:TextStyle(
                fontFamily: 'Roboto',
                color: Colors.blueAccent,
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              )),
              subtitle: Text(myjobs[index]['datepost'].toString()+"fgnhgnfgfnjkhkjhkjhkjh"),


              leading: Icon(Icons.work),

              trailing: IconButton(icon: Icon(Icons.arrow_forward) ,
                onPressed:(){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {

                      return new Details(index:myjobs[index]['jobid']);})
                  );

                } ,)
              ,


            ));

      },
    );
  }



}