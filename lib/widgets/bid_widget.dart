import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'design_elements/red_dot.dart';

class BidWidget extends StatefulWidget {

  @override
  State<BidWidget> createState() => _BidWidgetState();
}

class _BidWidgetState extends State<BidWidget> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: const EdgeInsets.only(top: 6),
        height: MediaQuery.of(context).size.height * 0.3,
        child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context, index){
              return Container(
                padding: EdgeInsets.all(4),
                height: MediaQuery.of(context).size.height * 0.26,
                width: 295,
                child: Card(
                    color: Colors.white,
                    shadowColor: index > 1 ? Colors.purple : Colors.blueAccent ,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                    child:  Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height:  MediaQuery.of(context).size.height * 0.19,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 125,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(
                                            index > 1 ?
                                            'assets/images/bidl.jpeg'
                                                :'assets/images/bids.jpeg'

                                        ),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                    child: Image(
                                      height:  MediaQuery.of(context).size.height * 0.19,
                                      image:   NetworkImage('https://purepng.com/public/uploads/large/purepng.com-walking-model-on-catwalkmodelwomanpersonspeoplewalkingcatwalk-691525255742qacdd.png'),
                                      fit: BoxFit.cover,
                                      width: 125,

                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      width: 150,
                                      child: Text('Item index is $index', style: GoogleFonts.oswald( ),)),
                                ],
                              ),
                            ),
                            Text('This product is limited, 1/9 for sale, 2/9 will be available on 21/9/2025', style: GoogleFonts.oswald(fontSize: 8, fontWeight: FontWeight.w300 ),),
                            Container(
                                height: MediaQuery.of(context).size.height * 0.06,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      index > 1 ? Colors.purple.withOpacity(0.3):Colors.blueAccent,
                                      Colors.white.withOpacity(0.5),
                                    ],
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                        child: Text('#$index', style: GoogleFonts.arima(color: Colors.white, fontSize: 20),)
                                    ),
                                    Container(
                                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                        child: Card(
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                            shadowColor: index > 1 ?Colors.purple : Colors.blueAccent,
                                            child: Padding(  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                                                child: Text('Bid', style: GoogleFonts.arima(color: index > 1 ?Colors.purple : Colors.blueAccent, fontWeight: FontWeight.bold),)
                                            )
                                        )
                                    )
                                  ],
                                )
                            )
                          ],
                        ),
                        Positioned(top: 10, right: 10, child: Row(
                          children: [
                            BlinkingDot(),
                          ],
                        ))
                      ],
                    )
                ),
              );
            })
    );
  }
}