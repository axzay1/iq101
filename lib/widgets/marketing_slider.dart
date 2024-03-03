import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MarketingSliderWidget extends StatefulWidget {

  @override
  State<MarketingSliderWidget> createState() => _MarketingSliderWidgetState();
}

class _MarketingSliderWidgetState extends State<MarketingSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(

          aspectRatio: 14/9,
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
        items: const [
          Image(image: AssetImage('assets/images/skate.jpg')),
          Image(image: AssetImage('assets/images/hoodie.jpg')),
          Image(image: AssetImage('assets/images/cap.jpg'))
        ]
    );
  }
}