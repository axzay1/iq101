import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';
import 'choose_color_widget.dart';

class ColorBall extends StatefulWidget {
  final ColorModel? color;

  ColorBall({Key? key, this.color}) : super(key: key);

  @override
  State<ColorBall> createState() => _ColorBallState();
}

class _ColorBallState extends State<ColorBall> {

  FilterProvider? filterProvider;

  @override
  void initState() {
    super.initState();
    filterProvider = Provider.of<FilterProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    List<String> colorN= filterProvider?.filterModel?.color ?? [];
    return InkWell(
      onTap: () {

        if(colorN.contains(widget.color?.name)){
          colorN.remove(widget.color?.name);
          filterProvider?.removeColor(widget.color!.name!);
        }
        else{
          colorN.add(widget.color!.name!);
          filterProvider?.addColor(widget.color!.name!);
        }

      },
      child: Container(
        margin: const EdgeInsets.all(5),
        height: 25,
        width: 25,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: colorN.contains(widget.color!.name!)
                ? const Color(0xFFDAEE01)
                : Colors.white10,
          ),
        ),
        child: Container(
          margin: const EdgeInsets.all(2),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.color?.color,
          ),
        ),
      ),
    );
  }
}
