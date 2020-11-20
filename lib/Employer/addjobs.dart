import 'dart:async';
import 'dart:convert';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:itfreelance/Employer/dashbordEmpl.dart';
import 'package:itfreelance/Employer/myjobs.dart';
import 'package:itfreelance/utilities/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../GeneralAdresse.dart';


class addjobs extends StatefulWidget {

  //addjobs( {Key key, this.value}) : super(key: key);








  @override
  _addjobsState createState() => _addjobsState();
}
enum SingingCharacter { fixed, hourly }
class _addjobsState extends State<addjobs> {
  static  int id;
  static String postermail;


  Future addjob() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id= preferences.getInt("userid");
    postermail=preferences.getString("email");
    String budgtype="fixed";
    var url = GeneralAdresse().Gadress+"/jobs/addjob.php";
     if(_character== SingingCharacter.hourly){
       budgtype="hourly";
     }
    var response = await http.post(url,body: jsonEncode(<String, dynamic>{

      //'userid': widget.value,
      'title':title.text,
      'jobdescription':description.text,
      'budgettype':budgtype,
      'budget': budget.text,
      'skills': skills.text,
      'postermail':postermail,
      'posterid':id.toString(),

    }),);
    var data = json.decode(response.body);
     print(data);

    //print('Response body: ${response.body[10]}');
    if ( data["status"]== 0) {

      Fluttertoast.showToast(msg: 'job added successfully');
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {

            return Dashbordempl();
            // Navigator.pop(_addjobsState().context);
          })
      );
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
  TextEditingController description = TextEditingController();
  TextEditingController school = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController dateDebutS = TextEditingController();
  TextEditingController dateFinS = TextEditingController();
  TextEditingController Company = TextEditingController();
  TextEditingController budget = TextEditingController();
  TextEditingController dateDebutEx = TextEditingController();
  TextEditingController datefinEx = TextEditingController();
  TextEditingController title = TextEditingController();










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
                              //webservice ici
                              addjob();


                              print('Completed, check fields.');
                              //print(widget.value);

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


  Widget _buildtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Title :',
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
              hintText: 'Enter job title',
              hintStyle: kHintTextStyle,
            ),
            controller: title,
          ),
        ),
      ],
    );
  }
  Widget _builddescreption() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Job description :',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            keyboardType: TextInputType.multiline,
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
              hintText: 'Enter job description',
              hintStyle: kHintTextStyle,
            ),
            controller: description,
          ),
        ),
      ],
    );
  }
  Widget _buildbudget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'budget :',
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
              hintText: 'Enter job budget:',
              hintStyle: kHintTextStyle,
            ),
            controller: budget,
          ),
        ),
      ],
    );
  }
  SingingCharacter _character = SingingCharacter.fixed;
  Widget _buildbudgettype() {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'budget type :',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 120.0,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: const Text('fixed'),
                leading: Radio(
                  value: SingingCharacter.fixed,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('hourly'),
                leading: Radio(
                  value: SingingCharacter.hourly,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
              ),
            ],
    ),),
        ],);

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
              hintText: 'Enter wanted Skills',
              hintStyle: kHintTextStyle,
            ),
            controller: skills,
          ),
        ),
      ],
    );
  }
 /* Widget _buildabout() {
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
            controller: description,
          ),
        ),
      ],
    );
  }*/





  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Step 1 : Project info'),

        isActive: _currentStep >= 0,
        content: Column(
          children: <Widget>[
            _buildtitle(),
            _builddescreption()

          ],
        ),
      ),
      Step(
        title: Text('Step 2 : budget'),
        content: Column(
          children: <Widget>[
_buildbudget(),
            _buildbudgettype()



          ],

        ),

        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Step 3 : skills'),
        content: Column(
          children: <Widget>[

            _buildskills(),


          ],

        ),
        isActive: _currentStep >= 2,
      ),
    ];
    return _steps;
  }



}
