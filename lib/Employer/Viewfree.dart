import 'package:flutter/material.dart';
import 'package:itfreelance/Employer/detailapplied.dart';

class Viewfree extends StatelessWidget {
  String name;
  String title;
  String image;
  String location;
  String about;
  String skill;
  String index;

  Viewfree(this.name, this.title, this.image, this.location, this.about, this.skill, this.index);
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> freelancer = new Map<String, dynamic>();
    freelancer["name"]= name;
    freelancer["title"]= title;
    freelancer["image"]= image;
    freelancer["location"]= location;
    freelancer["about"]= about;
    freelancer["skill"]= skill;
    return Card(
        child: new InkWell(
          onTap: () {
           Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {

             return new Detailapplied(freelancer:freelancer);
          },),);
    },


      child: Row(

        children: [Center(
          child: GestureDetector(

            child: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: image != null
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
            ),
          ),
        ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(name ,

                style: TextStyle(
                  color: Colors.blueAccent,
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,

                ),), Text(title ,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,

                )
                ,), Text(location ,
                style: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'OpenSans',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                ),)],
            ),

          )
        ],
      ),

    ));
  }


}