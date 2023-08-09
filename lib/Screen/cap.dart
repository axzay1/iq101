import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/containers/products_container.dart';
import 'package:iq101/main.dart';
import 'package:iq101/model/product_model.dart';
import 'package:iq101/providers/auth_provider.dart';
import 'package:iq101/providers/filter_provider.dart';
import 'package:iq101/shared_prefs.dart';
import 'package:iq101/widgets/cart_dialog.dart';
import 'package:iq101/widgets/login_dialog.dart';
import 'package:provider/provider.dart';

import '../model/pref_status.dart';
import '../model/user_model.dart';
import '../providers/favorite_provider.dart';
import '../service/product_service.dart';
import '../service/user_service.dart';
import '../widgets/choose_color_widget.dart';
import '../widgets/choose_print_widget.dart';
import '../widgets/choose_range.dart';
import '../widgets/choose_size_widget.dart';

import '../widgets/favlist_dialog.dart';
import '../widgets/offer_widget.dart';
import '../widgets/profile_dialog.dart';
import '../widgets/recent_favorite.dart';

class Cap extends StatefulWidget {
  User? user;

  Cap({super.key, this.user});

  @override
  State<Cap> createState() => CapState();
}

class CapState extends State<Cap> {
  UserService userService = UserService();
  FilterProvider? filterProvider;
  int? productType;
  bool filter = false;
  bool up = false;

  @override
  void initState() {
    super.initState();
    filterProvider = Provider.of<FilterProvider>(context, listen: false);
    productType = 0;
  }

  @override
  void _setProductType(int type) {
    print(type);
    setState(() {
      productType = type;
    });
  }

  void _setFilter() {
    setState(() {
      filter = true;
    });
    print(filter);
  }

  @override
  Widget build(BuildContext context) {
    print(productType);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = screenWidth >= 600 ? 250 : screenWidth * 0.8;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Consumer<FavoriteProvider>(builder: (context, favoriteProvider, _) {
            return Row(
              children: [
                IconButton(
                    onPressed: () {
                      if (widget.user == null) {
                        showPopupNLogin(context);
                      } else {
                        // showPopupWLogin(context);
                        showFavorite(favoriteProvider.favoriteData);
                      }
                    },
                    icon: Stack(
                      children: [
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          size: 30,
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: favoriteProvider.favoriteData.isNotEmpty
                                ? CircleAvatar(
                                    radius: 8,
                                    backgroundColor: const Color(0xFFDAEE01),
                                    child: Text(
                                      favoriteProvider.favoriteData.length
                                          .toString(),
                                      style: GoogleFonts.oswald(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  )
                                : const SizedBox.shrink())
                      ],
                    )),
                IconButton(
                  onPressed: () {
                    if (widget.user == null) {
                      showPopupNLogin(context);
                    } else {
                      // showPopupWLogin(context);
                      showBag(favoriteProvider.cartData);
                    }
                  },
                  icon: Stack(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      Positioned(
                          top: 0,
                          right: 0,
                          child: favoriteProvider.cartData.isNotEmpty
                              ? CircleAvatar(
                                  radius: 8,
                                  backgroundColor: const Color(0xFFDAEE01),
                                  child: Text(
                                    favoriteProvider.cartData.length.toString(),
                                    style: GoogleFonts.oswald(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              : const SizedBox.shrink())
                    ],
                  ),
                ),
              ],
            );
          }),
          IconButton(
              onPressed: () {
                if (widget.user == null) {
                  showPopupNLogin(context);
                } else {
                  // showPopupWLogin(context);
                  profileDialog(context);
                }
              },
              icon: const Icon(Icons.manage_accounts_outlined,
                  color: Colors.white, size: 30)),
        ],
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: Colors.black,
        title: Text(
          "HOOD STREETWEAR CO.",
          style: GoogleFonts.rubikSprayPaint(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return buildLayout(MediaQuery.of(context).size.width);
          },
        ),
      ),
    );
  }

