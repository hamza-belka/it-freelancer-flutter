import 'dart:async';
import 'package:flutter/material.dart';

class Registerhire extends StatefulWidget {


  @override
  _RegisterhireState createState() => _RegisterhireState();
}

class _RegisterhireState extends State<Registerhire> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: null /* add child content here */,
      ),
    );
  }
}

