import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itfreelance/Employer/Appliedfreelancers.dart';
import 'package:itfreelance/GeneralAdresse.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {

  Details( {Key key, this.index}) : super(key: key);
    final  int index;



  @override
  _DetailsState createState() =>

      _DetailsState();}

  class _DetailsState extends State<Details> {
    List<Map<String, dynamic>> myjobs;


static int id;
static bool available;


    @override
    void initState() {
      available= false ;
      // TODO: implement initState
      super.initState();
      id= widget.index;
      myjobs= new List<Map<String, dynamic>>();
  http.get(GeneralAdresse().Gadress + "/jobs/jobdetails.php?id="+id.toString(),headers: {"content-type": "application/json"}).then((http.Response response) {
  //print("hello"+response.body.toString());
  // = json.decode(response.body);
  ////ligne la plus importante!!!!!!!!
  print((Utf8Codec().decode(response.bodyBytes)).toString());
  List<dynamic> l=json.decode( Utf8Codec().decode(response.bodyBytes));

  //  List<dynamic> l = map['joblist'];

  // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
  Map<String, dynamic> job = l[0];
  myjobs.add(job);
  job.toString();
  if(job['jobstatus'].toString().contains("looking for freelancers")){
    available=true;

  }
  print(job['title']);
  //myjobs.add(m);

      setState(() {});
       });
    }
    Widget _buildButtons() {
      if (available == true) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => {

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {

                            return new Appliedfreelancer(index:myjobs[0]['jobid']);}))


                    }
                  ,
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: Color(0xFF404A5C),
                    ),
                    child: Center(
                      child: Text(
                        "Applied freelancers",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,

                        ),
                      ),

                    ),
                  ),
                ),
              ),

            ],
          ),
        );
      }else{
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),);
      }
    }



    @override
    Widget build(BuildContext context) {
      {
        return Scaffold(
          appBar: AppBar(
            title: Text('Job details'),
            elevation: 0,
            backgroundColor: Colors.lightBlueAccent,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {},
            ),

          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 16),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height:/* MediaQuery
                    .of(context)
                    .size
                    .height / 2*/ 200,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32)
                  ),
                ),
                child: Column(

                  children: <Widget>[


                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 32),
                      child: Text(myjobs[0]['title'],
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),




                        _buildButtons()],

                      ),
                    ),



              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 3,
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[


                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child:
                          Text("Job description: ",
                            style: TextStyle(

                                fontSize: 20,

                                color: Colors.black
                            ),

                          ),

                        ),






                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 3, 50, 3),
                      child:
                      Text(myjobs[0]["description"],
                        style: TextStyle(
                            fontSize: 20,

                            color: Colors.black
                        ),maxLines: 20,

                      ),

                    ),
                    Padding(

                      padding: const EdgeInsets.only(

                      ),
                      child: Text(myjobs[0]['jobstatus'],

                        style: TextStyle(
                            fontSize: 15,


                            color:myjobs[0]['jobstatus'].toString().contains("looking") ? Colors.redAccent : Colors.green
                          // Colors.white70
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    }


  }
