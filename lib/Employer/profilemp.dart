
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:itfreelance/GeneralAdresse.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class UserProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>_UserProfilePageState();
}
class _UserProfilePageState extends State<UserProfilePage> {

  static String fullname;
  static int id;
  static String title;
  static String image;
  static String location;
  static String about;
  List<Map<String, dynamic>> pros;
  static Map<String, dynamic> profile;
  Future login() async {
    var url = GeneralAdresse().Gadress+"profiles/getemployerinfos.php";
    var response = await http.post(url,headers: {"content-type": "application/json"},body: jsonEncode(<String, dynamic>{

      'id': 3,

    }),);
    print((Utf8Codec().decode(response.bodyBytes)).toString());
    var data = json.decode(Utf8Codec().decode(response.bodyBytes));

    print(data["id"]);
    about=data["about"];
    print(about);

    //print('Response body: ${response.body[10]}');

  }

  @override
  void initState() {
    super.initState();
    getinfos();

    login();
    if (about==null){
      login();
    }
   /* profile = new Map<String, dynamic>();
    pros = new List<Map<String, dynamic>>();
    http.get(GeneralAdresse().Gadress + "/profiles/getemployerinfos.php?id=" +
        id.toString(), headers: {"content-type": "application/json"}).then((
        http.Response response) {
      //print("hello"+response.body.toString());
      // = json.decode(response.body);
      ////ligne la plus importante!!!!!!!!
      print((Utf8Codec().decode(response.bodyBytes)).toString());
      List<dynamic> l = json.decode(Utf8Codec().decode(response.bodyBytes));

      //  List<dynamic> l = map['joblist'];

      // Map<String, dynamic> m = l[i] as Map<String, dynamic>;
      Map<String, dynamic> job = l[0];
      profile = job;
      title = job['profiletitle'];
      fullname = job['fullname'];
      about = job['about'];
      location = job['location'];
      image = GeneralAdresse().Gadress + job['userimage'];
      pros.add(job);
      job.toString();
      print(job['title']);
    }

    );*/
    setState(() {});
  }



  Future getinfos() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getInt("userid");
    print(id.toString());

  }


  final String _fullName = "Nick Frost";
  final String _status = "Software Developer";
  final String _bio =
      "\"Hi, I am a Freelance developer working for hourly basis. If you wants to contact me to build your product leave a message.\"";
  final String _followers = "173";
  final String _posts = "24";
  final String _scores = "450";

  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/qr.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(


      child: CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xffFDCF09),
        child: image != null
            ? ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
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

    );
  }

  Widget _buildFullName() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      fullname,
      style: _nameTextStyle,
    );
  }

  Widget _buildlocation() {
    TextStyle _nameTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w700,
    );

    return Text(
      location,
      style: _nameTextStyle,
    );
  }

  Widget _buildStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      decoration: BoxDecoration(
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Spectral',
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String count) {
    TextStyle _statLabelTextStyle = TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontSize: 16.0,
      fontWeight: FontWeight.w200,
    );

    TextStyle _statCountTextStyle = TextStyle(
      color: Colors.black54,
      fontSize: 24.0,
      fontWeight: FontWeight.bold,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count,
          style: _statCountTextStyle,
        ),
        Text(
          label,
          style: _statLabelTextStyle,
        ),
      ],
    );
  }

  Widget _buildStatContainer() {
    return Container(
      height: 60.0,
      margin: EdgeInsets.only(top: 8.0),
      decoration: BoxDecoration(
        color: Color(0xFFEFF4F7),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildStatItem("Followers", _followers),
          _buildStatItem("Posts", _posts),
          _buildStatItem("Scores", _scores),
        ],
      ),
    );
  }

  Widget _buildBio(BuildContext context) {
    TextStyle bioTextStyle = TextStyle(
      fontFamily: 'Spectral',
      fontWeight: FontWeight.w400,
      //try changing weight to w500 if not thin
      fontStyle: FontStyle.italic,
      color: Color(0xFF799497),
      fontSize: 16.0,
    );

    return Container(
      color: Theme
          .of(context)
          .scaffoldBackgroundColor,
      padding: EdgeInsets.all(8.0),
      child: Text(
        about,
        textAlign: TextAlign.center,
        style: bioTextStyle,
      ),
    );
  }

  Widget _buildSeparator(Size screenSize) {
    return Container(
      width: screenSize.width / 1.6,
      height: 2.0,
      color: Colors.black54,
      margin: EdgeInsets.only(top: 4.0),
    );
  }

  Widget _buildGetInTouch(BuildContext context) {
    return Container(
      color: Theme
          .of(context)
          .scaffoldBackgroundColor,
      padding: EdgeInsets.only(top: 8.0),
      child: Text(
        "Get in Touch with },",
        style: TextStyle(fontFamily: 'Roboto', fontSize: 16.0),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () => print("followed"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Color(0xFF404A5C),
                ),
                child: Center(
                  child: Text(
                    "FOLLOW",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: InkWell(
              onTap: () => print("Message"),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "MESSAGE",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: screenSize.height / 6.4),
                  //_buildProfileImage(),
                  //_buildFullName(),
                  //_buildStatus(context),
                  //_buildlocation(),
                  //_buildStatContainer(),
                  _buildBio(context),
                  _buildSeparator(screenSize),
                  SizedBox(height: 10.0),
                  _buildGetInTouch(context),
                  SizedBox(height: 8.0),
                  _buildButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
