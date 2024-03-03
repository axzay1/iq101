import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/widgets/design_elements/spotlight_widget.dart';
import 'package:iq101/widgets/product_category_widget.dart';
import 'package:iq101/widgets/product_widget.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

import '../widgets/bid_widget.dart';
import '../widgets/design_elements/oval_clay_morphism.dart';
import '../widgets/explore_widget.dart';
import '../widgets/marketing_slider.dart';

class GenderCategoryHomeScreen extends StatefulWidget {
  int? index;
  GenderCategoryHomeScreen({required this.index});

  @override
  State<GenderCategoryHomeScreen> createState() => _GenderCategoryHomeScreenState();
}

class _GenderCategoryHomeScreenState extends State<GenderCategoryHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: 4,
        builder: (context, index) {
          if (index == 0) {
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

                        ProductCategoryWidget(gender: widget.index,),
                        MarketingSliderWidget(),
                        // InkWell(
                        //   onTap: () async {
                        //     Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) =>  Cap()));
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(25),
                        //       border: Border.all(color: const Color(0xFFDAEE01))
                        //     ),
                        //     child: Text('Shop Now', style: GoogleFonts.oswald(color: const Color(0xFFDAEE01), fontSize: 25),)
                        //   ),
                        // ),
                        BidWidget(),
                      ],
                    ),
                  )),
            );
          } else {
            return ExploreWidget(index: index);
          }
        },
      ),
    );
  }
}