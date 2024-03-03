
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExploreWidget extends StatefulWidget {
  final int index;
  ExploreWidget({required this.index});
  @override
  ExploreWidgetState createState() => ExploreWidgetState();
}

class ExploreWidgetState extends State<ExploreWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: const Scaffold(
        body:  Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(image: AssetImage('assets/images/bid.gif'), height: double.infinity, fit: BoxFit.fitHeight,),
          ),
        ),
      ),
    );
  }
}