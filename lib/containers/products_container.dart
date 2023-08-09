

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/model/product_model.dart';
import 'package:iq101/providers/product_provider.dart';
import 'package:iq101/service/product_service.dart';
import 'package:iq101/widgets/product_list.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import '../providers/filter_provider.dart';

class ProductContainer extends StatefulWidget {
  final int? productType;

  final User? user;
// Add this callback function

  ProductContainer({
    Key? key,
    required this.productType,

    required this.user,
// Add this callback function
  }) : super(key: key);

  @override
  ProductContainerState createState() => ProductContainerState();
}

class ProductContainerState extends State<ProductContainer> {
  late Future<List<ProductModel>> productDetails;
  late List<ProductModel> productList;
  ProductProvider? productProvider;
  String? productType;
  FilterProvider? filterProvider;
  List<String> color = [];
  List<String> size = [];
  int? minCost;
  int? maxCost;

  @override
  void initState() {
    super.initState();
    filterProvider = Provider.of<FilterProvider>(context, listen: false);
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    getType(widget.productType!);
    getProduct(productType!);
    // getProductType(widget.productType!);
  }

  void getType(int type) {
    switch (type) {
      case 0:
        productType = "hoodie";
        break;
      case 1:
        productType = "cap";
        break;
      case 2:
        productType = "skate";
        break;
      default:
        productType = "hoodie"; // Default value
    }
  }

  void getProduct(String type) async {
    productProvider?.resetProducts();

    if (filterProvider?.filter == true) {
      productProvider?.setLoadingActive(true);
      await Future.delayed(Duration(seconds: 1));
      productProvider?.setProducts = await ProductService().filterProducts(
          type, color, size, filterProvider?.filterModel?.isPrinted, minCost,
          maxCost);

      // productProvider?.setProducts = await ProductService().filterProducts(type, filterProvider?.filterModel!.color, filterProvider?.filterModel!.size, filterProvider?.filterModel!.isPrinted, filterProvider?.filterModel!.minCost, filterProvider?.filterModel!.maxCost);
    }
    else {
      productProvider?.setLoadingActive(true);
      await Future.delayed(Duration(seconds: 1));
      productProvider?.setProducts = await ProductService().getAllType(type);

    }
  }

  void setVar() {
    if (filterProvider != null) {
      color = filterProvider?.filterModel?.color ??
          ["Red", "Green", "Black", "Blue", "Brown", "White"];
      size = filterProvider?.filterModel?.size ?? ["M", "S", "L", "XL", "XS"];
      maxCost = filterProvider?.filterModel?.maxCost ?? 100;
      minCost = filterProvider?.filterModel?.minCost ?? 0;
    }
  }


  void getProductType(int type) {
    if (type == 0) {
      productDetails = ProductService().getAllType("hoodie");
    } else if (type == 1) {
      productDetails = ProductService().getAllType("cap");
    } else if (type == 2) {
      productDetails = ProductService().getAllType("skate");
    }
  }


  @override
  void didUpdateWidget(covariant ProductContainer oldWidget) {
    setVar();
    super.didUpdateWidget(oldWidget);
    getType(widget.productType!);
    if (widget.productType != oldWidget.productType) {
      getProduct(productType!);
    } else {
      getProduct(productType!);
    } // Call the setFilter function when widget updates
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        if (provider?.isLoading == true) {
          productProvider?.setLoadingActive(false);
          return const  Center(
            child: CircularProgressIndicator(color: Color(0xFFDAEE01)),
          );
        } else if (provider?.productData != null && provider?.productData.isNotEmpty == true) {
          productProvider?.setLoadingActive(false);
          return ProductList(user: widget.user);
        } else {
          productProvider?.setLoadingActive(false);
          return Center(
            child: Card(
              color: Colors.white24,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'No Products Available!',
                  style: GoogleFonts.oswald(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}