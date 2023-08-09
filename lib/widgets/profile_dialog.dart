import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/Screen/landingpage.dart';
import 'package:iq101/providers/auth_provider.dart';

import 'package:iq101/providers/favorite_provider.dart';
import 'package:iq101/providers/filter_provider.dart';
import 'package:iq101/providers/product_provider.dart';
import 'package:iq101/widgets/past_order_widget.dart';
import 'package:iq101/widgets/past_orders.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../model/user_model.dart';

import 'package:flutter/material.dart';

import '../shared_prefs.dart';

class ProfileDialog extends StatefulWidget {
  final User user;
  final double right;
  final double top;
  // final Widget child;

  ProfileDialog({required this.right, required this.top,required this.user});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  FavoriteProvider? favoriteProvider;
  AuthProvider? authProvider;
  FilterProvider? filterProvider;
  ProductProvider? productProvider;


  @override
  void initState(){
    favoriteProvider = Provider.of<FavoriteProvider>(context, listen: false);
    authProvider = Provider.of<AuthProvider>(context, listen: false);
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    filterProvider = Provider.of<FilterProvider>(context, listen: false);

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, authProvider, _)
    {
      return Positioned(
          right: widget.right,
          top: widget.top,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.black,
              ),

              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(widget.user.name!,
                      style: GoogleFonts.oswald(color: Colors.white),),
                  ),
                  InkWell(
                    onTap: ()=> showPastOrders(),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Text("My Orders", style: GoogleFonts.oswald(
                          color: const Color(0xFFDAEE01)),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: InkWell(
                      onTap: () async {
                      if(authProvider.userDetails !=null) {
                        Provider.of<FavoriteProvider>(context, listen: false)
                            .resetFavorite();
                        Provider.of<FavoriteProvider>(context, listen: false)
                            .resetCart();
                        Provider.of<ProductProvider>(context, listen: false)
                            .resetProducts();

                        Provider.of<FilterProvider>(context, listen: false)
                            .resetFilter();
                        SharedPrefs().clearAllPrefs();
                        await SharedPrefs().removePrefs(
                          'userdetails',
                        );
                        // Use the context from the MaterialPageRoute's builder property
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()),
                              (Route<dynamic> route) => false,
                        );

                        await Future.delayed(const Duration(seconds: 2));
                      }
                      },
                      child: Text(
                        "Logout",
                        style: GoogleFonts.oswald(color: const Color(0xFFDAEE01)),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )
      );
    }
    );
  }
  void showPastOrders() {
    showDialog(
      context: context,
      builder: (_) {
        return PastOrderDialog();
      },
    );
  }
}

