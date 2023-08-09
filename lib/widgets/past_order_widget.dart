import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/providers/auth_provider.dart';

import 'package:iq101/providers/favorite_provider.dart';
import 'package:iq101/service/product_service.dart';
import 'package:iq101/service/user_service.dart';
import 'package:iq101/widgets/login_dialog.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';

class PastOrderWidget extends StatefulWidget {
  final ProductModel product;

  const PastOrderWidget({Key? key ,required this.product}) : super(key: key);

  @override
  State<PastOrderWidget> createState() => _PastOrderWidgetState();
}

class _PastOrderWidgetState extends State<PastOrderWidget> {
  FavoriteProvider? favoriteProvider;

  @override
  void initState(){
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return Center(
        child: Card(
          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(2)),
          elevation: 0,
          color: Colors.white12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                      widget.product.image,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.width * 0.1,
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.118,
                    padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.007),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                widget.product.name,
                                style: GoogleFonts.justAnotherHand(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.015,
                                ),
                              ),
                            ),
                            Text(
                              widget.product.description,
                              style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.01,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          child: Text(
                            'Cost: \$${widget.product.cost.toStringAsFixed(2)}',
                            style: GoogleFonts.oswald(
                              color: const Color(0xFFDAEE01),
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.013,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ],
          ),
        )

    );
  }
}
