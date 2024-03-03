import 'package:flutter/material.dart';

class SearchBarLandingZoopyWidget extends StatefulWidget {
  const SearchBarLandingZoopyWidget({super.key});

  @override
  State<SearchBarLandingZoopyWidget> createState() => _SearchBarLandingZoopyWidgetState();
}

class _SearchBarLandingZoopyWidgetState extends State<SearchBarLandingZoopyWidget> {
late TextEditingController searchController;

void initState(){
  super.initState();
  searchController = TextEditingController();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: searchController,
                cursorColor: Colors.red,
                decoration: const InputDecoration(
                  hintText: 'Search here',
                  border: InputBorder.none
                ),
              ),
            ),
            const Padding(
               padding:  EdgeInsets.all(8.0),
               child:  Icon(Icons.search, color: Colors.red,),
             )
          ],
        )
      )

    );
  }
}