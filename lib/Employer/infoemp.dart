import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itfreelance/Employer/dashbordEmpl.dart';
import 'package:itfreelance/utilities/constants.dart';
import 'package:http/http.dart' as http;
import '../GeneralAdresse.dart';

class InfoEmployer extends StatefulWidget {
  final int value;
  InfoEmployer({Key key, this.value}) : super(key: key);





  @override
  _InfoEmployerState createState() => _InfoEmployerState();
}

class _InfoEmployerState extends State<InfoEmployer> {


  int _currentStep = 0;
  TextEditingController title = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController location = TextEditingController();



  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Complete registration',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Stepper(

                        steps: _mySteps(),
                        currentStep: this._currentStep,
                        onStepTapped: (step) {
                          setState(() {
                            this._currentStep = step;
                          });
                        },
                        onStepContinue: () {
                          setState(() {

                              //Logic to check if everything is completed

                              setprofileinfos();

                              print('Completed, check fields.');
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context){
                                    return new Dashbordempl(value: widget.value);
                                  }
                                  ), (Route<dynamic> route) => false);



                          });
                        },
                        onStepCancel: () {
                          setState(() {
                            if (this._currentStep > 0) {
                              this._currentStep = this._currentStep - 1;
                            } else {
                              this._currentStep = 0;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  List<Step> _mySteps() {

    List<Step> _steps = [
      Step(
        title: Text('Tell us more about you '),

        isActive: _currentStep >= 0,
        content: Column(
          children: <Widget>[
            _buildtitle(),
            _buildlocation(),
            _buildabout()

          ],
        ),
      ),


    ];
    return _steps;
  }
  Widget _buildlocation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'location :',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              hintText: 'Enter your location',
              hintStyle: kHintTextStyle,
            ),
            controller: location,
          ),
        ),
      ],
    );
  }
  Widget _buildtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'title :',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,

            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.accessibility,
                color: Colors.white,
              ),
              hintText: 'Enter your title',
              hintStyle: kHintTextStyle,
            ),
            controller: title,
          ),
        ),
      ],
    );
  }
  Widget _buildabout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'About :',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            maxLines: null,
            expands: true,
            keyboardType: TextInputType.multiline,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.announcement,
                color: Colors.white,
              ),
              hintText: 'about u !!',
              hintStyle: kHintTextStyle,
            ),
            controller: about,
          ),
        ),
      ],
    );
  }
  Future setprofileinfos() async {
    var url = GeneralAdresse().Gadress+"/profiles/addprofileinfos.php";

    var response = await http.post(url,body: jsonEncode(<String, dynamic>{

      'userid': widget.value,
      'profiletitle': title.text,
      'about': about.text,
      'location': location.text

    }),);
    var data = json.decode(response.body);


    //print('Response body: ${response.body[10]}');
    if ( data["status"]== 0) {

      Fluttertoast.showToast(msg: 'profile submitted Successfully');
      // goRegister(context,data["role"]);
    } else {
      // Fluttertoast.showToast(msg: 'Username and password invalid');

    }
  }
}

