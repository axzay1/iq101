import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/filter_provider.dart';

class ChooseRange extends StatefulWidget {

  @override
  State<ChooseRange> createState() => _ChooseRangeState();
}

class _ChooseRangeState extends State<ChooseRange> {
  RangeValues _currentRangeValues = const RangeValues(0, 100);
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
          child: Text('Choose Range', style: GoogleFonts.oswald(color: Colors.white, fontSize: 18)),),
        Container(
          margin: const EdgeInsets.all(5),
          height: 30,
          child: RangeSlider(
            inactiveColor: Colors.white60,
            activeColor: const Color(0xFFDAEE01),
            values: _currentRangeValues,
            max: 100,
            divisions: 10,
            labels: RangeLabels(
              _currentRangeValues.start.round().toString(),
              _currentRangeValues.end.round().toString(),
            ),
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
                filterProvider?.setMaxCost(_currentRangeValues.end.toInt());
                filterProvider?.setMinCost(_currentRangeValues.start.toInt());
              });
            },
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Text('${_currentRangeValues.start.toInt()}'),
        //     Text('${_currentRangeValues.end.toInt()}'),
        //   ],
        // ),
      ],
    );
  }
}