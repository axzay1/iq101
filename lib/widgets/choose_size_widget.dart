import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/widgets/size_ball_widget.dart';

class ChooseSize extends StatefulWidget {

  @override
  State<ChooseSize> createState() => _ChooseSizeState();
}

class _ChooseSizeState extends State<ChooseSize> {
  List<String> size =  [
 "XS", "S", "M", "L", "XL"
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Choose Size', style: GoogleFonts.oswald(color: Colors.white, fontSize: 18)),),
    SizedBox(
    height: 50,
    child: ListView.builder(
    padding: const EdgeInsets.all(5),
    itemCount: size.length,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index){
    return SizeBall(size: size[index]);
    })
    ),

      ],
    );
  }
}