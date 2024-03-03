import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/Screen/landing_fraction.dart';
import 'package:iq101/Screen/landing_zoopy.dart';
import 'package:iq101/main.dart';
import 'package:iq101/widgets/bid_widget.dart';
import 'package:iq101/widgets/design_elements/oval_clay_morphism.dart';
import 'package:iq101/widgets/design_elements/red_dot.dart';
import 'package:iq101/widgets/explore_widget.dart';
import 'package:iq101/widgets/gender_category_widget.dart';
import 'package:iq101/widgets/marketing_slider.dart';
import 'package:iq101/widgets/swipe_up_animation.dart';
import 'package:provider/provider.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';

import '../providers/auth_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/filter_provider.dart';
import '../providers/product_provider.dart';
import 'cap.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TikTokStyleFullPageScroller(
        contentSize: 4,
        builder: (context, index) {
          if (index == 0) {
            return const LandingZoopy();
          } else {
            return ExploreWidget(index: index);
          }
        },
      ),
    );
  }
}
