import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';

class PrintType extends StatefulWidget {
  String? print;
  PrintType({super.key,  this.print});

  @override
  State<PrintType> createState() => _PrintTypeState();
}

class _PrintTypeState extends State<PrintType> {
  FilterProvider? filterProvider;
  @override
  void initState() {
    super.initState();
     filterProvider = Provider.of<FilterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    // final check = widget.size;
    return InkWell(
      onTap: (){
        if(widget.print == "Solid"){
          filterProvider?.filterModel?.isPrinted = false;
        } else if(widget.print == "Printed") {
          filterProvider?.filterModel?.isPrinted =true;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color:
          Colors.white38),
        ),
        child: Container(
            padding: const EdgeInsets.all(1),
            margin: const EdgeInsets.all(2),
            height: 20,
            child: Center(child: Text(widget.print!, style: GoogleFonts.oswald(color: Colors.white),))
        ),
      ),
    );
  }
}
