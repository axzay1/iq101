import 'package:flutter/material.dart';
import 'package:iq101/providers/product_provider.dart';
import 'package:iq101/widgets/product_widget.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../model/user_model.dart';
import '../providers/favorite_provider.dart';

class ProductList extends StatefulWidget {
   List<ProductModel>? products;
   User? user;
   ProductList({super.key,  this.products, this.user});
  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  ProductProvider? productProvider;
  ProductModel? product;

  @override
  void initState(){
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen:false);
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel>?productList =  productProvider?.productData;
    return Container(
      padding: MediaQuery.of(context).size.width > 600 ? EdgeInsets.zero :  EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.1),
      height: 750,
      width: 800,
      child: ListView.builder(
          itemCount: productList?.length,
          itemBuilder: (context, index){
      return
        Consumer<FavoriteProvider>(builder: (context, favoriteProvider, _)
      {
        return
          ProductWidget(product: productList![index], user: widget.user,);
      }
        );
  }),
    );
}
}
