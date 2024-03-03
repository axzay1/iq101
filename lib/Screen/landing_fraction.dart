import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/bid_widget.dart';
import '../widgets/gender_category_widget.dart';
import '../widgets/marketing_slider.dart';

class LandingFraction extends StatefulWidget {
  const LandingFraction({super.key});

  @override
  State<LandingFraction> createState() => _LandingFractionState();
}

class _LandingFractionState extends State<LandingFraction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black45,
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text("FRACTION",
            style: GoogleFonts.vollkorn(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: SizedBox(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GenderCategoryWidget(),

                MarketingSliderWidget(),

                BidWidget(),
              ],
            ),
          )),
    );
  }
}