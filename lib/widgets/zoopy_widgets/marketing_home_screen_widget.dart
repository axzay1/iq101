import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/Screen/landing_zoopy.dart';

import '../../Screen/cap.dart';

class MarketingZoopySliderWidget extends StatefulWidget {

  @override
  State<MarketingZoopySliderWidget> createState() => _MarketingZoopySliderWidgetState();
}

class _MarketingZoopySliderWidgetState extends State<MarketingZoopySliderWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        options: CarouselOptions(

          aspectRatio: 14/8,
          viewportFraction: 0.98,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval:
          const Duration(seconds: 3),
          autoPlayAnimationDuration:
          const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
        ),
        itemBuilder: (context, index, realIndex){
          return InkWell(
          onTap: (){
    Navigator.of(context).push(MaterialPageRoute(
    builder: (context) =>  LandingZoopy()));},
              child: slide(index));
        }, itemCount: 3,
        // items:  [
        //   slide(),
        //   Image(image: AssetImage('assets/images/hoodie.jpg')),
        //   Image(image: AssetImage('assets/images/cap.jpg'))
        // ]
    );
  }
}

Widget slide(int index){
  return Container(
    padding: EdgeInsets.all(8),
    child: Card(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
             Colors.red.withOpacity(0.8),
              index == 0 ? Colors.redAccent.withOpacity(0.6) : index == 1 ?Colors.pinkAccent.withOpacity(0.6) :Colors.purple.withOpacity(0.6),
            ],
          ),
        ),
      ),
    )
  );
}