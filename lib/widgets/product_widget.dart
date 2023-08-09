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

class ProductWidget extends StatefulWidget {
  final ProductModel product;
  User? user;
  ProductWidget({Key? key, required this.product, this.user}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {


  FavoriteProvider? favoriteProvider;

  @override
  void initState(){
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = favoriteProvider?.favoriteData ?? [];
    List<ProductModel> cart = favoriteProvider?.cartData ?? [];
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine the card height based on the screen width
        double cardHeight = constraints.maxWidth > 600 ? 220 : 160;

        // Determine the icon size based on the screen width
        double iconSize = constraints.maxWidth > 600 ? 35 : 20;

        return Center(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.006)
            ),
            elevation: 0,
            color: Colors.black87,
            child:
            MediaQuery.of(context).size.width > 600
            ?Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width * 0.15,
                        width: MediaQuery.of(context).size.width * 0.15,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.17,
                      padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.006),
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
                                    fontSize: constraints.maxWidth > 600 ? 35 : 20,
                                  ),
                                ),
                              ),
                              Text(
                                widget.product.description,
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: constraints.maxWidth > 600 ? 15 : 12,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cost: \$${widget.product.cost.toStringAsFixed(2)}',
                                  style: GoogleFonts.lato(
                                    color: const Color(0xFFDAEE01),
                                    fontSize: constraints.maxWidth > 600 ? 20 : 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Container(
                  padding:  EdgeInsets.all(MediaQuery.of(context).size.width * 0.006),
                  height: MediaQuery.of(context).size.width * 0.17,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (widget.user == null) {
                            showPopupNLogin(context);}
                          else if(products.contains(widget.product)){
                            products.remove(widget.product);

                            await ProductService().unlikeProduct( widget.user!.id!,
                              widget.product.id,);
                            favoriteProvider?.setProducts = await ProductService().getFavorites(widget.user!.id!);
                            setState(() {

                            });

                          }// Show the login dialog
                          else {
                            products.add(widget.product);

                            await ProductService().addToFavorites(
                              widget.user!.id!,
                              widget.product.id,
                            );
                            favoriteProvider?.setProducts = await ProductService().getFavorites(widget.user!.id!);
                          }
                          setState(() {

                          });
                        },
                        child: Icon(
                          products!.contains(widget.product) ? Icons.favorite : Icons.favorite_border,
                          size: iconSize,
                          color: const Color(0xFFDAEE01),
                        ),
                      ),
          !cart.contains(widget.product)
                      ?InkWell(
                        onTap: (){
                          if (widget.user == null){
                            showPopupNLogin(context);}
                          else {
                            favoriteProvider?.cartData.add(widget.product);
                            favoriteProvider?.setCart = cart;
                            setState(() {

                            });

                          }
                        },
                        child:

                            Card(
                          elevation: 10,
                          shadowColor: const Color(0xFFDAEE01),
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Text(
                              'Add to Cart',
                              style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontSize: constraints.maxWidth > 600 ? 15 : 12,
                              ),
                            ),
                          ),
                        ),

                      )
              :Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
          'Added to Cart',
          style: GoogleFonts.oswald(
          color: const Color(0xFFDAEE01),
          fontSize: constraints.maxWidth > 600 ? 15 : 12,
          ),
          ),
          ),
                    ],
                  ),
                )
              ],
            )
            :Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.network(
                        widget.product.image,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.width * 0.94,
                        width: MediaQuery.of(context).size.width * 0.94,
                      ),
                    ),
                    Container(
                      padding:  const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  child: Text(
                                    widget.product.name,
                                    style: GoogleFonts.justAnotherHand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: constraints.maxWidth > 600 ? 35 : 35,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.product.description,
                                  style: GoogleFonts.oswald(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: constraints.maxWidth > 600 ? 15 : 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cost: \$${widget.product.cost.toStringAsFixed(2)}',
                                  style: GoogleFonts.lato(
                                    color: const Color(0xFFDAEE01),
                                    fontSize: constraints.maxWidth > 600 ? 20 : 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:  const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      !cart.contains(widget.product)
                          ?InkWell(
                        onTap: (){
                          if (widget.user == null){
                            showPopupNLogin(context);}
                          else {
                            favoriteProvider?.cartData.add(widget.product);
                            favoriteProvider?.setCart = cart;
                            setState(() {

                            });

                          }
                        },
                        child:

                        Card(
                          elevation: 10,
                          shadowColor: const Color(0xFFDAEE01),
                          color: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Text(
                              'Add to Cart',
                              style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontSize: constraints.maxWidth > 600 ? 15 : 15,
                              ),
                            ),
                          ),
                        ),

                      )
                          :Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Text(
                          'Added to Cart',
                          style: GoogleFonts.oswald(
                            color: const Color(0xFFDAEE01),
                            fontSize: constraints.maxWidth > 600 ? 15 : 15,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (widget.user == null) {
                            showPopupNLogin(context);}
                          else if(products.contains(widget.product)){
                            products.remove(widget.product);

                            await ProductService().unlikeProduct( widget.user!.id!,
                              widget.product.id,);
                            favoriteProvider?.setProducts = await ProductService().getFavorites(widget.user!.id!);
                            setState(() {

                            });

                          }// Show the login dialog
                          else {
                            products.add(widget.product);

                            await ProductService().addToFavorites(
                              widget.user!.id!,
                              widget.product.id,
                            );
                            favoriteProvider?.setProducts = await ProductService().getFavorites(widget.user!.id!);
                          }
                          setState(() {

                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            products!.contains(widget.product) ? Icons.favorite : Icons.favorite_border,
                            size: 30,
                            color: const Color(0xFFDAEE01),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ],
            )
          ),
        );
      },
    );
  }
  void showPopupNLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return LoginWidget();
      },
      // barrierDismissible: barrierDismissable,
      // barrierColor: barrierColor,
    );
  }
}
