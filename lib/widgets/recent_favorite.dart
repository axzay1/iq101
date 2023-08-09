import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/providers/favorite_provider.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import 'color_ball_widget.dart';

class RecentFavorite extends StatefulWidget {
  final String image;
  final String name;
  final String createdBy;
  const RecentFavorite({required this.image, required this.name, required this.createdBy});
  @override
  State<RecentFavorite> createState() => _RecentFavoriteState();
}

class _RecentFavoriteState extends State<RecentFavorite> {


  @override
  Widget build(BuildContext context) {

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Recent Favorite',
                    style:
                    GoogleFonts.oswald(color: Colors.white24, fontSize: 18),
                  ),
                ),
                const Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.favorite, color: Colors.white24),
                )
              ],
            ),
            SizedBox(
              height: 65,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                color: Colors.white24,
                elevation: 5,
                shadowColor: const Color(0xFFDAEE01),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                      child: Image(
                        image: NetworkImage(widget.image),
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            widget.name,
                            style: GoogleFonts.oswald(color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            widget.createdBy,
                            style: GoogleFonts.oswald(color: Colors.white, fontSize: 10),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );


  }
}
