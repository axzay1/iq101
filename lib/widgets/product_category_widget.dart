import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/Screen/gender_category_home_screen.dart';
import 'package:iq101/Screen/product_category_home_screen.dart';
import 'package:iq101/widgets/design_elements/oval_clay_morphism.dart';

import 'design_elements/spotlight_widget.dart';

class ProductCategoryWidget extends StatefulWidget {
  int? gender;

  ProductCategoryWidget({required this.gender});

  @override
  State<ProductCategoryWidget> createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends State<ProductCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 8),
          child: Image(
            image: AssetImage(widget.gender! > 0
                ? 'assets/images/wallf.jpg'
                : 'assets/images/wall.jpg'),
            height: MediaQuery.of(context).size.height * 0.239 + 12,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductCategoryHomeScreen(index :widget.gender))),
          child: Container(

              height: MediaQuery.of(context).size.height * 0.239 + 20,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          color: Colors.black,
                          width: 140,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Shoes',
                                  style: GoogleFonts.vollkorn(
                                      color: Colors.white, fontSize: 20)),
                            ],
                          ),
                        ),
                        Container(
                            child: Stack(
                          children: [
                            ClipPath(
                              clipper: TriangleClipper(),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.227,
                                width: 140,
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: widget.gender! > 0
                                        ? [
                                            Colors.pinkAccent
                                                .withOpacity(0.7),
                                            Colors.pinkAccent
                                                .withOpacity(0.1),
                                            Colors.transparent
                                          ]
                                        : [
                                            Color(0xFF81D8D0).withOpacity(0.7),
                                            Color(0xFF81D8D0).withOpacity(0.1),
                                            Colors.transparent
                                          ],
                                    radius: 0.6,
                                    focal: Alignment(0.5, -0.5),
                                    tileMode: TileMode.decal,
                                  ),
                                ),
                              ),
                            ),
                             Positioned(
                                bottom: 0,
                                left:
                                widget.gender! >0
                                 ? 5
                                : 10,
                                child: Center(
                                    child: Image(
                                  image: AssetImage(
                                      widget.gender! > 0
                                      ?'assets/images/whitePodium.png'
                                      :'assets/images/wood.png'),
                                  height: 100,
                                  width: 130,
                                ))),
                             Positioned(
                                bottom: 25,
                                left: 40,
                                child: Center(
                                    child: Image(
                                        image: NetworkImage(
                                          widget.gender! > 0
                                          ?'https://static.vecteezy.com/system/resources/previews/009/381/009/original/high-heel-shoes-clipart-design-illustration-free-png.png'
                                          :'https://cutewallpaper.org/24/shoes-png/leather-shoes-png-free-download-png-arts.png',
                                        ),
                                        height: 50,
                                        width: 60))),
                            const Positioned(
                                top: 0,
                                left: 50,
                                child: Center(
                                    child: Image(
                                  image: AssetImage('assets/images/lamp.png'),
                                  height: 40,
                                  width: 40,
                                )))
                          ],
                        )),
                      ],
                    );
                  })),
        ),
      ],
    );
  }
}