  void showPopupNLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return LoginWidget();
      },
    );
  }

  void showPopupWLogin(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfileDialog(
          right: 50,
          // Change the left and top values to position the dialog as needed
          top: 100,
          user: widget!.user!,
        );
      },
    );
  }

  void showFavorite(List<ProductModel> fav) {
    showDialog(
      context: context,
      builder: (_) {
        return FavList(user: widget!.user!, products: fav);
      },
    );
  }

  void showBag(List<ProductModel> fav) {
    showDialog(
      context: context,
      builder: (_) {
        return CartDialog(user: widget.user, products: fav);
      },
    );
  }

  void profileDialog(BuildContext context) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return ProfileDialog(
          right: 10,
          top: 60,
          user: widget.user!,
        );
      },
    );

    Overlay.of(context)?.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  Widget buildLayout(double screenWidth) {
    // Set a threshold screen width (you can adjust this based on your requirement)
    double thresholdWidth = 600;

    // Use MediaQuery to get the screen width and return Row or Column accordingly
    return screenWidth >= thresholdWidth
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (screenWidth > 600)
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Card(
                color: Colors.black38,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  _setProductType(2);
                                },
                                child: Image(
                                  height: screenWidth * 0.03,
                                  width: screenWidth * 0.03,
                                  image: const AssetImage(
                                      'assets/images/skate.png'),
                                ),
                              ),
                              productType == 2
                                  ? SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.01)
                                  : const SizedBox.shrink(),
                              productType == 2
                                  ? Container(
                                padding:
                                const EdgeInsets
                                    .all(5),
                                color: const Color(
                                    0xFFDAEE01),
                                height: screenWidth *
                                    0.0013,
                                width:
                                screenWidth * 0.03,
                              )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  _setProductType(0);
                                },
                                child: Image(
                                  height: screenWidth * 0.03,
                                  width: screenWidth * 0.03,
                                  image: const AssetImage(
                                      'assets/images/hoody.png'),
                                ),
                              ),
                              productType == 0
                                  ? SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.01)
                                  : const SizedBox.shrink(),
                              productType == 0
                                  ? Container(
                                padding:
                                const EdgeInsets
                                    .all(5),
                                color: const Color(
                                    0xFFDAEE01),
                                height: screenWidth *
                                    0.0013,
                                width:
                                screenWidth * 0.03,
                              )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          Column(
                            mainAxisAlignment:
                            MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () async {
                                  _setProductType(1);
                                },
                                child: Image(
                                  height: screenWidth * 0.03,
                                  width: screenWidth * 0.03,
                                  image: const AssetImage(
                                      'assets/images/cap.png'),
                                ),
                              ),
                              productType == 1
                                  ? SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height * 0.01)
                                  : const SizedBox.shrink(),
                              productType == 1
                                  ? Container(
                                padding:
                                const EdgeInsets
                                    .all(5),
                                color: const Color(
                                    0xFFDAEE01),
                                height: screenWidth *
                                    0.0013,
                                width:
                                screenWidth * 0.03,
                              )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Consumer<FilterProvider>(builder:
                        (context, filterProvider, _) {
                      return Container(
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.white),
                          ),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.all(10),
                                    child: Text(
                                      'Customize Gallery',
                                      style: GoogleFonts.oswald(
                                          color: Colors.white,
                                          fontSize: screenWidth *
                                              0.023),
                                    ),
                                  )),
                              ChooseColor(),
                              ChooseSize(),
                              ChoosePrint(),
                              ChooseRange(),
                              Center(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    if (filterProvider
                                        .filter ==
                                        true)
                                      Container(
                                        margin:
                                        const EdgeInsets
                                            .all(8),
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            12,
                                            vertical: 6),
                                        decoration:
                                        BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              5),
                                          border: Border.all(
                                              color: Colors
                                                  .white),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            Provider.of<FilterProvider>(
                                                context,
                                                listen:
                                                false)
                                                .setFilterActive(
                                                false);
                                            filterProvider
                                                .resetFilter();
                                            setState(() {});
                                          },
                                          child: Text(
                                            "Reset",
                                            style: GoogleFonts
                                                .oswald(
                                              color: Colors
                                                  .white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    Container(
                                      margin: const EdgeInsets
                                          .all(8),
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                          horizontal: 12,
                                          vertical: 6),
                                      decoration:
                                      BoxDecoration(
                                        borderRadius:
                                        BorderRadius
                                            .circular(5),
                                        border: Border.all(
                                            color:
                                            Colors.white),
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          filterProvider
                                              .setFilterActive(
                                              true);
                                          setState(() {});
                                        },
                                        child: Text(
                                          "Apply",
                                          style: GoogleFonts
                                              .oswald(
                                            color: const Color(
                                                0xFFDAEE01),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ));
                    }),
                    Consumer<FavoriteProvider>(builder:
                        (context, favoriteProvider, _) {
                      return favoriteProvider
                          .favoriteData.isNotEmpty
                          ? RecentFavorite(
                        image: favoriteProvider
                            .favoriteData.last.image,
                        name: favoriteProvider
                            .favoriteData.last.name,
                        createdBy: favoriteProvider
                            .favoriteData
                            .last
                            .createdBy,
                      )
                          : const SizedBox.shrink();
                    }),
                    Offer(),
                  ],
                ),
              ),
            ),
          ),
        Expanded(
          child: ProductContainer(
            productType: productType,
            user: widget.user,
          ),
        ),
      ],
    )
        : Stack(
      fit: StackFit.expand,
      children: [
        Expanded(
          child: ProductContainer(
            productType: productType,
            user: widget.user,
          ),
        ),
        SizedBox.expand(
          child: DraggableScrollableSheet(
            maxChildSize: 0.8,
            initialChildSize: up == true ? 0.7 : 0.12,
            minChildSize: 0.12,
            builder: (BuildContext context,
                ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Colors.black,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                    MainAxisAlignment.start,
                    children: [
                      up == false
                      ?InkWell(child: const Icon(Icons.keyboard_arrow_up_sharp, size: 20, color:  Color(
                          0xFFDAEE01)),onTap: (){
                        setState(() {
                          up = true;
                        });
                      })
                      : InkWell(child: const Icon(Icons.keyboard_arrow_down_outlined, size: 20, color:  Color(
                          0xFFDAEE01)),onTap: (){
                        setState(() {
                          up = false;
                        });
                      }),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    _setProductType(2);
                                  },
                                  child: Image(
                                    height:
                                    screenWidth * 0.1,
                                    width: screenWidth * 0.1,
                                    image: const AssetImage(
                                        'assets/images/skate.png'),
                                  ),
                                ),
                                productType == 2
                                    ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01)
                                    : const SizedBox.shrink(),
                                productType == 2
                                    ? Container(
                                  padding:
                                  const EdgeInsets
                                      .all(3),
                                  color: const Color(
                                      0xFFDAEE01),
                                  height: screenWidth *
                                      0.009,
                                  width:
                                  screenWidth * 0.1,
                                )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    _setProductType(0);
                                  },
                                  child: Image(
                                    height:
                                    screenWidth * 0.1,
                                    width: screenWidth * 0.1,
                                    image: const AssetImage(
                                        'assets/images/hoody.png'),
                                  ),
                                ),
                                productType == 0
                                    ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01)
                                    : const SizedBox.shrink(),
                                productType == 0
                                    ? Container(
                                  padding:
                                  const EdgeInsets
                                      .all(3),
                                  color: const Color(
                                      0xFFDAEE01),
                                  height: screenWidth *
                                      0.009,
                                  width:
                                  screenWidth * 0.1,
                                )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    _setProductType(1);
                                  },
                                  child: Image(
                                    height:
                                    screenWidth * 0.1,
                                    width: screenWidth * 0.1,
                                    image: const AssetImage(
                                        'assets/images/cap.png'),
                                  ),
                                ),
                                productType == 1
                                    ? SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.01)
                                    : const SizedBox.shrink(),
                                productType == 1
                                    ? Container(
                                  padding:
                                  const EdgeInsets
                                      .all(3),
                                  color: const Color(
                                      0xFFDAEE01),
                                  height: screenWidth *
                                      0.009,
                                  width:
                                  screenWidth * 0.1,
                                )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Consumer<FilterProvider>(builder:
                          (context, filterProvider, _) {
                        return Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white),
                            ),
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Center(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.all(
                                          10),
                                      child: Text(
                                        'Customize Gallery',
                                        style: GoogleFonts.oswald(
                                            color: Colors.white,
                                            fontSize:
                                            screenWidth *
                                                0.063),
                                      ),
                                    )),
                                ChooseColor(),
                                ChooseSize(),
                                ChoosePrint(),
                                ChooseRange(),
                                Center(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      if (filterProvider
                                          .filter ==
                                          true)
                                        Container(
                                          margin:
                                          const EdgeInsets
                                              .all(8),
                                          padding:
                                          const EdgeInsets
                                              .symmetric(
                                              horizontal:
                                              12,
                                              vertical:
                                              6),
                                          decoration:
                                          BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(
                                                5),
                                            border: Border.all(
                                                color: Colors
                                                    .white),
                                          ),
                                          child: InkWell(
                                            onTap: () async {
                                              Provider.of<FilterProvider>(
                                                  context,
                                                  listen:
                                                  false)
                                                  .setFilterActive(
                                                  false);
                                              filterProvider
                                                  .resetFilter();
                                              setState(() {});
                                            },
                                            child: Text(
                                              "Reset",
                                              style:
                                              GoogleFonts
                                                  .oswald(
                                                color: Colors
                                                    .white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      Container(
                                        margin:
                                        const EdgeInsets
                                            .all(8),
                                        padding:
                                        const EdgeInsets
                                            .symmetric(
                                            horizontal:
                                            12,
                                            vertical: 6),
                                        decoration:
                                        BoxDecoration(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              5),
                                          border: Border.all(
                                              color: Colors
                                                  .white),
                                        ),
                                        child: InkWell(
                                          onTap: () async {
                                            filterProvider
                                                .setFilterActive(
                                                true);
                                            setState(() {});
                                          },
                                          child: Text(
                                            "Apply",
                                            style: GoogleFonts
                                                .oswald(
                                              color: const Color(
                                                  0xFFDAEE01),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ));
                      }),
                      Consumer<FavoriteProvider>(builder:
                          (context, favoriteProvider, _) {
                        return favoriteProvider
                            .favoriteData.isNotEmpty
                            ? RecentFavorite(
                          image: favoriteProvider
                              .favoriteData.last.image,
                          name: favoriteProvider
                              .favoriteData.last.name,
                          createdBy: favoriteProvider
                              .favoriteData
                              .last
                              .createdBy,
                        )
                            : const SizedBox.shrink();
                      }),
                      Offer(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
