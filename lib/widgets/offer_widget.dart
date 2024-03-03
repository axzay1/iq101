import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Offer extends StatefulWidget {


  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.006),
              child: Text('Offers for you', style: GoogleFonts.oswald(color: Colors.white24, fontSize: 18)),),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(Icons.discount, color: Colors.white24),
            )
          ],
        ),
        Container(
          margin:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.006),
            height: MediaQuery.of(context).size.height * 0.085,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFFDAEE01).withOpacity(0.4),)
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                 SizedBox(width: MediaQuery.of(context).size.width * 0.005),
                 Padding(padding:  const EdgeInsets.symmetric(vertical: 5),
                  child:
                  Text("50% OFF", style: GoogleFonts.oswald(color: const Color(0xFFDAEE01).withOpacity(0.4),fontSize:  MediaQuery.of(context).size.width >600  ?MediaQuery.of(context).size.width * 0.033 : MediaQuery.of(context).size.width * 0.08),)
                ),
                Padding(
                    padding:   EdgeInsets.all(MediaQuery.of(context).size.width * 0.006),
                    child: Text("on your first purchase*", style: GoogleFonts.oswald(color: const Color(0xFFDAEE01).withOpacity(0.4), fontSize:  MediaQuery.of(context).size.width >600  ?MediaQuery.of(context).size.width * 0.01 : MediaQuery.of(context).size.width * 0.04)),)


              ],

            )
        ),
      ],
    );
  }
}