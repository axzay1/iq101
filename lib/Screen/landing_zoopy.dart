import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/widgets/zoopy_widgets/category_home_widget.dart';
import 'package:iq101/widgets/zoopy_widgets/marketing_home_screen_widget.dart';
import 'package:iq101/widgets/zoopy_widgets/searchbar_landing_zoopy_widget.dart';

import '../widgets/zoopy_widgets/restaurant_home_widget.dart';

class LandingZoopy extends StatefulWidget {
  const LandingZoopy({super.key});

  @override
  State<LandingZoopy> createState() => _LandingZoopyState();
}

class _LandingZoopyState extends State<LandingZoopy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black45,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text("Zoopy",
              style: GoogleFonts.vollkorn(
                  color: Colors.black54,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        body:  SizedBox(
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    const SearchBarLandingZoopyWidget(),
                     const CategoryHomeScreenWidget(),
                      MarketingZoopySliderWidget(),
                      RestaurantHomeScreenWidget(),
                    ],
                ),
            ),
        ),
    );
  }
}
