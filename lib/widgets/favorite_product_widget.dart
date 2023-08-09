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

class FavoriteProduct extends StatefulWidget {
  final User user;
  final ProductModel product;

  const FavoriteProduct({Key? key, required this.user ,required this.product}) : super(key: key);

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  FavoriteProvider? favoriteProvider;

  @override
  void initState(){
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    double vpadding = MediaQuery.of(context).size.height * 0.002;
    double hpadding = MediaQuery.of(context).size.height * 0.007;
    List<ProductModel> products = favoriteProvider?.favoriteData ?? [];
    List<ProductModel> cart = favoriteProvider?.cartData ?? [];

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
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.007),
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

              Container(
                padding:   EdgeInsets.all(MediaQuery.of(context).size.width * 0.006),
                height: MediaQuery.of(context).size.width * 0.118,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        if(products.contains(widget.product)){
                          products.remove(widget.product);
                          await ProductService().unlikeProduct( widget.user!.id!,
                            widget.product.id,);
                          favoriteProvider?.setProducts = await ProductService().getFavorites(widget.user!.id!);
                          setState(() {});
                        }// Show the login dialog
                      },
                      child: const Icon(Icons.cancel_rounded, color:  Color(0xFFDAEE01), size: 10,
                      ),
                    ),
                    !cart.contains(widget.product)
                        ?InkWell(
                        onTap: (){
                          favoriteProvider?.cartData.add(widget.product);
                          favoriteProvider?.setCart = cart;
                          setState(() {

                          });

                        },
                        child:

                        Card(
                          shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(2)),
                          elevation: 0,
                          shadowColor: const Color(0xFFDAEE01),
                          color: Colors.black,
                          child: Padding(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.009, horizontal: MediaQuery.of(context).size.width * 0.009),
                            child: Text(
                              'Add to Cart',
                              style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontSize: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.015,
                              ),
                            ),
                          ),
                        )

                    )
                        :Text(
                          'Added to Cart',
                          style: GoogleFonts.oswald(
                            color: const Color(0xFFDAEE01),
                            fontSize: MediaQuery
                                .of(context)
                                .size
                                .width * 0.008,
                          ),
                        ),
                  ],
                ),
              )
            ],
          ),
        )

    );
  }
}
