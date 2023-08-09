import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/providers/auth_provider.dart';

import 'package:iq101/providers/favorite_provider.dart';
import 'package:iq101/service/product_service.dart';
import 'package:iq101/service/user_service.dart';
import 'package:iq101/widgets/login_dialog.dart';
import 'package:provider/provider.dart';
import '../model/product_model.dart';

class CartProduct extends StatefulWidget {
  final ProductModel product;

  CartProduct({Key? key, required this.product}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {


  @override
  Widget build(BuildContext context) {
    double vpadding = MediaQuery.of(context).size.height * 0.002;
    double hpadding = MediaQuery.of(context).size.height * 0.007;

    return Consumer<FavoriteProvider>(builder: (context, favoriteProvider, _)
    {
      return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2)
            ),

            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(hpadding),
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.cover,
                        height: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07,
                      ),
                    ),
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.07,
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: GoogleFonts.oswald(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.015,
                            ),
                          ),
                          Text(
                            widget.product.description,
                            style: GoogleFonts.oswald(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.010,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .width * 0.07,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            favoriteProvider?.removeItemCart(widget.product);
                            print(favoriteProvider?.cartData.length);
                            setState(() {

                            });
                          },
                          child: Icon(
                            Icons.delete, color: Colors.red, size: MediaQuery
                              .of(context)
                              .size
                              .width * 0.02,)),
                      Text(
                        ' \$${widget.product.cost.toStringAsFixed(2)}',
                        style: GoogleFonts.oswald(
                          color: Colors.green,
                          fontSize: MediaQuery
                              .of(context)
                              .size
                              .width * 0.015,
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            ),
          )
      );
    }
    );
  }
}
