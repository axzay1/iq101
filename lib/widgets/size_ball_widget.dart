import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';

class SizeBall extends StatefulWidget {

  String? size;
  SizeBall({super.key,  this.size});

  @override
  State<SizeBall> createState() => _SizeBallState();
}

class _SizeBallState extends State<SizeBall> {
  List<String> sizeN = [];
  FilterProvider? filterProvider;

  @override
  void initState() {
    super.initState();
    filterProvider = Provider.of<FilterProvider>(context, listen: false);
  }
  @override
  Widget build(BuildContext context) {
    sizeN= filterProvider?.filterModel?.size ?? [];
    return InkWell(
      onTap: (){
        if(sizeN.contains(widget.size)){
          sizeN.remove(widget.size);
          filterProvider?.removeSize(widget.size!);
          print("size added");
        }
        else{
          sizeN.add(widget.size!);
          filterProvider?.addSize(widget.size!);
          print("size added");
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color:
          sizeN.contains(widget.size)
          ?const Color(0xFFDAEE01)
          :Colors.white38),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          height: 20,
          width: 20,
        child: Center(child: Text(widget.size!, style: GoogleFonts.oswald(color: sizeN.contains(widget.size)
            ?const Color(0xFFDAEE01)
            :Colors.white),))
        ),
      ),
    );
  }
}


