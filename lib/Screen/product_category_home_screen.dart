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

class ProductCategoryHomeScreen extends StatefulWidget {
  int? index;
  ProductCategoryHomeScreen({required this.index});

  @override
  State<ProductCategoryHomeScreen> createState() => _ProductCategoryHomeScreenState();
}

class _ProductCategoryHomeScreenState extends State<ProductCategoryHomeScreen> {
  int tabIndex = 0;
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
        actions: [
          Icon(Icons.search, color: Colors.black)
        ],
      ),

      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black)
            ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => setState(() {
                tabIndex = 0;
                }),
                child: Container(

                  color: tabIndex == 0 ? Colors.black : Colors.white,
                  width: MediaQuery.of(context).size.width /2.02,
                  child: Center(
                    child: Text('For Sale',
                        style: GoogleFonts.vollkorn(
                            color: tabIndex == 0 ? Colors.white : Colors.black, fontSize: 20)),
                  ),
                ),
              ),
              InkWell(
                onTap: () => setState(() {
                  tabIndex = 1;
                }),
                child: Container(
                  color: tabIndex == 1 ? Colors.black : Colors.white,
                  width: MediaQuery.of(context).size.width /2.02,
                  child: Center(
                    child: Text('For Auction',
                        style: GoogleFonts.vollkorn(
                            color: tabIndex == 1 ? Colors.white : Colors.black, fontSize: 20)),
                  ),
                ),
              ),
            ],
          )
      )
        ],
      )
    );
  }
}