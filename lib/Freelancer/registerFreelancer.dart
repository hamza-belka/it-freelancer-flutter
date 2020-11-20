import 'dart:async';
import 'package:flutter/material.dart';

class Registerfree extends StatefulWidget {
  final String value;
  Registerfree({Key key, this.value}) : super(key: key);





  @override
  _RegisterfreeState createState() => _RegisterfreeState();
}

class _RegisterfreeState extends State<Registerfree> {




  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: new Text("${widget.value}"),


    );
  }
}

