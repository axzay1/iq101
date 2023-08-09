import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/providers/favorite_provider.dart';
import 'package:iq101/providers/past_order_provider.dart';
import 'package:iq101/service/product_service.dart';
import 'package:iq101/widgets/cart_product.dart';
import 'package:iq101/widgets/favorite_product_widget.dart';
import 'package:iq101/widgets/product_widget.dart';
import 'package:provider/provider.dart';

import '../model/order_model.dart';
import '../model/product_model.dart';
import '../model/user_model.dart';


class CartDialog extends StatefulWidget {
  User? user;

  List<ProductModel>? products;
  CartDialog({this.products, this.user});

  @override
  State<CartDialog> createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {
bool orderPlaced = false;
int? orderId;

  @override
  Widget build(BuildContext context) {

    return Consumer<FavoriteProvider>(builder: (context, favoriteProvider, _) {
      double vpadding = MediaQuery.of(context).size.height * 0.006;
      double hpadding = MediaQuery.of(context).size.height * 0.006;
      int? total = billAmount(favoriteProvider.cartData);
      return AlertDialog(
        backgroundColor: Colors.black,
        contentPadding: const EdgeInsets.all(8),
        // insetPadding: EdgeInsets.all(0.0.s),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            3,
          ),
        ),
        content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.white),
            ),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.7,
            width: MediaQuery
            .of(context)
            .size
            .width * 0.4,

            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding:  EdgeInsets.all(hpadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:  EdgeInsets.all(hpadding),
                            child: Icon(
                              Icons.shopping_bag_outlined, size: MediaQuery
                                .of(context)
                                .size
                                .height * 0.05, color: Colors.white,),
                          ),
                          Padding(
                            padding:  EdgeInsets.all(hpadding),
                            child: Text("Cart", style: GoogleFonts.oswald(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.03, color: Colors.white,),
                            ),
                          )
                        ],
                      )
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.50,
                    child:
                    favoriteProvider!.cartData.isNotEmpty
                    ?ListView.builder(
                        itemCount: favoriteProvider?.cartData.length,
                        itemBuilder: (context, index) {
                          return CartProduct(
                              product: favoriteProvider!.cartData[index]);
                        })
                    : orderPlaced ==true
                      ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           Center(
                          child: Image(image: const AssetImage('assets/images/orderPlaced.gif'), height: MediaQuery.of(context).size.width * 0.2, width: MediaQuery.of(context).size.width * 0.2, fit: BoxFit.cover,),
                    ),
                          Padding(padding: EdgeInsets.all(20),
                          child: Text("Order Placed Successfully", style: GoogleFonts.oswald(color: const Color(0xFFDAEE01), fontSize: 20),)),
                          // Padding(padding: EdgeInsets.all(10),
                          //     child: Text("Order Id : $orderId", style: GoogleFonts.oswald(color: const Color(0xFFDAEE01), fontSize: 15),))
                        ],
                      )
                    : Center(child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: vpadding, horizontal: 20),
                      child: Card(
                        color: Colors.white24,
                        child: Padding(padding:  EdgeInsets.symmetric(horizontal: 20, vertical: vpadding),
                        child: Text('No Products Added', style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w400),),
                        )
                      )
                    ))
                    ,
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if(orderPlaced != true)
                      Padding(padding:  const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                        child: Text("Total: \$${total.toString()}",
                          style: GoogleFonts.oswald(
                              color: Colors.white, fontSize: MediaQuery.of(context).size.width * 0.025),),

                      ),
                      favoriteProvider!.cartData.isNotEmpty
                      ?InkWell (
                        onTap: () async {
                          List<int> order = [];
                          favoriteProvider.cartData.forEach((element) {order.add(element.id);});
                          final orderx = await ProductService().placeOrder(widget.user!.id, order );
                          favoriteProvider.clearCart();
                          Provider.of<PastOrderProvider>(context, listen: false).pastOrderData = await ProductService().getProductsForUser(widget.user!.id);
                          onSuccess(orderx);

                          print(order);
                        },
                        child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white),
                            ),
                            margin: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 20),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text("Checkout", style: GoogleFonts.oswald(
                                color: const Color(0xFFDAEE01), fontSize:  MediaQuery.of(context).size.width * 0.015),)
                        ),
                      )
                          :const SizedBox.shrink()
                    ],
                  )
                ]
            )
        ),

      );
    }
    );
  }
  int billAmount(List<ProductModel>? item) {
    var total = 0;
    item?.forEach((element) {
      total += element.cost.round();
    });
    return total;
  }

  onSuccess(Order x) {
    if (x != null) {
      setState(() {
        orderId = x.id;
        orderPlaced = true;
      });
    }
  }
}