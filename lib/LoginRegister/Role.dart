import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:itfreelance/Employer/registerhire.dart';
import 'package:itfreelance/Freelancer/registerFreelancer.dart';
import 'package:itfreelance/LoginRegister/register.dart';
import '../utilities/constants.dart';

class Roleselect extends StatefulWidget {
  @override
  _RoleselectState createState() => _RoleselectState();
}

class _RoleselectState extends State<Roleselect> {

  /*void gohire() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        }
        ), (Route<dynamic> route) => false);
  }
  void gofree() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        }
        ), (Route<dynamic> route) => false);
  }*/



  /*void gofreelancer(context, role) {
    const f = "freelancer";
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterScreen(value :f)));
  }*/
void Selectfreerole() {
    String r ="freelancer";
    var route = new MaterialPageRoute(
    builder: (BuildContext context) =>
    new RegisterScreen(value: r),
  );
  Navigator.of(context).push(route);
}
  void selecthirerole() {
    String r ="employer";
    var route = new MaterialPageRoute(
      builder: (BuildContext context) =>
      new RegisterScreen(value: r),
    );
    Navigator.of(context).push(route);
  }


  Widget _hireBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => selecthirerole(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.orangeAccent,
        child: Text(
          'i want to hire',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  Widget _freelancerBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () => Selectfreerole(),
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.orangeAccent,
        child: Text(
          'i want to work',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Container(height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Select your account !!',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(
                        height: 30.0,
                      ),
                      _freelancerBtn(),
                      _hireBtn(),

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
}
