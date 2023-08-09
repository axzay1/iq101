import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/main.dart';
import 'package:provider/provider.dart';


import '../providers/auth_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/filter_provider.dart';
import '../providers/product_provider.dart';
import 'cap.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".



  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.black,
        title:   Text(
          "HOOD STREETWEAR CO.",
          // style: TextStyle(
          //     color: Color(0xFF00ff28), fontSize: 25, fontWeight: FontWeight.bold),
          style: GoogleFonts.rubikSprayPaint(color: Colors.white)
        ),

      ),
      backgroundColor: Colors.black,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.5,
                aspectRatio: 1,
                viewportFraction: 0.8,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval:
                const Duration(seconds: 3),
                autoPlayAnimationDuration:
                const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                enlargeFactor: 1.8
              ),
              items: const [
                  Image(image: AssetImage('assets/images/skate.jpg')),
                Image(image: AssetImage('assets/images/hoodie.jpg')),
                 Image(image: AssetImage('assets/images/cap.jpg'))
              ]
            ),
            InkWell(
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  Cap()));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: const Color(0xFFDAEE01))
                ),
                child: Text('Shop Now', style: GoogleFonts.oswald(color: const Color(0xFFDAEE01), fontSize: 25),)
              ),
            )
          ],
        ),
      ),
    );
  }
}