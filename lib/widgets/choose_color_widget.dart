import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/providers/filter_provider.dart';

import 'color_ball_widget.dart';

class ChooseColor extends StatefulWidget {


  @override
  State<ChooseColor> createState() => _ChooseColorState();
}

class _ChooseColorState extends State<ChooseColor> {
  FilterProvider? filterProvider;
  List<ColorModel> color =  [
    ColorModel(name: "White", color: Colors.white),
  ColorModel(name: "Black", color: Colors.black),
  ColorModel(name: "Red", color: Colors.red),
  ColorModel(name: "Green", color: Colors.teal),
  ColorModel(name: "Brown", color: Colors.brown),
  ColorModel(name: "Blue", color: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Choose Color', style: GoogleFonts.oswald(color: Colors.white, fontSize: 18)),),
        SizedBox(
          height: 50,
          child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: color.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index){
            return ColorBall(color: color[index]);
          })
        ),
      ],
    );
  }
}

class ColorModel{
  String? name;
  Color? color;

  ColorModel({this.name, this.color});
}