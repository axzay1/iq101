import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iq101/widgets/print_type_widget.dart';
import 'package:iq101/widgets/size_ball_widget.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';

class ChoosePrint extends StatefulWidget {

  @override
  State<ChoosePrint> createState() => _ChoosePrintState();
}

class _ChoosePrintState extends State<ChoosePrint> {

  List<String> print =  [
    "Solid", "Printed"
  ];
  FilterProvider? filterProvider;
  @override
  void initState() {
    super.initState();
    filterProvider = Provider.of<FilterProvider>(context, listen: false);
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Choose Print', style: GoogleFonts.oswald(color: Colors.white, fontSize: 18)),),
        SizedBox(
            height: 50,
            child: Row(
              children: [
                InkWell(
                  onTap: (){
                    if(filterProvider?.filterModel?.isPrinted == false){
                      filterProvider?.filterModel?.isPrinted = null;
                    } else {
                      filterProvider?.filterModel?.isPrinted = false;
                    }
                    setState(() {});
                   },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color:
                      filterProvider?.filterModel?.isPrinted == false
                          ?const Color(0xFFDAEE01)
                          :Colors.white),
                    ),
                    child: Container(
                        padding: const EdgeInsets.all(3),
                        height: 20,
                        child: Center(child: Text("Solid", style: GoogleFonts.oswald(color:
                        filterProvider?.filterModel?.isPrinted == false
                            ?const Color(0xFFDAEE01)
                            :Colors.white
                           ),))
                    ),
                  ),
                ),
                InkWell(
                  onTap: (){
                    if(filterProvider?.filterModel?.isPrinted == true){
                      filterProvider?.filterModel?.isPrinted = null;
                    } else {
                      filterProvider?.filterModel?.isPrinted = true;
                    }
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    height: 25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color:
                      filterProvider?.filterModel?.isPrinted == true
                          ?const Color(0xFFDAEE01)
                          :Colors.white
                          ),
                    ),
                    child: Container(
                        padding: const EdgeInsets.all(3),
                        height: 20,
                        child: Center(child: Text("Printed", style: GoogleFonts.oswald(color:
                        filterProvider?.filterModel?.isPrinted == true
        ?const Color(0xFFDAEE01)
                            :Colors.white
                            ),))
                    ),
                  ),
                ),
              ],
            )
        ),

      ],
    );
  }
}