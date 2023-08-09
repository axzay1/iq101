import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/Screen/landingpage.dart';
import 'package:iq101/providers/auth_provider.dart';
import 'package:iq101/providers/favorite_provider.dart';
import 'package:iq101/providers/filter_provider.dart';
import 'package:iq101/providers/past_order_provider.dart';
import 'package:iq101/providers/product_provider.dart';
import 'package:iq101/service/user_service.dart';
import 'package:iq101/shared_prefs.dart';
import 'package:provider/provider.dart';


void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  static int hostid = 0;
  const MyApp({super.key, hostid});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> ProductProvider()),
        ChangeNotifierProvider(create: (_)=> FilterProvider()),
        ChangeNotifierProvider(create: (_)=> AuthProvider()),
        ChangeNotifierProvider(create: (_)=> FavoriteProvider()),
        ChangeNotifierProvider(create: (_)=> PastOrderProvider()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/home': (context) =>  LandingPage(),
        },
      ),
    );
  }
}



class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      backgroundColor: Colors.black,
      logo: const Image(image: AssetImage('assets/images/drip.gif'), height: 1000, width: 1000, fit: BoxFit.fill,),
      title:  Text(
        "HOOD STREETWEAR CO.",
        style: GoogleFonts.rubikSprayPaint(fontSize: MediaQuery.of(context).size.width * 0.04, color: Colors.white),
        // style: TextStyle(
        //     color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold),
      ),
      navigator: LandingPage(),
      durationInSeconds: 5,
      showLoader: false,
    );
  }
}