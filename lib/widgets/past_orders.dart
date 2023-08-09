import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/providers/past_order_provider.dart';
import 'package:iq101/widgets/favorite_product_widget.dart';
import 'package:iq101/widgets/past_order_widget.dart';
import 'package:iq101/widgets/product_widget.dart';
import 'package:provider/provider.dart';

import '../model/product_model.dart';
import '../model/user_model.dart';
import '../providers/favorite_provider.dart';


class PastOrderDialog extends StatefulWidget {


  @override
  State<PastOrderDialog> createState() => _PastOrderDialogState();
}

class _PastOrderDialogState extends State<PastOrderDialog> {


  @override
  Widget build(BuildContext context) {
    return Consumer<PastOrderProvider>(builder: (context, pastOrderProvider, _)
    {
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
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFDAEE01)),
            ),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.70,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.4,

            child: Column(

                children: [
                  Padding(padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.trolley, size: 25,
                              color: Color(0xFFDAEE01),),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Past Orders", style: GoogleFonts.oswald(
                                fontSize: 25, color: const Color(0xFFDAEE01)),),
                          ),
                        ],
                      )
                  ),
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.58,
                    child:
                    pastOrderProvider.pastOrderData.isNotEmpty
                        ?ListView.builder(
                        itemCount:  pastOrderProvider.pastOrderData.length,
                        itemBuilder: (context, index) {
                          return PastOrderWidget(
                              product:  pastOrderProvider.pastOrderData[index]);
                        })
                        :Center(child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Card(
                        color: Colors.white24,
                        child: Padding(padding: const  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text('No Orders Yet!', style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.w400, color: const Color(0xFFDAEE01)),),
                        ),
                      ),
                    )),
                  ),
                ]
            )
        ),

      );
    }
    );
  }
}