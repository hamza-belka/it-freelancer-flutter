import 'dart:async';
import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:itfreelance/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../GeneralAdresse.dart';


class Education extends StatefulWidget {
  final int value;
  Education( {Key key, this.value}) : super(key: key);








  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {


  Future setSkills() async {
    var url = GeneralAdresse().Gadress+"/profiles/addskill.php";

    var response = await http.post(url,body: jsonEncode(<String, dynamic>{

      'userid': widget.value,
      'skill_description': skills.text,
    }),);
    var data = json.decode(response.body);


    //print('Response body: ${response.body[10]}');
    if ( data["status"]== 0) {

      Fluttertoast.showToast(msg: 'skills Successful');
     // goRegister(context,data["role"]);
    } else {
     // Fluttertoast.showToast(msg: 'Username and password invalid');

    }
  }
  Future setinfo() async {
    var url = GeneralAdresse().Gadress+"/profiles/addprofileinfo.php";

    var response = await http.post(url,body: jsonEncode(<String, dynamic>{

      'userid': widget.value,
      'profiletitle': profession.text,
      'about': about.text,
      'location': location.text,
    }),);
    var data = json.decode(response.body);


    //print('Response body: ${response.body[10]}');
    if ( data["status"]== 0) {

      Fluttertoast.showToast(msg: 'skills Successful');
      // goRegister(context,data["role"]);
    } else {
      // Fluttertoast.showToast(msg: 'Username and password invalid');

    }
  }
  Future seteducation() async {
    var url = GeneralAdresse().Gadress+"/profiles/addeducation.php";

    var response = await http.post(url,body: jsonEncode(<String, dynamic>{

      'userid': widget.value,
      'school': school.text,
      'degree': degree.text,
      'startstudydate': dateDebutS.text,
      'endstudydate': dateFinS.text,

    }),);
    var data = json.decode(response.body);


    //print('Response body: ${response.body[10]}');
    if ( data["status"]== 0) {

      Fluttertoast.showToast(msg: 'skills Successful');
      // goRegister(context,data["role"]);
    } else {
      // Fluttertoast.showToast(msg: 'Username and password invalid');

    }
  }

  Future setexp() async {
    var url = GeneralAdresse().Gadress+"/profiles/addexperience.php";

    var response = await http.post(url,body: jsonEncode(<String, dynamic>{

      'userid': widget.value,
      'exptitle': school.text,
      'expcompany': Company.text,
      'startdate': dateDebutS.text,
      'enddate': dateFinS.text,

    }),);
    var data = json.decode(response.body);


    //print('Response body: ${response.body[10]}');
    if ( data["status"]== 0) {

      Fluttertoast.showToast(msg: 'skills Successful');
      // goRegister(context,data["role"]);
    } else {
      // Fluttertoast.showToast(msg: 'Username and password invalid');

    }
  }


final format = DateFormat("yyyy-MM-dd");






  int _currentStep = 0;

  TextEditingController location = TextEditingController();
  TextEditingController skills = TextEditingController();
  TextEditingController profession = TextEditingController();
  TextEditingController about = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController dateDebutS = TextEditingController();
  TextEditingController dateFinS = TextEditingController();
  TextEditingController Company = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController dateDebutEx = TextEditingController();
  TextEditingController datefinEx = TextEditingController();










  @override
  Widget build(BuildContext context) {
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
                            if (this._currentStep < this
                                ._mySteps()
                                .length - 1) {
                              this._currentStep = this._currentStep + 1;
                            } else {
                              //Logic to check if everything is completed
                              setSkills();
                              setexp();
                              seteducation();
                              setinfo();

                              print('Completed, check fields.');
                              print(widget.value);

                            }
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
  Widget _buildcompany() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Company :',
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
              hintText: 'Enter your company',
              hintStyle: kHintTextStyle,
            ),
            controller: Company,
          ),
        ),
      ],
    );
  }
  Widget _buildprofession() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'profession :',
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
                Icons.work,
                color: Colors.white,
              ),
              hintText: 'Enter your Profession',
              hintStyle: kHintTextStyle,
            ),
            controller: profession,
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
  Widget _builddegree() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'degree :',
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
              hintText: 'Enter your degree',
              hintStyle: kHintTextStyle,
            ),
            controller: degree,
          ),
        ),
      ],
    );
  }
  Widget _buildschool() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'School :',
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
              hintText: 'Enter your school',
              hintStyle: kHintTextStyle,
            ),
            controller: school,
          ),
        ),
      ],
    );
  }
  Widget _buildskills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Skills :',
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
              hintText: 'Enter your Skills',
              hintStyle: kHintTextStyle,
            ),
            controller: skills,
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
  Widget _buildatestartS() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Text(
            'Start Date:',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
      //Text('Basic date field (${format.pattern})'),
      DateTimeField(
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'OpenSans',
        ),
        decoration: InputDecoration(
    border: InputBorder.none,
    contentPadding: EdgeInsets.only(top: 14.0),
    prefixIcon: Icon(
    Icons.calendar_today_rounded,
    color: Colors.white,
    ),
    hintText: "yyyy-MM-dd",
    hintStyle: kHintTextStyle,
    ),controller: dateDebutS,

        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
  Widget _buildatendS() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Text(
            'End Date:',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          //Text('Basic date field (${format.pattern})'),
          DateTimeField(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today_rounded,
                color: Colors.white,
              ),
              hintText: "yyyy-MM-dd",
              hintStyle: kHintTextStyle,
            ),controller: dateFinS,

            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
            },
          ),
        ]);
  }
  Widget _buildatestartex() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Text(
            'Start Date:',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          //Text('Basic date field (${format.pattern})'),
          DateTimeField(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today_rounded,
                color: Colors.white,
              ),
              hintText: "yyyy-MM-dd",
              hintStyle: kHintTextStyle,
            ),controller: dateDebutEx,

            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
            },
          ),
        ]);
  }
  Widget _buildatfinex() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[
          Text(
            'Start Date:',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          //Text('Basic date field (${format.pattern})'),
          DateTimeField(
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.calendar_today_rounded,
                color: Colors.white,
              ),
              hintText: "yyyy-MM-dd",
              hintStyle: kHintTextStyle,
            ),controller: datefinEx,

            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
            },
          ),
        ]);
  }


  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Step 3 : Info'),

        isActive: _currentStep >= 0,
      content: Column(
        children: <Widget>[
          _buildprofession(),
          _buildskills(),
          _buildlocation(),

          _buildabout()

        ],
      ),
      ),
      Step(
        title: Text('Step 2 : Education'),
    content: Column(
    children: <Widget>[
      _buildschool(),
      _builddegree(),
      _buildatestartS(),
      _buildatendS()


    ],

    ),

        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Step 3 : Experience'),
      content: Column(
        children: <Widget>[
          _buildcompany(),
          _buildtitle(),
          _buildatestartex(),
          _buildatfinex()

        ],

      ),
        isActive: _currentStep >= 2,
      ),
    ];
    return _steps;
  }



}
